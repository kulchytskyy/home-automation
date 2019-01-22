SELECT year(date), month(date), round(avg(field1), 1), round(min(field1),1), round(max(field1),1)
FROM t.t1901
group by year(date), month(date);

SELECT year(date), month(date), round(avg(field5), 1), round(min(field5),1), round(max(field5),1)
FROM t.t1901
group by year(date), month(date);

SELECT year(date), month(date), round(avg(field3), 1), round(min(field3),1), round(max(field3),1)
FROM t.t1901
group by year(date), month(date);

SELECT count(*)/(
	SELECT count(*)
	FROM t.t1901)*100
FROM t.t1901
where field6>0;

SELECT count(*)/(
	SELECT count(*)
	FROM t.t1901)*100
FROM t.t1901
where field6<=0;

SELECT count(*)
FROM t.t1901
where field6<=50;

SELECT count(*)
FROM t.t1901;

SELECT sum(field6/100*16000)/5/1000, avg(field5), avg(field1)
FROM t.t1901
where date<'2017-12-10';

SELECT sum(field6/100*16000)/5/1000, avg(field5), avg(field1)
FROM t.t1901
where date>='2017-12-10' and date<'2017-12-20';

SELECT sum(field6/100*16000)/5/1000, avg(field5), avg(field1)
FROM t.t1901
where date>='2017-12-20' and date<'2017-12-30';

SELECT year(date), month(date), round(sum(field6/100*16000)/5/1000), round(avg(field5), 2), round(avg(field1), 2)
FROM t.t1901
group by year(date), month(date);


-- max (15kW) = 3.4 kg/h
-- min = 0.85 kg/h

SELECT year(date), month(date), round(sum((3.4-0.85)*field6/100+0.85)/60*5*.7,0), round(avg(field5), 2), round(avg(field1), 2)
FROM t.t1901
where field6 > 0
group by year(date), month(date);

-- sunny days
SELECT year(date), month(date), day(date), round(count(*)*5/60,1)
FROM t.t1901
where field3 > 15 and (month(date)>=11 or month(date)<=3)
group by year(date), month(date), day(date)
having count(*)>5;

