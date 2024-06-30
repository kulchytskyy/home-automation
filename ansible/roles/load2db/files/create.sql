CREATE TABLE temperatures (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    `date` DATETIME NOT NULL,
    temperature DECIMAL NOT NULL
);

CREATE TABLE sensors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    channel_id INT NOT NULL,
    field_num INT NOT NULL
);

ALTER TABLE temperatures MODIFY COLUMN temperature decimal(10,2) NOT NULL;

INSERT INTO sensors (name,channel_id,field_num) VALUES 
('living room',206671,1)
,('bathroom',206671,2)
,('outdoor',206671,3)
,('boiler ch temp',206671,4)
,('boiler outdoor',206671,5)
,('boiler activity',206671,6)
,('boiler dhw top',206671,7)
,('attic',373523,3)
,('kidroom',373523,4)
,('bathroom',373523,5)
;
INSERT INTO sensors (name,channel_id,field_num) VALUES 
('bedroom',373523,6)
,('kidroom2',373523,7)
,('hum',373523,8)
,('basement_laundry',632653,1)
,('boiler dhw bottom',206671,8)
,('basement_large',632653,2)
,('basement_boiler',632653,3)
,('1st floor',632653,4)
,('2nd_floor',632653,5)
,('co2',632653,6)
;
INSERT INTO sensors (name,channel_id,field_num) VALUES 
('hum_basement',1081443,1)
,('hum_living',1081443,2)
,('hum_outdoor',1081443,3)
,('hum_1st_floor',1081443,4)
,('hum_2nd_floor',1081443,5)
,('hum_basement_abs',1081443,6)
,('hum_living_abs',1081443,7)
,('hum_outdoor_abs',1081443,8)
;
