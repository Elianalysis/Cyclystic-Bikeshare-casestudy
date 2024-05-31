-- PROCESS -- 

--- Removing nulls ---

USE divvy_tripdata
GO

SELECT 
		*
INTO	all_tripsv2
FROM		
		[all_trips]
WHERE
		start_station_name IS NOT NULL
	AND end_station_name IS NOT NULL
	AND rideable_type IS NOT NULL 
	AND end_station_id IS NOT NULL
	AND start_station_id IS NOT NULL
	AND start_lng IS NOT NULL
	AND start_lat IS NOT NULL
	AND end_lng IS NOT NULL
	AND end_lat IS NOT NULL;


-- Adding columns for hour,date,trip_length, and month -- 

USE divvy_tripdata
GO


SELECT
	 ride_id
    ,rideable_type
    ,started_at
    ,ended_at
    ,start_station_name
    ,start_station_id
    ,end_station_name
    ,end_station_id
    ,start_lat
    ,start_lng
    ,end_lat
    ,end_lng
    ,member_casual
	,CAST(started_at as date) as start_date
	,CAST(ended_at as date)as end_date
	,DATEPART(hour, started_at) as start_hour
	,DATEPART(hour, ended_at) as end_hour
	,DATENAME(month,started_at) as trip_month
	,DATENAME(weekday, started_at) as day_of_week
	,DATEDIFF(mi,started_at,ended_at) as trip_length_mins
INTO
	all_trips_clean
FROM 
	[all_tripsv2]



-- Check if any valeus in trip duration are 0 or less than zero-- 
SELECT
trip_length_mins
FROM 
	[all_trips_clean]
WHERE 
	trip_length_mins <=0

-- Delete values that are 0 or less in trip_length because there were times divvy took the bikes out for quality control--

DELETE
FROM [all_trips_clean]
WHERE
	trip_length_mins <=0

-- Make sure all rows with 0 values are deleted
SELECT
trip_length
FROM 
	[all_trips_clean]
WHERE 
	trip_length <=0


