const mysql = require('mysql2/promise');
const moment = require('moment');

var settings = require('./includes/settings');
var func = require('./includes/func');

var argv = require('minimist')(process.argv.slice(2));

var sensor_id = argv.sensor || argv.s;
console.log('sensor_id: ', sensor_id);

var year = argv.year || argv.y || moment().year();
console.log('year: ', year);

console.log('Connecting to database: ', settings.db_connection_prop.database);
mysql.createConnection(settings.db_connection_prop)
    .then(function (connection){
        func.read_sensor_info(connection, sensor_id)
            .then(sensor => {
                console.log('sensor: ', sensor);
                func.import_year(connection, sensor, year)
                  .then(console.log)
                  .catch(console.error);
            })
            .catch(console.error);
    });

