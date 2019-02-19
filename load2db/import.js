const mysql = require('mysql2/promise');
//const request = require('request');
const moment = require('moment');
const fetch = require("node-fetch");

const db_connection_prop = {
  host: "localhost",
  user: "t",
  password: "t123456",
  database : 't'
};

var sensor_id = 9;
var year = 2019;

var sql_temperature_insert = "INSERT INTO temperatures (`date`, temperature, sensor_id) VALUES ?";
var sql_sensor_get = "SELECT * FROM sensors WHERE id=?";

console.log('Connecting to database: ', db_connection_prop.database);
mysql.createConnection(db_connection_prop)
    .then(function (connection){
        read_sensor_info(connection, sensor_id)
            .then(sensor => {
                console.log('sensor: ', sensor);
                import_year(connection, sensor, year)
                  .then(console.log)
                  .catch(console.error);
            })
            .catch(console.error);


    });

async function read_sensor_info (connection, sensor_id) {
    return connection.query(sql_sensor_get, [sensor_id]).then(function (rows, fields){
        return rows[0][0];
    });
}

async function import_year (connection, sensor, year) {
    for (var month=1; month<=12; month++){
        if (year == moment().year() && month-1 > moment().month()){
            break;
        }
        await import_month(connection, sensor, year, month);
    }
    return "done";
}

async function import_month (connection, sensor, year, month) {
    console.log('========== month=', month);
    var date = moment({ year:year, month:month-1});
    for (var day=1; day<=date.daysInMonth(); day++){
        await import_day(connection, sensor, year, month, day);
    }
    return "month done";
}

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


async function insert(connection, data) {
    //console.log('sql_temperature_insert', sql_temperature_insert);
    //console.log(data);
    return await connection.query(sql_temperature_insert, [data]);
}

