const mysql = require('promise-mysql2');
const moment = require('moment');

var settings = require('./includes/settings');
var func = require('./includes/func');

console.log('Connecting to database: ', settings.db_connection_prop.database);
mysql.createConnection(settings.db_connection_prop)
    .then(function (connection){
        func.list_sensors(connection)
            .then(sensors => {
              process(connection, sensors[0])
                  .then(console.log)
                  .catch(console.error);
            })
            .catch(console.error);
    });

async function process (connection, sensors) {
    for (let sensor of sensors){
        await process_sensor(connection, sensor);
    }
    return "all done!";
}

async function process_sensor (connection, sensor) {
    console.log('++++++++++ sensor: ', sensor.name);
    for (var i=1; i>=0; i--){
      var start_date = moment().subtract(i, 'months').startOf('month');
      console.log('start_date:',start_date);
      await func.delete_sensor_data(connection, sensor.id, start_date);
      await func.import_month(connection, sensor, start_date.year(), start_date.month()+1);
    }
    return "++++++++++ done "+sensor.name;
}
