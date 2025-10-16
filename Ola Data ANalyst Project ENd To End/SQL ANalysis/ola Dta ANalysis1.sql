CREATE TABLE ola_bookings_july (
    Date TIMESTAMP,
    Time TIME,
    Booking_ID VARCHAR(20) PRIMARY KEY, -- Primary Key, uniquely identifies a booking
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(15),
    Vehicle_Type VARCHAR(25),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT INTEGER, -- Vehicle Turnaround Time (seconds)
    C_TAT INTEGER, -- Customer Turnaround Time (seconds)
    Canceled_Rides_by_Customer TEXT, -- Reason for customer cancellation
    Canceled_Rides_by_Driver VARCHAR(100), -- Reason for driver cancellation
    Incomplete_Rides VARCHAR(5),
    Incomplete_Rides_Reason TEXT,
    Booking_Value DECIMAL(10, 2), -- Stored as a precise decimal for financial value
    Payment_Method VARCHAR(20),
    Ride_Distance DECIMAL(5, 2), -- Stored as a precise decimal (e.g., in km)
    Driver_Ratings NUMERIC(2, 1),
    Customer_Rating NUMERIC(2, 1),
    Vehicle_Images TEXT
);



copy ola_bookings_july 
FROM 'D:/Ola Data Analytics End to End Project/Bookings OLA - July.csv' 
WITH (FORMAT CSV, HEADER TRUE, NULL 'null');



select * from   ola_bookings_july;

--- Retrive All SUcsessfull Booking?
Create View  Sucsessfull_bookin AS
select  count(booking_status) as bookings from ola_bookings_july
where booking_status = 'Success';


--  Booking Cancel By Canceled by Customer

select  count(booking_status) as bookings from ola_bookings_july
where booking_status = 'Canceled by Customer'; 


select * from ola_bookings_july


--  Booking Cancel By Canceled by Driver
select  count(booking_status) as bookings from ola_bookings_july
where booking_status = 'Canceled by Driver';



--- Find The AVg ride distance for Each vechile type?


CREATE VIEW ride_distance_each_vehicle as
SELECT VEHICLE_TYPE , ROUND(AVG(ride_distance),2) as AVG_ride_distance
 FROM ola_bookings_july
Group by 1;

SELECT * FROM ride_distance_each_vehicle;


-- List the top 5 customers who booked the highest number of rides:


SELECT CUstomer_id , count(booking_id) as total_bookin from   ola_bookings_july
group by CUstomer_id order by total_bookin desc limit 5;


-- Get the number of rides cancelled by drivers due to personal and car-related issues:

SELECT COUNT(*) FROM ola_bookings_july
WHERE Canceled_Rides_by_Driver = 'Personal & Car
related issue';


-- Find the maximum and minimum driver ratings for Prime Sedan bookings:

Select * from  ola_bookings_july;

SELECT MAX(Driver_Ratings) as max_rating , min(Driver_Ratings) as min_rating 
from ola_bookings_july
WHERE Vehicle_Type = 'Prime Sedan'


SELECT 
    MAX(driver_ratings) AS max_rating, 
    MIN(driver_ratings) AS min_rating,
    AVG(driver_ratings) AS avg_rating
FROM ola_bookings_july
WHERE vehicle_type = 'Prime Sedan';


--Find the maximum and minimum driver ratings by vehicle type

SELECT 
    vehicle_type,
    MAX(driver_ratings) AS max_rating,
    MIN(driver_ratings) AS min_rating
FROM ola_bookings_july
GROUP BY vehicle_type;


-- Retrieve all rides where payment was made using UPI:

SELECT  * 
from ola_bookings_july
where payment_method = 'UPI';


SELECT payment_method, COUNT(*) AS total_bookings
FROM ola_bookings_july
WHERE payment_method = 'UPI'
GROUP BY payment_method;


-- Find the average customer rating per vehicle type:


SELECT 
     Vehicle_Type,
    ROUND(AVG(Customer_Rating),2) AS avg_Customer_rating
FROM ola_bookings_july
group by Vehicle_Type
Order BY  avg_Customer_rating DESC;

-- Find the average customer rating per vehicle type ANd TOTAL rides:

