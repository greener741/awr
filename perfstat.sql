select to_char(snap_time,'YYYY-MM-DD HH:MI:SS') "Date",
       avg(newmem.value-oldmem.value) sorts_memory,
       avg(newdsk.value-olddsk.value) sorts_disk
from perfstat.stats$sysstat oldmem,
     perfstat.stats$sysstat newmem,
     perfstat.stats$sysstat newdsk,
     perfstat.stats$sysstat olddsk,
     perfstat.stats$snapshot   sn
where newdsk.snap_id = sn.snap_id
and olddsk.snap_id = sn.snap_id-1
and newmem.snap_id = sn.snap_id
and oldmem.snap_id = sn.snap_id-1
and oldmem.name = 'sorts (memory)'
and newmem.name = 'sorts (memory)'
and olddsk.name = 'sorts (disk)'
and newdsk.name = 'sorts (disk)'
and newmem.value-oldmem.value > 0
group by snap_time
order by 1;

==================================================================================
/* SGA free memory */

set linesize 300
set pagesize 1000

col 0 format 999
col 1 format 999
col 2 format 999
col 3 format 999
col 4 format 999
col 5 format 999
col 6 format 999
col 7 format 999
col 8 format 999
col 9 format 999
col 10 format 999
col 11 format 999
col 12 format 999
col 13 format 999
col 14 format 999
col 15 format 999
col 16 format 999
col 17 format 999
col 18 format 999
col 19 format 999
col 20 format 999
col 21 format 999
col 22 format 999
col 23 format 999

select ps.pool, to_char(snap_time,'YYYY-MM-DD') "Date",
floor(avg(case when to_char(ss.snap_time,'HH24') = '00' then ps.bytes else null end)*10/1024/1024)/10 "0",
floor(avg(case when to_char(ss.snap_time,'HH24') = '01' then ps.bytes else null end)*10/1024/1024)/10 "1",
floor(avg(case when to_char(ss.snap_time,'HH24') = '02' then ps.bytes else null end)*10/1024/1024)/10 "2",
floor(avg(case when to_char(ss.snap_time,'HH24') = '03' then ps.bytes else null end)*10/1024/1024)/10 "3",
floor(avg(case when to_char(ss.snap_time,'HH24') = '04' then ps.bytes else null end)*10/1024/1024)/10 "4",
floor(avg(case when to_char(ss.snap_time,'HH24') = '05' then ps.bytes else null end)*10/1024/1024)/10 "5",
floor(avg(case when to_char(ss.snap_time,'HH24') = '06' then ps.bytes else null end)*10/1024/1024)/10 "6",
floor(avg(case when to_char(ss.snap_time,'HH24') = '07' then ps.bytes else null end)*10/1024/1024)/10 "7",
floor(avg(case when to_char(ss.snap_time,'HH24') = '08' then ps.bytes else null end)*10/1024/1024)/10 "8",
floor(avg(case when to_char(ss.snap_time,'HH24') = '09' then ps.bytes else null end)*10/1024/1024)/10 "9",
floor(avg(case when to_char(ss.snap_time,'HH24') = '10' then ps.bytes else null end)*10/1024/1024)/10 "10",
floor(avg(case when to_char(ss.snap_time,'HH24') = '11' then ps.bytes else null end)*10/1024/1024)/10 "11",
floor(avg(case when to_char(ss.snap_time,'HH24') = '12' then ps.bytes else null end)*10/1024/1024)/10 "12",
floor(avg(case when to_char(ss.snap_time,'HH24') = '13' then ps.bytes else null end)*10/1024/1024)/10 "13",
floor(avg(case when to_char(ss.snap_time,'HH24') = '14' then ps.bytes else null end)*10/1024/1024)/10 "14",
floor(avg(case when to_char(ss.snap_time,'HH24') = '15' then ps.bytes else null end)*10/1024/1024)/10 "15",
floor(avg(case when to_char(ss.snap_time,'HH24') = '16' then ps.bytes else null end)*10/1024/1024)/10 "16",
floor(avg(case when to_char(ss.snap_time,'HH24') = '17' then ps.bytes else null end)*10/1024/1024)/10 "17",
floor(avg(case when to_char(ss.snap_time,'HH24') = '18' then ps.bytes else null end)*10/1024/1024)/10 "18",
floor(avg(case when to_char(ss.snap_time,'HH24') = '19' then ps.bytes else null end)*10/1024/1024)/10 "19",
floor(avg(case when to_char(ss.snap_time,'HH24') = '20' then ps.bytes else null end)*10/1024/1024)/10 "20",
floor(avg(case when to_char(ss.snap_time,'HH24') = '21' then ps.bytes else null end)*10/1024/1024)/10 "21",
floor(avg(case when to_char(ss.snap_time,'HH24') = '22' then ps.bytes else null end)*10/1024/1024)/10 "22",
floor(avg(case when to_char(ss.snap_time,'HH24') = '23' then ps.bytes else null end)*10/1024/1024)/10 "23"
from perfstat.stats$snapshot ss,
     perfstat.stats$sgastat ps
