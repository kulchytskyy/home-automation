const mysql = require('promise-mysql2');
const moment = require('moment');

var settings = require('./includes/settings');
var func = require('./includes/func');

var argv = require('minimist')(process.argv.slice(2));

var sensor_id = argv.sensor || argv.s;
console.log('sensor_id: ', sensor_id);

var months_cnt = argv.n || 1;
console.log('months count: ', months_cnt);

console.log('Connecting to database: ', settings.db_connection_prop.database);
mysql.createConnection(settings.db_connection_prop)
    .then(function (connection){
        if (!sensor_id){ 
          func.list_sensors(connection)
            .then(sensors => {
              process_sensors(connection, sensors[0])
                  .then(console.log)
                  .catch(console.error);
            })
            .catch(console.error);
        }
        else{
          func.read_sensor_info(connection, sensor_id)
            .then(sensor => {
                process_sensor(connection, sensor)
                  .then(console.log)
                  .catch(console.error);
              }
            )
            .catch(console.error);
        }
    });

async function process_sensors (connection, sensors) {
    for (let sensor of sensors){
        await process_sensor(connection, sensor);
    }
    return "all done!";
}

async function process_sensor (connection, sensor) {
    console.log('++++++++++ sensor: ', sensor.name);
    for (var i=months_cnt; i>=0; i--){
      var start_date = moment().subtract(i, 'months').startOf('month');
      console.log('start_date:',start_date);
      await func.delete_sensor_data(connection, sensor.id, start_date);
      await func.import_month(connection, sensor, start_date.year(), start_date.month()+1);
    }
    return "++++++++++ done "+sensor.name;
}
