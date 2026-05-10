set linesize 300
set pagesize 1000

col name format a20
col 0 format 99999
col 1 format 99999
col 2 format 99999
col 3 format 99999
col 4 format 99999
col 5 format 99999
col 6 format 99999
col 7 format 99999
col 8 format 99999
col 9 format 99999
col 10 format 99999
col 11 format 99999
col 12 format 99999
col 13 format 99999
col 14 format 99999
col 15 format 99999
col 16 format 99999
col 17 format 99999
col 18 format 99999
col 19 format 99999
col 20 format 99999
col 21 format 99999
col 22 format 99999
col 23 format 99999

select 
ps.name, 
to_char(BEGIN_INTERVAL_TIME,'YYYY-MM-DD') "Date",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '00' then ps.value else null end)*10/1024/1024)/10 "0",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '01' then ps.value else null end)*10/1024/1024)/10 "1",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '02' then ps.value else null end)*10/1024/1024)/10 "2",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '03' then ps.value else null end)*10/1024/1024)/10 "3",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '04' then ps.value else null end)*10/1024/1024)/10 "4",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '05' then ps.value else null end)*10/1024/1024)/10 "5",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '06' then ps.value else null end)*10/1024/1024)/10 "6",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '07' then ps.value else null end)*10/1024/1024)/10 "7",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '08' then ps.value else null end)*10/1024/1024)/10 "8",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '09' then ps.value else null end)*10/1024/1024)/10 "9",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '10' then ps.value else null end)*10/1024/1024)/10 "10",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '11' then ps.value else null end)*10/1024/1024)/10 "11",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '12' then ps.value else null end)*10/1024/1024)/10 "12",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '13' then ps.value else null end)*10/1024/1024)/10 "13",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '14' then ps.value else null end)*10/1024/1024)/10 "14",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '15' then ps.value else null end)*10/1024/1024)/10 "15",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '16' then ps.value else null end)*10/1024/1024)/10 "16",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '17' then ps.value else null end)*10/1024/1024)/10 "17",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '18' then ps.value else null end)*10/1024/1024)/10 "18",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '19' then ps.value else null end)*10/1024/1024)/10 "19",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '20' then ps.value else null end)*10/1024/1024)/10 "20",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '21' then ps.value else null end)*10/1024/1024)/10 "21",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '22' then ps.value else null end)*10/1024/1024)/10 "22",
floor(avg(case when to_char(ss.BEGIN_INTERVAL_TIME,'HH24') = '23' then ps.value else null end)*10/1024/1024)/10 "23"
from dba_hist_snapshot ss,
     dba_hist_pgastat ps
where ps.name = 'total PGA allocated'
      and ss.SNAP_ID = ps.SNAP_ID
          and ss.INSTANCE_NUMBER=ps.INSTANCE_NUMBER
		  and ss.INSTANCE_NUMBER='&INSTANCE_NUMBER'
group by ps.name, to_char(BEGIN_INTERVAL_TIME,'YYYY-MM-DD')
order by 2
/

