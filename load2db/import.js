const mysql = require('promise-mysql2');
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
                if (year == 'all'){
                  import_all_years(connection, sensor)
                      .then(console.log)
                      .catch(console.error);
                 }
                else{
                    func.import_year(connection, sensor, year)
                      .then(console.log)
                      .catch(console.error);
                }
            })
            .catch(console.error);
    });


async function import_all_years (connection, sensor) {
    for (var i=2020; i<=moment().year(); i++){
      console.log("###### YEAR: "+i);
      await func.import_year(connection, sensor, i);
    }
    return "all done!";
}
