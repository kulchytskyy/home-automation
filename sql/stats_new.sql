-- max (15kW) = 3.4 kg/h
-- min = 0.85 kg/h

SELECT year(date), month(date), round(sum((3.4-0.85)*temperature/100+0.85)/60*5*.7,0)
FROM temperatures
where sensor_id=12
group by year(date), month(date);
order by year(date), month(date);


-- sunny days
SELECT year(date), month(date), day(date), round(count(*)*5/60,1)
FROM temperatures
where sensor_id=9
and temperature > 15 and (month(date)>=11 or month(date)<=3)
group by year(date), month(date), day(date)
having count(*)>5 and round(count(*)*5/60,1) > 5;

