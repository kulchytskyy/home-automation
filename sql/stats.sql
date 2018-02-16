SELECT year(date), month(date), min(field1), max(field1), avg(field1)
FROM t.t1801
group by year(date), month(date);

SELECT year(date), month(date), min(field5), max(field5), avg(field5)
FROM t.t1801
group by year(date), month(date);

SELECT year(date), month(date), min(field3), max(field3), avg(field3)
FROM t.t1801
group by year(date), month(date);

SELECT count(*)/(
	SELECT count(*)
	FROM t.t1801)*100
FROM t.t1801
where field6>0;

SELECT count(*)/(
	SELECT count(*)
	FROM t.t1801)*100
FROM t.t1801
where field6<=0;

SELECT count(*)
FROM t.t1801
where field6<=50;

SELECT count(*)
FROM t.t1801;

SELECT sum(field6/100*16000)/5/1000, avg(field5), avg(field1)
FROM t.t1801
where date<'2017-12-10';

SELECT sum(field6/100*16000)/5/1000, avg(field5), avg(field1)
FROM t.t1801
where date>='2017-12-10' and date<'2017-12-20';

SELECT sum(field6/100*16000)/5/1000, avg(field5), avg(field1)
FROM t.t1801
where date>='2017-12-20' and date<'2017-12-30';

SELECT year(date), month(date), round(sum(field6/100*16000)/5/1000), round(avg(field5), 2), round(avg(field1), 2)
FROM t.t1801
group by year(date), month(date);
