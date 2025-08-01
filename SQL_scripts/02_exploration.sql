-- ============================================================
-- Initial Exploration of the Data
-- ============================================================
-- Goal 1: Identify the total observations within each table

-- Inspect the first 5 rows of each table
SELECT * FROM ridership_l_stations LIMIT 10;

SELECT * FROM l_station_info LIMIT 10;

-- Query: Count the number of rows in the ridership table
-- Finding: There are over 1.25M rows in the ridership table
SELECT COUNT(*) FROM ridership_l_stations;

-- Query: Count the number of rows in the station_info table
-- Finding: There are 302 rows in the station_info table
SELECT COUNT(*) FROM l_station_info; 

-- Goal 2: Determine the number of null values in each table

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


-- Goal 3: Learn more about the duplicate rows in each table

-- Step 1: Determine the amount of duplicates
-- Finding: There are 618 duplicate rows. This will act as a subquery in a future query
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

-- Query: determine the range of rides values between duplicated rows in the ridership table
-- Finding: differences ranged from 1 to 500+. Because of the range of differences, I will calculate and use the average of the duplicate rows. 

-- STEP 1: Run query to calculate the differences in number of rides between duplicate rows
-- This query will be used as a subquery in the next query.
SELECT 
 	station_id,
 	ride_date,
 	MAX(rides) - MIN(rides) AS ride_diff,
  	COUNT(*) AS num_duplicates
FROM ridership_l_stations
GROUP BY station_id, ride_date
HAVING COUNT(*)> 1;

-- Step 2: Calculate the maximum, minimum, and average difference in number of rides for duplicate rows
-- Finding: The max difference was 583, the minimum difference was 1, and the average difference was 21.6
SELECT MAX(ride_diff) AS max_difference, MIN(ride_diff) AS min_difference, AVG(ride_diff) AS average_diff
FROM (
	SELECT 
	 	station_id,
	 	ride_date,
	 	MAX(rides) - MIN(rides) AS ride_diff,
	  	COUNT(*) AS num_duplicates
	FROM ridership_l_stations
	GROUP BY station_id, ride_date
	HAVING COUNT(*)> 1
);

-- ============================================================
-- Data Cleaning
-- ============================================================
-- Goal: Clean and de-duplicate CTA ridership data by averaging ride counts for duplicate rows

-- Step 1: Identify and extract duplicate rows from the ridership table
CREATE TABLE cleaned_ridership AS
WITH duplicates_table AS (
	SELECT r.station_id, r.station_name, r.ride_date, r.day_type, r.rides
	FROM ridership_l_stations AS r
	JOIN (
		SELECT station_id, ride_date
		FROM ridership_l_stations
		GROUP BY station_id, ride_date
		HAVING COUNT(*) > 1
	) AS dup
	ON r.station_id = dup.station_id AND r.ride_date = dup.ride_date
),

-- Step 2: Average the ride counts for each group of duplicate rows
averaged_duplicates AS (
	SELECT station_id, station_name, ride_date, day_type, CAST(AVG(rides) AS INT) AS rides
	FROM duplicates_table
	GROUP BY station_id, station_name, ride_date, day_type
),

-- Step 3: Select all rows that are not part of a duplicate group
unduplicated_ridership_l_stations AS (
	SELECT station_id, station_name, ride_date, day_type, rides
	FROM ridership_l_stations
	WHERE (station_id, ride_date) IN (
		SELECT station_id, ride_date
		FROM ridership_l_stations
		GROUP BY station_id, ride_date
		HAVING COUNT(*) = 1
	)
)

-- Step 4: Combine the deduplicated rows with the averaged duplicates
SELECT * FROM unduplicated_ridership_l_stations
UNION ALL
SELECT * FROM averaged_duplicates;

-- Confirming the table saved successfully
SELECT * 
FROM cleaned_ridership
LIMIT 10;

-- ============================================================
-- Merge station-level metadata with cleaned ridership records
-- ============================================================

-- Goal: Join cleaned_ridership table with l_station_info table
-- Step 1: Identify the appropriate key for joining

-- Query: Checking to see if station_id and stop_id are matching keys
-- Finding: Output a table with zero rows, so station_id and stop_id are not the correct keys to match on
SELECT cleaned_ridership.station_id, l_station_info.stop_id FROM cleaned_ridership
INNER JOIN l_station_info
	ON cleaned_ridership.station_id = l_station_info.stop_id;

-- Query: Trying station_id and map_id
-- Finding: There is overlap between station_id nad map_id, which indicates that this may be the correct keys to join on
SELECT cleaned_ridership.station_id, l_station_info.map_id FROM cleaned_ridership
INNER JOIN l_station_info
	ON cleaned_ridership.station_id = l_station_info.map_id;

-- Query: Count the number of unique station_ids in cleaned_ridership
-- Finding: There are 148 unique station_ids
SELECT DISTINCT station_id FROM cleaned_ridership;

-- Query: Count the number of unique map_ids in l_station_info
-- Finding: There are 144 unique map_ids
SELECT DISTINCT map_id FROM l_station_info;

-- Query: Return all unique (station_id, map_id) pairs where station_id matches map_id
-- Finding: There are 144 unique station_ids that match map_ids
SELECT DISTINCT cleaned_ridership.station_id, l_station_info.map_id
FROM cleaned_ridership
INNER JOIN l_station_info
  ON cleaned_ridership.station_id = l_station_info.map_id;

-- Query: Return station_ids in cleaned_ridership that do not match any map_ids in l_station_info
-- Finding: The four unmatched station_ids are stations that were at one point active, but now closed
SELECT DISTINCT cleaned_ridership.station_id, cleaned_ridership.station_name
FROM cleaned_ridership
LEFT JOIN l_station_info
	ON cleaned_ridership.station_id = l_station_info.map_id
WHERE l_station_info.map_id IS NULL;

-- Query: Delete the four inactive stations from the cleaned_ridership table
DELETE FROM cleaned_ridership
WHERE station_id IN (40500, 40640, 41580, 40200);

-- Query: Confirming that the rows with the inactive stations were succesfully removed
SELECT DISTINCT station_id
FROM cleaned_ridership
WHERE station_id IN (40500, 40640, 41580, 40200);

-- Step 2: Use a LEFT JOIN to merge cleaned_ridership (left) with l_station_info (right)
CREATE TABLE final_ridership AS (
	SELECT 
		ridership.station_id,
		stations.map_id,
		stations.station_descriptive_name, 
		ridership.ride_date, ridership.day_type,
		ridership.rides,
		stations.ada_approved,
		stations.red, 
		stations.blue, 
		stations.green, 
		stations.brownn, 
		stations.purple, 
		stations.pexp, 
		stations.yellow,
		stations.pnk, 
		stations.orange,
		stations.location
	FROM cleaned_ridership AS ridership
	LEFT JOIN (
		SELECT DISTINCT ON (map_id) *
		FROM l_station_info
		ORDER BY map_id, direction_id
	) AS stations
	ON ridership.station_id = stations.map_id
);

-- Query: Checks for duplicate rows in new table
-- Finding: The returned table had zero rows, indicating that there are no duplicates
SELECT station_id, ride_date, COUNT(*) AS dup_count
FROM final_ridership
GROUP BY station_id, ride_date
HAVING COUNT(*) > 1;