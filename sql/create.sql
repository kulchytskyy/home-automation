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

insert into sensors (name, channel_id, field_num)
values 
	('living room', 206671, 1),
	('bathroom', 206671, 2),
	('outdoor', 206671, 3),
	('boiler ch temp', 206671, 4),
	('boiler outdoor', 206671, 5),
	('boiler activity', 206671, 6),
	('boiler top buffer', 206671, 7),
	('attic', 373523, 3),
	('kidroom', 373523, 4),
	('bathroom', 373523, 5),
	('bedroom', 373523, 6),
	('kidroom2', 373523, 7),
	('hum', 373523, 8),
	('basement1', 632653, 1)