SELECT 
    vehicle_type,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
    COUNT(*) AS total_rides
FROM ola_bookings_july
GROUP BY vehicle_type
ORDER BY avg_customer_rating DESC;


--  Calculate the total booking value of rides completed successfully:

SELECT * from ola_bookings_july

SElect 
 SUm(Booking_Value) as total_successful_value 
FROM ola_bookings_july
WHERE  Booking_Status = 'Success'



--  Calculate the total booking value of rides completed successfully with Payment Type:

SELECT 
    payment_method,
    SUM(booking_value) AS total_successful_value
FROM ola_bookings_july
WHERE booking_status = 'Success'
GROUP BY payment_method;


-- List all incomplete rides along with the reason:

SELECT Booking_ID, Incomplete_Rides_Reason FROM ola_bookings_july 
WHERE Incomplete_Rides ='Yes';



-- 🚀 1. Performance & Behavior Insights

-- 🔹 a. Peak Booking Hours

-- Find out when most bookings happen:



SELECT 
    EXTRACT(HOUR FROM time) AS booking_hour,
    COUNT(*) AS total_bookings
FROM ola_bookings_july
GROUP BY booking_hour
ORDER BY total_bookings DESC;


--🔹 b. Average Booking Value by Vehicle Type

SELECT * from ola_bookings_july

SELECT 
    vehicle_type,
    ROUND(AVG(booking_value), 2) AS avg_value
FROM ola_bookings_july
GROUP BY vehicle_type
ORDER BY avg_value DESC;




SELECT 
    COALESCE(canceled_rides_by_customer, 'Driver/Other') AS cancel_reason,
    COUNT(*) AS total_canceled
FROM ola_bookings_july
WHERE booking_status = 'Cancelled'
GROUP BY cancel_reason
ORDER BY total_canceled DESC;

-- 📈 2. Customer & Driver Analysis


SELECT 
    driver_ratings,
    COUNT(*) AS ride_count
FROM ola_bookings_july
GROUP BY driver_ratings
ORDER BY driver_ratings DESC;

-- 💰 3. Financial & Revenue Insights

--🔹 a. Revenue by Vehicle Type

SELECT 
    vehicle_type,
    SUM(booking_value) AS total_revenue
FROM ola_bookings_july
WHERE booking_status = 'Success'
GROUP BY vehicle_type
ORDER BY total_revenue DESC;

--🔹 b. Average Fare per km (Efficiency Metric)
SELECT 
    vehicle_type,
    ROUND(SUM(booking_value) / SUM(ride_distance), 2) AS avg_fare_per_km
FROM ola_bookings_july
WHERE booking_status = 'Success' AND ride_distance > 0
GROUP BY vehicle_type
ORDER BY avg_fare_per_km DESC;



-- 🧠 4. Operational Metrics
-- 🔹 a. Average Turnaround Time (TAT)

SELECT 
    ROUND(AVG(v_tat), 2) AS avg_vehicle_tat,
    ROUND(AVG(c_tat), 2) AS avg_customer_tat
FROM ola_bookings_july;



--🔹 b. Relationship Between Rating & Booking Value (Helps see if higher-value rides have better ratings)
SELECT 
    ROUND(AVG(booking_value), 2) AS avg_value,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating
FROM ola_bookings_july
WHERE booking_status = 'Success';



-- 🔍 5. Trend & Time-Based Analysis
-- 🔹 a. Daily Revenue Trend
SELECT 
    DATE(date) AS booking_date,
    SUM(booking_value) AS total_revenue
FROM ola_bookings_july
WHERE booking_status = 'Success'
GROUP BY booking_date
ORDER BY booking_date;

-- 🔹 b. Success vs Cancel Ratio Over Time

SELECT 
    DATE(date) AS booking_date,
    SUM(CASE WHEN booking_status = 'Success' THEN 1 ELSE 0 END) AS success_count,
    SUM(CASE WHEN booking_status IN ('Canceled by Customer', 'Canceled by Driver') THEN 1 ELSE 0 END) AS cancelled_count
FROM ola_bookings_july
GROUP BY booking_date
ORDER BY booking_date;

