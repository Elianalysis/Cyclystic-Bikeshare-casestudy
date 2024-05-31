--- DESCRPTIVE ANALYSIS ---

USE divvy_tripdata
GO

-- MEDIAN TRIP LENGTH -- 

SELECT DISTINCT
PERCENTILE_DISC(0.5)
	WITHIN GROUP 
		(ORDER BY trip_length_mins) OVER() AS 'Median',
member_casual
FROM
	[all_trips_clean]
WHERE
	member_casual = 'casual'
GROUP BY
	member_casual,
	trip_length_mins
ORDER BY
	member_casual;

SELECT
PERCENTILE_DISC(0.5)
	WITHIN GROUP 
		(ORDER BY trip_length_mins) OVER(PARTITION BY member_casual) AS 'Median',
trip_length_mins
FROM
	[all_trips_clean]
GROUP BY
	member_casual,
	trip_length_mins
ORDER BY
	member_casual;


-- MAX TRIP LENGTH -- 

SELECT DISTINCT
	MAX(
		trip_length_mins) AS 'Max',
		member_casual
FROM all_trips_clean
GROUP BY
	member_casual;

-- MIN TRIP LENGTH -- 

SELECT DISTINCT
	MIN(
		trip_length_mins) AS 'Min',
		member_casual
FROM all_trips_clean
GROUP BY
	member_casual

-- MEAN TRIP LENGTH -- 

SELECT DISTINCT
	AVG(
		trip_length_mins) AS 'Mean',
		member_casual
FROM 
	all_trips_clean
GROUP BY
	member_casual;

-- BUSIEST DAY TABLE --
USE divvy_tripdata
GO

SELECT 
DISTINCT 
	member_casual, 
	day_of_week, 
	ROW_NUMBER() OVER (PARTITION BY member_casual ORDER BY COUNT(day_of_week) DESC) rn
INTO busiest_day
FROM
	[all_trips_clean]
GROUP BY
member_casual,
start_hour
ORDER BY
member_casual DESC ;


-- BUSIEST DAY --

SELECT TOP 2
	day_of_week,
	member_casual,
	rn
FROM
	[busiest_day_riders]
	WHERE
	rn = 1
GROUP BY
	day_of_week,
	member_casual,
	rn
ORDER BY
member_casual DESC ;

--  TOTAL TRIPS AND PERCENT OF TOTAL --
USE divvy_tripdata
GO

SELECT
	member_casual AS rider_type,
	COUNT(member_casual) AS total_rides,
	ROUND(COUNT(member_casual) * 100.0/ SUM(COUNT(member_casual))
	OVER(),0) AS percentage
FROM 
	[all_trips_clean]
GROUP BY
	member_casual
ORDER BY 
	member_casual;

-- NUMBER OF TRIPS PER MONTH -- 

SELECT 
	COUNT(ride_id) AS total_rides,
	trip_month
   ,member_casual
FROM
	[all_trips_clean]
GROUP BY
	trip_month
   ,member_casual
ORDER BY
	trip_month
   ,member_casual;


-- NUMBER OF TRIPS WEEK --

SELECT 
	day_of_week
   ,member_casual
   ,COUNT(member_casual) as total_trips
   FROM
	[all_trips_clean]
GROUP BY
	day_of_week
   ,member_casual
ORDER BY
	day_of_week
   ,member_casual;

-- NUMBER OF RIDES BY BIKE TYPE AND RIDER --

SELECT
	rideable_type as Bike_Type,
	member_casual as Rider_Type,
	COUNT(rideable_type) as total_trips
FROM
	[all_trips_clean]
GROUP BY
	rideable_type,
	member_casual
ORDER BY
	rideable_type,
	member_casual;

-- NUMBER OF TRIPS BY HOUR OF DAY -- 

SELECT
		member_casual as Rider_type,
		start_hour as hour_of_day,
		COUNT(start_hour) as total_trips
FROM
		[all_trips_clean]
GROUP BY
		start_hour,
		member_casual
ORDER BY
		member_casual,
		start_hour;	

-- AVG LENGTH DAY OF WEEK -- 
SELECT
	day_of_week,
	member_casual,
	ROUND(AVG(trip_length_mins),2) AS avg_trip_length
FROM
	[all_trips_clean]
GROUP BY
	day_of_week,
	member_casual
ORDER BY
	day_of_week,
	member_casual;

-- AVG TRIPS HOUR --
USE divvy_tripdata
GO

SELECT
	day_of_week,
	member_casual,
	start_hour,
	ROUND(AVG(trip_length_mins),2) AS avg_length
FROM 
	[all_trips_clean]
GROUP BY
	day_of_week,
	member_casual,
	start_hour
ORDER BY
	day_of_week,
	member_casual;

-- AVG TRIP LENGTH BY MONTH -- 
SELECT
	trip_month,
	member_casual,
	ROUND(AVG(trip_length_mins),2) AS avg_trip_length
FROM
	[all_trips_clean]
GROUP BY
	trip_month,
	member_casual
ORDER BY
	trip_month,
	member_casual;

-- AVG LENGTH RIDEABLE TYPE - member -- 

SELECT
	rideable_type as Bike_Type,
	member_casual as Rider_Type,
	ROUND(AVG(trip_length_mins),2) AS avg_trip_length
FROM
	[all_trips_clean]
WHERE
	member_casual = 'member'
GROUP BY
	rideable_type,
	member_casual
ORDER BY
	rideable_type,
	member_casual;

-- AVG TRIP LENGTH RIDEABLE TYPE - casual -- 

SELECT
	rideable_type as Bike_Type,
	member_casual as Rider_Type,
	ROUND(AVG(trip_length_mins),2) AS avg_trip_length
FROM
	[all_trips_clean]
WHERE
	member_casual = 'casual'
GROUP BY
	rideable_type,
	member_casual
ORDER BY
	rideable_type,
	member_casual;

-- TOP 10 START STATIONS -member --

SELECT TOP 10
	start_station_name as start_stations,
	member_casual,
	COUNT(start_station_name) as total_trips
FROM
	[all_trips_clean]
WHERE
	member_casual = 'member'
GROUP BY
	start_station_name,
	member_casual
ORDER BY
	COUNT(start_station_name) DESC;

-- TOP 10 END STATIONS -member --

SELECT TOP 10
	end_station_name as end_stations,
	member_casual,
	COUNT(end_station_name) as total_trips
FROM
	[all_trips_clean]
WHERE
	member_casual = 'member'
GROUP BY
	end_station_name,
	member_casual
ORDER BY
	COUNT(end_station_name) DESC;

-- TOP 10 START STATIONS -casual --

SELECT TOP 10
	start_station_name as start_stations,
	member_casual,
	COUNT(start_station_name) as total_trips
FROM
	[all_trips_clean]
WHERE
	member_casual = 'casual'
GROUP BY
	start_station_name,
	member_casual
ORDER BY
	COUNT(start_station_name) DESC;
	
-- TOP 10 end stations -casual --

SELECT TOP 10
	end_station_name as end_stations,
	member_casual,
	COUNT(end_station_name) as total_trips
FROM
	[all_trips_clean]
WHERE
	member_casual = 'casual'
GROUP BY
	end_station_name,
	member_casual
ORDER BY
	COUNT(end_station_name) DESC;
