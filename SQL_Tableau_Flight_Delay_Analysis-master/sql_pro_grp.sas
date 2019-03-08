libname gp "C:\Users\hpaliwal\Desktop\BusinessReportingTools-master\Group_assignment\sql_group_project-master\sql_group_project-master";  

proc sql; 
create table gp.delay_destination_h1 as

select   AVG(A.dep_delay) as avg_dep_delay,AVG(A.arr_delay) as  avg_arr_delay , A.origin, A.dest, B.name,SUM(avg(A.dep_delay), avg(A.arr_delay)) as avg_total_delay   
from gp.Flights as A, gp.Airlines B 
where A.carrier = B.carrier 
and A.month < 6
and A.dep_delay is NOT NULL 
and A.arr_delay is NOT NULL  
group by A.origin,  A.carrier , A.dest, B.name ;
quit ; 

proc sql; 
create table gp.delay_destination_h2 as

select   AVG(A.dep_delay) as avg_dep_delay,AVG(A.arr_delay) as  avg_arr_delay , A.origin, A.dest, B.name,SUM(avg(A.dep_delay), avg(A.arr_delay)) as avg_total_delay   
from gp.Flights as A, gp.Airlines B 
where A.carrier = B.carrier 
and A.month < 13
and A.month > 6
and A.dep_delay is NOT NULL 
and A.arr_delay is NOT NULL  
group by A.origin,  A.carrier , A.dest, B.name ;
quit ; 

proc sql ;

create table gp.delay_weather_ewr as


select Distinct ((5/9)* (A.temp-32)) as temp_celcius, A.dewp, A.humid, B.origin, avg(B.dep_delay) as avg_dp_delay
from gp.Flights as B, gp.Weather as A
where A.origin  Contains ("EWR")
and B.origin Contains ( "EWR")
and A.time_hour = B.time_hour 
and B.dep_delay is NOT NULL 
and B.arr_delay is NOT NULL 
group by temp_celcius;
quit;


proc sql ;

create table gp.delay_weather_jfk as

select Distinct ((5/9)* (A.temp-32)) as temp_celcius, A.dewp, A.humid, B.origin, avg(B.dep_delay) as avg_dp_delay
from gp.Flights as B, gp.Weather as A
where A.origin  Contains ("JFK")
and B.origin Contains ( "JFK")
and A.time_hour = B.time_hour 
and B.dep_delay is NOT NULL 
and B.arr_delay is NOT NULL 
group by temp_celcius;
quit;



proc sql ;

create table gp.delay_weather_LGA as

select ((5/9)* (A.temp-32)) as temp_celcius, A.dewp, A.humid, B.origin, B.dest, B.carrier, SUM(B.dep_delay, B.arr_delay) as total_delay 
from gp.Flights as B, gp.Weather as A
where A.origin  Contains ("LGA")
and B.origin Contains ( "LGA")
and A.time_hour = B.time_hour 
and B.dep_delay is NOT NULL 
and B.arr_delay is NOT NULL  ;
quit;


