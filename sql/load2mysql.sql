use t;

CREATE TABLE `t1901` (
  `date_str` varchar(45) DEFAULT NULL,
  `id_str` varchar(45) DEFAULT NULL,
  `field1_str` varchar(45) DEFAULT NULL,
  `field2_str` varchar(45) DEFAULT NULL,
  `field3_str` varchar(45) DEFAULT NULL,
  `field4_str` varchar(45) DEFAULT NULL,
  `field5_str` varchar(45) DEFAULT NULL,
  `field6_str` varchar(45) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  `field1` decimal(10,3) DEFAULT NULL,
  `field2` decimal(10,3) DEFAULT NULL,
  `field3` decimal(10,3) DEFAULT NULL,
  `field4` decimal(10,3) DEFAULT NULL,
  `field5` decimal(10,3) DEFAULT NULL,
  `field6` decimal(10,3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


LOAD DATA LOCAL INFILE 'C:/Temp/feeds.csv'
INTO TABLE t.t1901 FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n';

select * from t1901
order by id_str;

SET SQL_SAFE_UPDATES = 0;
-- delete from t1801;

select CONVERT(`id_str`,UNSIGNED)
FROM t1901
where CONVERT(`id_str`,UNSIGNED) is null;


SELECT (`id_str` * 1)  
FROM t1901;

update t1901
set id=CONVERT(`id_str`,UNSIGNED);

SELECT CAST(date_str as datetime), replace(date_str,' UTC','')
FROM t1901
where CAST(replace(date_str,' UTC','') as datetime) is null;

update t1901
set date=CAST(replace(date_str,' UTC','') as datetime);

select CAST(`field1_str` as decimal(10,3))
from t1901
where field1_str is not null and field1_str <> ''
order by CAST(`field1_str` as decimal(10,3));

update t1901
set field1=field1_str
where field1_str is not null and field1_str <> '' and field1_str <> '""';

update t1901
set field2=field2_str
where field2_str is not null and field2_str <> '' and field2_str <> '""';

update t1901
set field3=field3_str
where field3_str is not null and field3_str <> '' and field3_str <> '""';

update t1901
set field4=field4_str
where field4_str is not null and field4_str <> '' and field4_str <> '""';

update t1901
set field5=field5_str
where field5_str is not null and field5_str <> '' and field5_str <> '""';

update t1901
set field6=field6_str
where field6_str is not null and field6_str <> '' and field6_str <> '""';

-- select * from t1901
-- where field1_str='""' or field2_str='""' or field3_str='""' or field4_str='""' or field5_str='""' or field6_str='""' ;

-- delete from t1901
-- where field1_str='""' or field2_str='""' or field3_str='""' or field4_str='""' or field5_str='""' or field6_str='""' ;

update t1901
set field1=null
where field1 > 50 or field1 < -20;

update t1901
set field2=null
where field2 > 50 or field2 < -20;

update t1901
set field3=null
where field3 > 50 or field3 < -20;

update t1901
set field5=null
where field5 > 50 or field5 < -20;

select * from t1901
where (field1 < 0);
-- and date > '2017-12-01';

select * from t1901
where date < '2017-12-01' and date > '2017-06-01';

delete from t1901
where date < '2017-06-01';

-- delete from t1901
-- where date_str='created_at';
