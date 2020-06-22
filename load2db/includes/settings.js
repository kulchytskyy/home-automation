const loadIniFile = require('read-ini-file')
const path = require('path')

const config_path = path.join(__dirname, '../ha_config.ini')
const config = loadIniFile.sync(config_path)
console.log(config.database.host)

exports.db_connection_prop = config.database;
