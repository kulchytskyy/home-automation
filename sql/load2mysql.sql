use t;

CREATE TABLE `t`.`t1801` (
  `d` DATETIME NULL,
  `field1` VARCHAR(45) NULL);

-- ENCLOSED BY '"' 


LOAD DATA LOCAL INFILE 'C:/Temp/feed.csv'
INTO TABLE t.t1801 FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

SET SQL_SAFE_UPDATES = 0;
-- delete from t1801;

SELECT (`id_str` * 1)  
FROM t1801;

update t1801
set id=(`id_str` * 1);

SELECT CAST(date_str as datetime), replace(date_str,' UTC','')
FROM t1801;

update t1801
set date=CAST(replace(date_str,' UTC','') as datetime);

select CAST(`field1_str` as decimal(10,3))
from t1801
where field1_str is not null and field1_str <> ''
order by CAST(`field1_str` as decimal(10,3));

update t1801
set field1=field1_str
where field1_str is not null and field1_str <> '' and field1_str <> '""';

update t1801
set field2=field2_str
where field2_str is not null and field2_str <> '' and field2_str <> '""';

update t1801
set field3=field3_str
where field3_str is not null and field3_str <> '' and field3_str <> '""';

update t1801
set field4=field4_str
where field4_str is not null and field4_str <> '' and field4_str <> '""';

update t1801
set field5=field5_str
where field5_str is not null and field5_str <> '' and field5_str <> '""';

update t1801
set field6=field6_str
where field6_str is not null and field6_str <> '' and field6_str <> '""';

select * from t1801
where (field1 > 40 or field2 > 40 or field3 > 40 or field5 > 40)
and date > '2017-12-01';

select * from t1801
where (field1 < 0)
and date > '2017-12-01';

delete from t1801
where date < '2017-12-01';

delete from t1801
where id in (94655,94656,94657);

select * from t1801
where field1_str='""' or field2_str='""' or field3_str='""' or field4_str='""' or field5_str='""' or field6_str='""' ;