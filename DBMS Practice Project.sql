/*
A travel company TravelOnTheGo maintains the record of passengers and price to travel between two cities, for bus types
(Sitting and Sleeper).
1)	You are required to create two tables PASSENGER and PRICE with the following attributes and properties 
*/

create database travelongo;

use travelongo;

-- 1 --
create table PASSENGER (
Id int auto_increment primary key,
Passenger_name    varchar(20),
Category          varchar(20),
Gender            varchar(20),
Boarding_City     varchar(20),
Destination_City  varchar(20), 
Distance          int,
Bus_Type          varchar(20)
);

create table PRICE (
Bus_Type         varchar(20),
Distance         int,
Price            int
);

-- 2 --
insert into passenger values(default,'Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper');
insert into passenger values(default,'Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting');
insert into passenger values(default,'Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper');
insert into passenger values(default,'Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper');
insert into passenger values(default,'Udi','Non-AC','M','Trivandrum','panaji',1000,'Sleeper');
insert into passenger values(default,'Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting');
insert into passenger values(default,'Hemant','Non-AC','M','panaji','Mumbai',700,'Sleeper');
insert into passenger values(default,'Manish ','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting');
insert into passenger values(default,'Piyush','AC','M','Pune','Nagpur',700,'Sitting');

select * from passenger;

insert into price values('Sleeper','350',770);
insert into price values('Sleeper','500',1100);
insert into price values('Sleeper','600',1320);
insert into price values('Sleeper','700',1540);
insert into price values('Sleeper','1000',2200);
insert into price values('Sleeper','1200',2640);
insert into price values('Sleeper','1500',2700);
insert into price values('Sitting','500',620);
insert into price values('Sitting','600',744);
insert into price values('Sitting','700',868);
insert into price values('Sitting','1000',1240);
insert into price values('Sitting','1200',1488);
insert into price values('Sitting','1500',1860);

/*
3)	How many females and how many male passengers travelled for a minimum distance of 600 KM s?
*/
 
 select Gender, count(Gender) as Count FROM Passenger where Distance >= 600 group by Gender;


/*
4)	Find the minimum ticket price for Sleeper Bus. 
*/

select min(Price) as Minimum_Price from Price where Bus_Type = 'Sleeper';


/*
5)	Select passenger names whose names start with character 'S' 
*/

select Passenger_Name from Passenger where Passenger_Name like 'S%';


/*
6)	Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
*/

select a.Passenger_name,a.Boarding_City,a.Destination_City,a.Bus_type,b.Price from 
Passenger a ,Price b where (a.Bus_Type = b.Bus_Type and a.Distance = b.Distance);


/*
7)	What are the passenger name/s and his/her ticket price who travelled in the Sitting bus  for a distance of 1000 KM s 
*/

select a.Passenger_name,b.Price from Passenger a , Price b where (a.Bus_Type = "Sitting"
and b.Bus_Type = "Sitting" and a.Distance=1000 and b.Distance=1000);


/*
8)	What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
*/

select Price from Price where distance = (
select distance from passenger where (boarding_city = 'Bengaluru' and destination_city = 'Panaji') 
or (boarding_city = 'Panaji' and destination_city = 'Bengaluru')
);

-- or --

-- select Price from Price where distance = (SELECT Distance FROM Passenger where 
-- passenger_name = "Pallavi")


/*
9) List the distances from the "Passenger" table which are unique 
(non-repeated distances) in descending order.
*/

SELECT distinct(Distance) FROM Passenger order by distance desc;


/*
10)	Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled 
by all passengers without using user variables 
*/

with total as ( select sum(distance) as total_distance from passenger)
select passenger_Name,(distance / total.total_distance)*100 as percentage_travel from 
Passenger, total;


/*
11)	Display the distance, price in three categories in table Price
a)	Expensive if the cost is more than 1000
b)	Average Cost if the cost is less than 1000 and greater than 500
c)	Cheap otherwise
*/

SELECT Bus_Type, Distance, Price,
CASE
     WHEN Price > 1000 THEN "Expensive"
     WHEN Price < 1000 and Price > 500 THEN "Average Cost"
     ELSE "Cheap"
END as Type_Pricing FROM Price;     




