-- Inspect the first 5 rows of each table
SELECT * FROM ridership_l_stations LIMIT 10;

SELECT * FROM l_station_info LIMIT 10;

-- Query: Count the number of rows in the ridership table
-- Finding: There are over 1.25M rows in the ridership table
SELECT COUNT(*) FROM ridership_l_stations;

-- Query: Count the number of rows in the station_info table
-- Finding: There are 302 rows in the station_info table
SELECT COUNT(*) FROM l_station_info; 

-- Query: Count the number of null values in all columns of the ridership table
-- Finding: There are zero nulls in each column of the ridership table
SELECT 
	SUM(CASE WHEN station_id IS NULL THEN 1 ELSE 0 END) AS station_id_nulls,
	SUM(CASE WHEN station_name IS NULL THEN 1 ELSE 0 END) AS station_name_nulls,
	SUM(CASE WHEN ride_date IS NULL THEN 1 ELSE 0 END) AS ride_date_nulls,
	SUM(CASE WHEN day_type IS NULL THEN 1 ELSE 0 END) AS day_type_nulls,
	SUM(CASE WHEN rides IS NULL THEN 1 ELSE 0 END) AS rides_nulls
FROM ridership_l_stations; 

-- Query: Count the number of null values in a sample of columns in the station_info table
-- Finding: There are zero nulls in the specified columns of L_station_info
SELECT 
	SUM(CASE WHEN stop_id IS NULL THEN 1 ELSE 0 END) AS stop_id_nulls,
	SUM(CASE WHEN direction_id IS NULL THEN 1 ELSE 0 END) AS direction_id_nulls,
	SUM(CASE WHEN stop_name IS NULL THEN 1 ELSE 0 END) AS stop_name_nulls,
	SUM(CASE WHEN station_name IS NULL THEN 1 ELSE 0 END) AS station_name_nulls,
	SUM(CASE WHEN map_id IS NULL THEN 1 ELSE 0 END) AS map_id
FROM l_station_info;


-- Query Goal: check for duplicates in ridership table

-- Step 1: determine the amount of duplicates
-- Finding: There are 618 duplicate rows
SELECT station_id, ride_date, COUNT(*) AS dup_count
	FROM ridership_l_stations
	GROUP BY station_id, ride_date
	HAVING COUNT(*) > 1;

-- Step 2: Learn more information about the duplicated rows
-- Output: Expands the output from the previous query. Previously we only saw 618 rows, now we see 1236 rows, so essentially we are seeing 
-- every row that has a duplicate. Dup_count = 2 just means there's another row in the table that shares the same station_id and ride_date
SELECT *
FROM ridership_l_stations
JOIN (
	SELECT station_id, ride_date, COUNT(*) AS dup_count
	FROM ridership_l_stations
	GROUP BY station_id, ride_date
	HAVING COUNT(*) > 1
	) AS dup_tuples
ON ridership_l_stations.station_id = dup_tuples.station_id
AND ridership_l_stations.ride_date = dup_tuples.ride_date
ORDER BY ridership_l_stations.station_id, ridership_l_stations.ride_date;

-- Query: To verify that the dup_count for each duplicate is just 2, and there's no triple duplicates or more: 
-- Finding: The table returned zero rows which confirms that each duplicate only has 1 other row with shared station_id and ride_date
SELECT *
FROM ridership_l_stations
JOIN (
	SELECT station_id, ride_date, COUNT(*) AS dup_count
	FROM ridership_l_stations
	GROUP BY station_id, ride_date
	HAVING COUNT(*)> 2
	) AS dup_tuples
ON ridership_l_stations.station_id = dup_tuples.station_id
AND ridership_l_stations.ride_date = dup_tuples.ride_date
ORDER BY ridership_l_stations.station_id, ridership_l_stations.ride_date;

-- determine the range of rides values between duplicated rows in the ridership table
SELECT station_id, ride_date, 

---- To determine the keys in each table to join on

-- Query: Inspect difference between stop_name and station_name
-- Finding: The stop_name column includes the direction the train is going at the station
SELECT stop_name, station_name
FROM l_station_info;

-- Query: Tests which key to join both tables on
-- Finding: 
SELECT COUNT(*)
FROM (
	SELECT DISTINCT station_id FROM ridership_l_stations
	INTERSECT
	SELECT DISTINCT stop_id FROM l_station_info
) AS matched_ids;

-- this gives a clue that the station_id and map_id will be the keys to match on
SELECT COUNT(*)
FROM (
	SELECT DISTINCT station_id FROM ridership_l_stations
	INTERSECT
	SELECT DISTINCT map_id FROM l_station_info
) AS matched_ids;