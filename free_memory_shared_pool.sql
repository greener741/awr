set linesize 300
set pagesize 1000

col 0 format 9999
col 1 format 9999
col 2 format 9999
col 3 format 9999
col 4 format 9999
col 5 format 9999
col 6 format 9999
col 7 format 9999
col 8 format 9999
col 9 format 9999
col 10 format 9999
col 11 format 9999
col 12 format 9999
col 13 format 9999
col 14 format 9999
col 15 format 9999
col 16 format 9999
col 17 format 9999
col 18 format 9999
col 19 format 9999
col 20 format 9999
col 21 format 9999
col 22 format 9999
col 23 format 9999

select ps.pool, to_char(BEGIN_INTERVAL_TIME,'YYYY-MM-DD') "Date",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '00' then ps.bytes else null end)*10/1024/1024)/10 "0",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '01' then ps.bytes else null end)*10/1024/1024)/10 "1",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '02' then ps.bytes else null end)*10/1024/1024)/10 "2",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '03' then ps.bytes else null end)*10/1024/1024)/10 "3",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '04' then ps.bytes else null end)*10/1024/1024)/10 "4",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '05' then ps.bytes else null end)*10/1024/1024)/10 "5",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '06' then ps.bytes else null end)*10/1024/1024)/10 "6",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '07' then ps.bytes else null end)*10/1024/1024)/10 "7",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '08' then ps.bytes else null end)*10/1024/1024)/10 "8",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '09' then ps.bytes else null end)*10/1024/1024)/10 "9",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '10' then ps.bytes else null end)*10/1024/1024)/10 "10",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '11' then ps.bytes else null end)*10/1024/1024)/10 "11",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '12' then ps.bytes else null end)*10/1024/1024)/10 "12",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '13' then ps.bytes else null end)*10/1024/1024)/10 "13",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '14' then ps.bytes else null end)*10/1024/1024)/10 "14",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '15' then ps.bytes else null end)*10/1024/1024)/10 "15",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '16' then ps.bytes else null end)*10/1024/1024)/10 "16",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '17' then ps.bytes else null end)*10/1024/1024)/10 "17",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '18' then ps.bytes else null end)*10/1024/1024)/10 "18",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '19' then ps.bytes else null end)*10/1024/1024)/10 "19",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '20' then ps.bytes else null end)*10/1024/1024)/10 "20",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '21' then ps.bytes else null end)*10/1024/1024)/10 "21",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '22' then ps.bytes else null end)*10/1024/1024)/10 "22",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '23' then ps.bytes else null end)*10/1024/1024)/10 "23"
from dba_hist_snapshot ss,
     dba_hist_sgastat ps
where ps.name = 'free memory' and ps.pool='shared pool'
      and ss.SNAP_ID = ps.SNAP_ID
          and ss.INSTANCE_NUMBER=ps.INSTANCE_NUMBER
		  and ss.INSTANCE_NUMBER=1
group by ps.pool, to_char(BEGIN_INTERVAL_TIME,'YYYY-MM-DD')
order by 2
/

