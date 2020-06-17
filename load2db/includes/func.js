const moment = require('moment');
const fetch = require("node-fetch");

async function read_sensor_info (connection, sensor_id) {
    const sql = "SELECT * FROM sensors WHERE id=?";
    return await connection.query(sql, [sensor_id]).then(function (rows, fields){
        return rows[0][0];
    });
}
exports.read_sensor_info = read_sensor_info;

async function list_sensors (connection) {
    const sql = "SELECT * FROM sensors ORDER BY id";
    return await connection.query(sql, []).then(function (rows, fields){
        return rows;
    });
}
exports.list_sensors = list_sensors;

async function delete_sensor_data (connection, sensor_id, start_date) {
    console.log('delete_sensor_data', sensor_id, start_date);
    const sql = "DELETE FROM temperatures WHERE sensor_id=? AND `date`>?";
    var d = start_date.format('YYYY-MM-DD+HH:mm:ss');
    await connection.query(sql, [sensor_id, d]).then(function (rows, fields){
        console.log('deleted: ', start_date);
        return rows;
    });
    return "delete done";
}
exports.delete_sensor_data = delete_sensor_data;

async function import_year (connection, sensor, year) {
    for (var month=1; month<=12; month++){
        if (year == moment().year() && month-1 > moment().month()){
            break;
        }
        await import_month(connection, sensor, year, month);
    }
    return "year done";
}
exports.import_year = import_year;

async function import_month (connection, sensor, year, month) {
    console.log('========== month=', month, year);
    var currDate = moment();
    var date = moment({ year:year, month:month-1});
    for (var day=1; day<=date.daysInMonth(); day++){
        if (day > currDate.date() && currDate.month() == month-1 && currDate.year() == year){
            console.log("Stopped on current date");
            break;
        }
        await import_day(connection, sensor, year, month, day);
    }
    return "month done";
}
exports.import_month = import_month;

async function import_day(connection, sensor, year, month, day){
    console.log('********** day=', day);
    var date = moment({ year:year, month:month-1, day: day });

    var start = date.format('YYYY-MM-DD+HH:mm:ss');
    var end = date.format('YYYY-MM-DD+23:59:59');
    var url = 'https://api.thingspeak.com/channels/'+sensor.channel_id+'/fields/'+sensor.field_num+'.json?start='+start+'&end='+end;

    console.log('Fetching data from:', url);

    var data = [];
    const response = await fetch(url);
    const json = await response.json();
    //console.log('json', json);

    if (json.feeds && json.feeds.length > 0){
        json.feeds.forEach(
            function (row){
                var date = moment.utc(row['created_at']).format("YYYY-MM-DD HH:mm:ss");
                var temperature = row['field'+sensor.field_num];
                //console.log(date+'='+temperature);
                if (temperature == null || !temperature.length){
                    //console.log('Empty temperature value');
                    return;
                }
                var row = [date, temperature, sensor.id];
                data.push(row);
            }
        );

        if (data.length){
            return insert(connection, data).then(console.log).catch(console.error);;
        }
        else{
            return "no valid data";
        }
    }
    else{
        return "no data";
    }
}
exports.import_day = import_day;

async function insert(connection, data) {
    const sql_temperature_insert = "INSERT INTO temperatures (`date`, temperature, sensor_id) VALUES ?";
    //console.log('sql_temperature_insert', sql_temperature_insert);
    //console.log(data);
    return await connection.query(sql_temperature_insert, [data]);
}
exports.insert = insert;
