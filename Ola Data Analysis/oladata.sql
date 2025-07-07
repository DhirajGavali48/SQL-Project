create database ola;
use ola;
select * from oladata;
select count(*) from oladata;

#1.	Retrieve all successful bookings: 
select * from oladata where Booking_status ='success';

#2.	Find the average ride distance for each vehicle type: 
select vehicle_type ,avg(ride_distance) from oladata group by vehicle_type;

#3.	Get the total number of cancelled rides by customers: 
select count(*) from oladata where Booking_status ='Canceled by Customer';

#4.	List the top 5 customers who booked the highest number of rides: 
select count(customer_id) from oladata group by customer_id limit 5;
SELECT Customer_ID, COUNT(Booking_ID) as total_rides
FROM oladata
GROUP BY Customer_ID
ORDER BY total_rides Desc limit 5;

#5.	Get the number of rides cancelled by drivers due to personal and car-related issues: 
SELECT COUNT(*) as total_rides_cancelled
FROM Oladata
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';

#6.	Find the maximum and minimum driver ratings for Prime Sedan bookings: 
SELECT MAX(Driver_Ratings) as Max_Rating, MIN(Driver_Ratings) as Min_Rating
FROM oladata
WHERE Vehicle_Type = 'Prime Sedan';

#7.	Retrieve all rides where payment was made using UPI: 
SELECT *
FROM Oladata
WHERE Payment_Method = 'UPI';

#8.	Find the average customer rating per vehicle type: 
SELECT Vehicle_Type, AVG(Customer_Rating) as avg_customer_rating
FROM oladata
GROUP BY Vehicle_Type ;

#9.	Calculate the total booking value of rides completed successfully:
SELECT SUM(Booking_Value) as Total_booking_Value
FROM oladata
WHERE Booking_Status = 'Success';

#10.	List all incomplete rides along with the reason: 
SELECT Booking_ID, Incomplete_Rides_Reason
FROM oladata
WHERE Incomplete_Rides = 'Yes';