where ps.name = 'free memory' and ps.pool='shared pool'
      and ss.SNAP_ID = ps.SNAP_ID
group by ps.pool, to_char(snap_time,'YYYY-MM-DD')
order by 2;

==================================================================================

set linesize 300
set pagesize 1000

col 0 format 999
col 1 format 999
col 2 format 999
col 3 format 999
col 4 format 999
col 5 format 999
col 6 format 999
col 7 format 999
col 8 format 999
col 9 format 999
col 10 format 999
col 11 format 999
col 12 format 999
col 13 format 999
col 14 format 999
col 15 format 999
col 16 format 999
col 17 format 999
col 18 format 999
col 19 format 999
col 20 format 999
col 21 format 999
col 22 format 999
col 23 format 999

select 'CACHE HIT RATIO %', to_char(snap_time,'YYYY-MM-DD') "Date",
floor(avg(case when to_char(ss.snap_time,'HH24') = '00' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "0",
floor(avg(case when to_char(ss.snap_time,'HH24') = '01' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "1",
floor(avg(case when to_char(ss.snap_time,'HH24') = '02' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "2",
floor(avg(case when to_char(ss.snap_time,'HH24') = '03' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "3",
floor(avg(case when to_char(ss.snap_time,'HH24') = '04' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "4",
floor(avg(case when to_char(ss.snap_time,'HH24') = '05' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "5",
floor(avg(case when to_char(ss.snap_time,'HH24') = '06' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "6",
floor(avg(case when to_char(ss.snap_time,'HH24') = '07' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "7",
floor(avg(case when to_char(ss.snap_time,'HH24') = '08' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "8",
floor(avg(case when to_char(ss.snap_time,'HH24') = '09' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "9",
floor(avg(case when to_char(ss.snap_time,'HH24') = '10' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "10",
floor(avg(case when to_char(ss.snap_time,'HH24') = '11' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "11",
floor(avg(case when to_char(ss.snap_time,'HH24') = '12' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "12",
floor(avg(case when to_char(ss.snap_time,'HH24') = '13' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "13",
floor(avg(case when to_char(ss.snap_time,'HH24') = '14' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "14",
floor(avg(case when to_char(ss.snap_time,'HH24') = '15' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "15",
floor(avg(case when to_char(ss.snap_time,'HH24') = '16' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "16",
floor(avg(case when to_char(ss.snap_time,'HH24') = '17' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "17",
floor(avg(case when to_char(ss.snap_time,'HH24') = '18' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "18",
floor(avg(case when to_char(ss.snap_time,'HH24') = '19' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "19",
floor(avg(case when to_char(ss.snap_time,'HH24') = '20' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "20",
floor(avg(case when to_char(ss.snap_time,'HH24') = '21' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "21",
floor(avg(case when to_char(ss.snap_time,'HH24') = '22' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "22",
floor(avg(case when to_char(ss.snap_time,'HH24') = '23' then Round((1-(ps.physical_reads/ decode(ps.db_block_gets+ps.consistent_gets, 0, .001, db_block_gets+consistent_gets)))*100)  else null end)) "23"
from perfstat.stats$snapshot ss,
    perfstat.STATS$BUFFER_POOL_STATISTICS ps
where ss.SNAP_ID = ps.SNAP_ID
group by to_char(snap_time,'YYYY-MM-DD')
order by 2;

================================================================================
--total PGA allocated--

set linesize 300
set pagesize 1000

col 0 format 999
col 1 format 999
col 2 format 999
col 3 format 999
col 4 format 999
col 5 format 999
col 6 format 999
col 7 format 999
col 8 format 999
col 9 format 999
col 10 format 999
col 11 format 999
col 12 format 999
col 13 format 999
col 14 format 999
col 15 format 999
col 16 format 999
col 17 format 999
col 18 format 999
col 19 format 999
col 20 format 999
col 21 format 999
col 22 format 999
col 23 format 999

select ps.name, to_char(snap_time,'YYYY-MM-DD') "Date",
floor(avg(case when to_char(ss.snap_time,'HH24') = '00' then ps.value else null end)*10/1024/1024)/10 "0",
floor(avg(case when to_char(ss.snap_time,'HH24') = '01' then ps.value else null end)*10/1024/1024)/10 "1",
floor(avg(case when to_char(ss.snap_time,'HH24') = '02' then ps.value else null end)*10/1024/1024)/10 "2",
floor(avg(case when to_char(ss.snap_time,'HH24') = '03' then ps.value else null end)*10/1024/1024)/10 "3",
floor(avg(case when to_char(ss.snap_time,'HH24') = '04' then ps.value else null end)*10/1024/1024)/10 "4",
floor(avg(case when to_char(ss.snap_time,'HH24') = '05' then ps.value else null end)*10/1024/1024)/10 "5",
floor(avg(case when to_char(ss.snap_time,'HH24') = '06' then ps.value else null end)*10/1024/1024)/10 "6",
floor(avg(case when to_char(ss.snap_time,'HH24') = '07' then ps.value else null end)*10/1024/1024)/10 "7",
floor(avg(case when to_char(ss.snap_time,'HH24') = '08' then ps.value else null end)*10/1024/1024)/10 "8",
floor(avg(case when to_char(ss.snap_time,'HH24') = '09' then ps.value else null end)*10/1024/1024)/10 "9",
floor(avg(case when to_char(ss.snap_time,'HH24') = '10' then ps.value else null end)*10/1024/1024)/10 "10",
floor(avg(case when to_char(ss.snap_time,'HH24') = '11' then ps.value else null end)*10/1024/1024)/10 "11",
floor(avg(case when to_char(ss.snap_time,'HH24') = '12' then ps.value else null end)*10/1024/1024)/10 "12",
floor(avg(case when to_char(ss.snap_time,'HH24') = '13' then ps.value else null end)*10/1024/1024)/10 "13",
floor(avg(case when to_char(ss.snap_time,'HH24') = '14' then ps.value else null end)*10/1024/1024)/10 "14",
floor(avg(case when to_char(ss.snap_time,'HH24') = '15' then ps.value else null end)*10/1024/1024)/10 "15",
floor(avg(case when to_char(ss.snap_time,'HH24') = '16' then ps.value else null end)*10/1024/1024)/10 "16",
floor(avg(case when to_char(ss.snap_time,'HH24') = '17' then ps.value else null end)*10/1024/1024)/10 "17",
floor(avg(case when to_char(ss.snap_time,'HH24') = '18' then ps.value else null end)*10/1024/1024)/10 "18",
floor(avg(case when to_char(ss.snap_time,'HH24') = '19' then ps.value else null end)*10/1024/1024)/10 "19",
floor(avg(case when to_char(ss.snap_time,'HH24') = '20' then ps.value else null end)*10/1024/1024)/10 "20",
floor(avg(case when to_char(ss.snap_time,'HH24') = '21' then ps.value else null end)*10/1024/1024)/10 "21",
floor(avg(case when to_char(ss.snap_time,'HH24') = '22' then ps.value else null end)*10/1024/1024)/10 "22",
floor(avg(case when to_char(ss.snap_time,'HH24') = '23' then ps.value else null end)*10/1024/1024)/10 "23"
from perfstat.stats$snapshot ss,
     perfstat.stats$pgastat ps
where ps.name = 'total PGA allocated' 
      and ss.SNAP_ID = ps.SNAP_ID
group by ps.name, to_char(snap_time,'YYYY-MM-DD')
order by 2;

================================================

set pagesize 2000
set linesize 200
col TSNAME format a15
col FILENAME format a40

select
  old.TSNAME,
  old.FILENAME,
  to_char(snap_time,'yyyy-mm-dd') data,
   sum(new.phyrds-old.phyrds)     phy_rds,
   sum(new.phywrts-old.phywrts)   phy_wrts
from
  perfstat.stats$filestatxs old,
  perfstat.stats$filestatxs new,
  perfstat.stats$snapshot  sn
where
  new.snap_id = sn.snap_id
and
  old.filename = new.filename
and
  old.snap_id = sn.snap_id-1
and
   (new.phyrds-old.phyrds) > 0
and
  old.TSNAME like '&tablespace_name'
group by
  old.TSNAME,
  to_char(snap_time,'yyyy-mm-dd'),
  old.filename
order by 2,3;

================================================

select
   to_char(begin_interval_time,'yyyy-mm-dd hh24:mm:ss'),
   physical_reads_total,
   physical_writes_total
from
   dba_hist_seg_stat       s,
   dba_hist_seg_stat_obj   o,
   dba_hist_snapshot       sn
where
   o.owner = '&owner'
and
   s.obj# = o.obj#
and
   sn.snap_id = s.snap_id
and
   object_name = '&object_name'
order by  
   begin_interval_time;



CREATE TABLESPACE "PERFSTAT" DATAFILE
'+OSOZ/osoz/datafile/perfstat' SIZE 500M
AUTOEXTEND ON NEXT 10M MAXSIZE 32767M
LOGGING ONLINE PERMANENT BLOCKSIZE 8192
EXTENT MANAGEMENT LOCAL AUTOALLOCATE SEGMENT SPACE MANAGEMENT AUTO



col physical_reads_total format 999999999999
col physical_writes_total format 999999999999

select
   to_char(begin_interval_time,'yyyy-mm-dd') "Date",
   sum(physical_reads_total) "physical_reads_total",
   sum(physical_writes_total) "physical_writes_total"
from
   dba_hist_seg_stat       s,
   dba_hist_seg_stat_obj   o,
   dba_hist_snapshot       sn
where
   o.owner = '&owner'
and
   s.obj# = o.obj#
and
   sn.snap_id = s.snap_id
and
   object_name = '&object_name'
group by to_char(begin_interval_time,'yyyy-mm-dd')
order by 1;

=============================
/*
 The statistic REDO BUFFER ALLOCATION RETRIES reflects the number of times a user process waits for space in the redo log buffer
The value of redo buffer allocation retries should be near zero over an interval. If this value increments consistently, then processes have had to wait for space in the redo log buffer. The wait can be caused by the log buffer being too small or by checkpointing. Increase the size of the redo log buffer, if necessary, by changing the value of the initialization parameter LOG_BUFFER. The value of this parameter is expressed in bytes. Alternatively, improve the checkpointing or archiving process.
*/

set pagesize 200

select
   to_char(snap_time,'yyyy-mm-dd hh24') "date",
   round(avg(new_redo.value-old_redo.value)) "redo buffer allocation retries"
from
   perfstat.stats$sysstat old_redo,
   perfstat.stats$sysstat new_redo,
   perfstat.stats$snapshot sn
where
   new_redo.snap_id = sn.snap_id
and
   old_redo.snap_id = sn.snap_id-1
and
  old_redo.statistic# = 135
and
  new_redo.statistic# = 135
group by
   to_char(snap_time,'yyyy-mm-dd hh24')
order by 1;

========================================================================================

set linesize 300
set pagesize 1000

col 0 format 999
col 1 format 999
col 2 format 999
col 3 format 999
col 4 format 999
col 5 format 999
col 6 format 999
col 7 format 999
col 8 format 999
col 9 format 999
col 10 format 999
col 11 format 999
col 12 format 999
col 13 format 999
col 14 format 999
col 15 format 999
col 16 format 999
col 17 format 999
col 18 format 999
col 19 format 999
col 20 format 999
col 21 format 999
col 22 format 999
col 23 format 999

select ps.pool, to_char(snap_time,'YYYY-MM-DD') "Date",
floor(avg(case when to_char(ss.snap_time,'HH24') = '00' then ps.bytes else null end)*10/1024/1024)/10 "0",
floor(avg(case when to_char(ss.snap_time,'HH24') = '01' then ps.bytes else null end)*10/1024/1024)/10 "1",
floor(avg(case when to_char(ss.snap_time,'HH24') = '02' then ps.bytes else null end)*10/1024/1024)/10 "2",
floor(avg(case when to_char(ss.snap_time,'HH24') = '03' then ps.bytes else null end)*10/1024/1024)/10 "3",
floor(avg(case when to_char(ss.snap_time,'HH24') = '04' then ps.bytes else null end)*10/1024/1024)/10 "4",
floor(avg(case when to_char(ss.snap_time,'HH24') = '05' then ps.bytes else null end)*10/1024/1024)/10 "5",
floor(avg(case when to_char(ss.snap_time,'HH24') = '06' then ps.bytes else null end)*10/1024/1024)/10 "6",
floor(avg(case when to_char(ss.snap_time,'HH24') = '07' then ps.bytes else null end)*10/1024/1024)/10 "7",
floor(avg(case when to_char(ss.snap_time,'HH24') = '08' then ps.bytes else null end)*10/1024/1024)/10 "8",
floor(avg(case when to_char(ss.snap_time,'HH24') = '09' then ps.bytes else null end)*10/1024/1024)/10 "9",
floor(avg(case when to_char(ss.snap_time,'HH24') = '10' then ps.bytes else null end)*10/1024/1024)/10 "10",
floor(avg(case when to_char(ss.snap_time,'HH24') = '11' then ps.bytes else null end)*10/1024/1024)/10 "11",
floor(avg(case when to_char(ss.snap_time,'HH24') = '12' then ps.bytes else null end)*10/1024/1024)/10 "12",
floor(avg(case when to_char(ss.snap_time,'HH24') = '13' then ps.bytes else null end)*10/1024/1024)/10 "13",
floor(avg(case when to_char(ss.snap_time,'HH24') = '14' then ps.bytes else null end)*10/1024/1024)/10 "14",
floor(avg(case when to_char(ss.snap_time,'HH24') = '15' then ps.bytes else null end)*10/1024/1024)/10 "15",
floor(avg(case when to_char(ss.snap_time,'HH24') = '16' then ps.bytes else null end)*10/1024/1024)/10 "16",
floor(avg(case when to_char(ss.snap_time,'HH24') = '17' then ps.bytes else null end)*10/1024/1024)/10 "17",
floor(avg(case when to_char(ss.snap_time,'HH24') = '18' then ps.bytes else null end)*10/1024/1024)/10 "18",
floor(avg(case when to_char(ss.snap_time,'HH24') = '19' then ps.bytes else null end)*10/1024/1024)/10 "19",
floor(avg(case when to_char(ss.snap_time,'HH24') = '20' then ps.bytes else null end)*10/1024/1024)/10 "20",
floor(avg(case when to_char(ss.snap_time,'HH24') = '21' then ps.bytes else null end)*10/1024/1024)/10 "21",
floor(avg(case when to_char(ss.snap_time,'HH24') = '22' then ps.bytes else null end)*10/1024/1024)/10 "22",
floor(avg(case when to_char(ss.snap_time,'HH24') = '23' then ps.bytes else null end)*10/1024/1024)/10 "23"
from perfstat.stats$snapshot ss,
     perfstat.stats$sgastat ps
where ps.name = 'sql area' and ps.pool='shared pool'
      and ss.SNAP_ID = ps.SNAP_ID
group by ps.pool, to_char(snap_time,'YYYY-MM-DD')
order by 2;

========================================================================================

set linesize 300
set pagesize 1000

col 0 format 999
col 1 format 999
col 2 format 999
col 3 format 999
col 4 format 999
col 5 format 999
col 6 format 999
col 7 format 999
col 8 format 999
col 9 format 999
col 10 format 999
col 11 format 999
col 12 format 999
col 13 format 999
col 14 format 999
col 15 format 999
col 16 format 999
col 17 format 999
col 18 format 999
col 19 format 999
col 20 format 999
col 21 format 999
col 22 format 999
col 23 format 999

select ps.pool, to_char(snap_time,'YYYY-MM-DD') "Date",
floor(avg(case when to_char(ss.snap_time,'HH24') = '00' then ps.bytes else null end)*10/1024/1024)/10 "0",
floor(avg(case when to_char(ss.snap_time,'HH24') = '01' then ps.bytes else null end)*10/1024/1024)/10 "1",
floor(avg(case when to_char(ss.snap_time,'HH24') = '02' then ps.bytes else null end)*10/1024/1024)/10 "2",
floor(avg(case when to_char(ss.snap_time,'HH24') = '03' then ps.bytes else null end)*10/1024/1024)/10 "3",
floor(avg(case when to_char(ss.snap_time,'HH24') = '04' then ps.bytes else null end)*10/1024/1024)/10 "4",
floor(avg(case when to_char(ss.snap_time,'HH24') = '05' then ps.bytes else null end)*10/1024/1024)/10 "5",
floor(avg(case when to_char(ss.snap_time,'HH24') = '06' then ps.bytes else null end)*10/1024/1024)/10 "6",
floor(avg(case when to_char(ss.snap_time,'HH24') = '07' then ps.bytes else null end)*10/1024/1024)/10 "7",
floor(avg(case when to_char(ss.snap_time,'HH24') = '08' then ps.bytes else null end)*10/1024/1024)/10 "8",
floor(avg(case when to_char(ss.snap_time,'HH24') = '09' then ps.bytes else null end)*10/1024/1024)/10 "9",
floor(avg(case when to_char(ss.snap_time,'HH24') = '10' then ps.bytes else null end)*10/1024/1024)/10 "10",
floor(avg(case when to_char(ss.snap_time,'HH24') = '11' then ps.bytes else null end)*10/1024/1024)/10 "11",
floor(avg(case when to_char(ss.snap_time,'HH24') = '12' then ps.bytes else null end)*10/1024/1024)/10 "12",
floor(avg(case when to_char(ss.snap_time,'HH24') = '13' then ps.bytes else null end)*10/1024/1024)/10 "13",
floor(avg(case when to_char(ss.snap_time,'HH24') = '14' then ps.bytes else null end)*10/1024/1024)/10 "14",
floor(avg(case when to_char(ss.snap_time,'HH24') = '15' then ps.bytes else null end)*10/1024/1024)/10 "15",
floor(avg(case when to_char(ss.snap_time,'HH24') = '16' then ps.bytes else null end)*10/1024/1024)/10 "16",
floor(avg(case when to_char(ss.snap_time,'HH24') = '17' then ps.bytes else null end)*10/1024/1024)/10 "17",
floor(avg(case when to_char(ss.snap_time,'HH24') = '18' then ps.bytes else null end)*10/1024/1024)/10 "18",
floor(avg(case when to_char(ss.snap_time,'HH24') = '19' then ps.bytes else null end)*10/1024/1024)/10 "19",
floor(avg(case when to_char(ss.snap_time,'HH24') = '20' then ps.bytes else null end)*10/1024/1024)/10 "20",
floor(avg(case when to_char(ss.snap_time,'HH24') = '21' then ps.bytes else null end)*10/1024/1024)/10 "21",
floor(avg(case when to_char(ss.snap_time,'HH24') = '22' then ps.bytes else null end)*10/1024/1024)/10 "22",
floor(avg(case when to_char(ss.snap_time,'HH24') = '23' then ps.bytes else null end)*10/1024/1024)/10 "23"
from perfstat.stats$snapshot ss,
     perfstat.stats$sgastat ps
where ps.name = 'library cache' and ps.pool='shared pool'
      and ss.SNAP_ID = ps.SNAP_ID
group by ps.pool, to_char(snap_time,'YYYY-MM-DD')
order by 2;

==============================================================================================================

select
   to_char(snap_time,'yyyy-mm-dd hh24') "date",
   round(avg(new.value-old.value))
from
   perfstat.stats$sysstat old,
   perfstat.stats$sysstat new,
   perfstat.stats$snapshot sn
where
   new.snap_id = sn.snap_id
and
   old.snap_id = sn.snap_id-1
and
  old.name = 'CPU used by this session'
and
  new.name = 'CPU used by this session'
and to_char(snap_time,'yyyy-mm-dd hh24') > '2011-08-25'
group by
   to_char(snap_time,'yyyy-mm-dd hh24')
order by 1;

===========================================


set linesize 300
set pagesize 1000

col 0 format 999999
col 1 format 999999
col 2 format 999999
col 3 format 999999
col 4 format 999999
col 5 format 999999
col 6 format 999999
col 7 format 999999
col 8 format 999999
col 9 format 999999
col 10 format 999999
col 11 format 999999
col 12 format 999999
col 13 format 999999
col 14 format 999999
col 15 format 999999
col 16 format 999999
col 17 format 999999
col 18 format 999999
col 19 format 999999
col 20 format 999999
col 21 format 999999
col 22 format 999999
col 23 format 999999



select to_char(snap_time,'YYYY-MM-DD') "Date",
floor(avg(case when to_char(sn.snap_time,'HH24') = '00' then new.value-old.value else null end)) "0",
floor(avg(case when to_char(sn.snap_time,'HH24') = '01' then new.value-old.value else null end)) "1",
floor(avg(case when to_char(sn.snap_time,'HH24') = '02' then new.value-old.value else null end)) "2",
floor(avg(case when to_char(sn.snap_time,'HH24') = '03' then new.value-old.value else null end)) "3",
floor(avg(case when to_char(sn.snap_time,'HH24') = '04' then new.value-old.value else null end)) "4",
floor(avg(case when to_char(sn.snap_time,'HH24') = '05' then new.value-old.value else null end)) "5",
floor(avg(case when to_char(sn.snap_time,'HH24') = '06' then new.value-old.value else null end)) "6",
floor(avg(case when to_char(sn.snap_time,'HH24') = '07' then new.value-old.value else null end)) "7",
floor(avg(case when to_char(sn.snap_time,'HH24') = '08' then new.value-old.value else null end)) "8",
floor(avg(case when to_char(sn.snap_time,'HH24') = '09' then new.value-old.value else null end)) "9",
floor(avg(case when to_char(sn.snap_time,'HH24') = '10' then new.value-old.value else null end)) "10",
floor(avg(case when to_char(sn.snap_time,'HH24') = '11' then new.value-old.value else null end)) "11",
floor(avg(case when to_char(sn.snap_time,'HH24') = '12' then new.value-old.value else null end)) "12",
floor(avg(case when to_char(sn.snap_time,'HH24') = '13' then new.value-old.value else null end)) "13",
floor(avg(case when to_char(sn.snap_time,'HH24') = '14' then new.value-old.value else null end)) "14",
floor(avg(case when to_char(sn.snap_time,'HH24') = '15' then new.value-old.value else null end)) "15",
floor(avg(case when to_char(sn.snap_time,'HH24') = '16' then new.value-old.value else null end)) "16",
floor(avg(case when to_char(sn.snap_time,'HH24') = '17' then new.value-old.value else null end)) "17",
floor(avg(case when to_char(sn.snap_time,'HH24') = '18' then new.value-old.value else null end)) "18",
floor(avg(case when to_char(sn.snap_time,'HH24') = '19' then new.value-old.value else null end)) "19",
floor(avg(case when to_char(sn.snap_time,'HH24') = '20' then new.value-old.value else null end)) "20",
floor(avg(case when to_char(sn.snap_time,'HH24') = '21' then new.value-old.value else null end)) "21",
floor(avg(case when to_char(sn.snap_time,'HH24') = '22' then new.value-old.value else null end)) "22",
floor(avg(case when to_char(sn.snap_time,'HH24') = '23' then new.value-old.value else null end)) "23"
from perfstat.stats$snapshot sn,
     perfstat.stats$sysstat old,
     perfstat.stats$sysstat new
where new.snap_id = sn.snap_id
      and
      old.snap_id = sn.snap_id-1
      and
      old.name = 'CPU used by this session'
      and
      new.name = 'CPU used by this session'
group by to_char(snap_time,'YYYY-MM-DD')
order by 1;


