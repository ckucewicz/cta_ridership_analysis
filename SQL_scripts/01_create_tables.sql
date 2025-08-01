CREATE TABLE ridership_L_stations (
	station_id INT,
	station_name VARCHAR(100),
	ride_date DATE,
	day_type VARCHAR(1),
	rides INT
);

CREATE TABLE L_station_info (
	stop_id INT PRIMARY KEY,
	direction_id VARCHAR(1),
	stop_name VARCHAR(100),
	station_name VARCHAR(100),
	station_descriptive_name VARCHAR(150),
	map_id INT, 
	ada_approved BOOLEAN,
	red BOOLEAN, 
	blue BOOLEAN,
	green BOOLEAN,
	brown BOOLEAN,
	purple BOOLEAN,
	pexp BOOLEAN,
	yellow BOOLEAN,
	pnk BOOLEAN, 
	orange BOOLEAN,
	location TEXT
);