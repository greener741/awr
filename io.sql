set linesize 200
col name format a60
col PHYWRTS format 999,999,999
col PHYRDS format 999,999,999

SELECT name, phyrds, phywrts
FROM v$datafile df, v$filestat fs
WHERE df.file# = fs.file#
order by PHYWRTS;

==================================================================

set linesize 200
set pagesize 200
col username format a15
col SPID format a8

SELECT s.sid, s.serial#, p.spid, s.username, s.program, i.BLOCK_GETS, i.CONSISTENT_GETS, i.PHYSICAL_READS,i.block_changes
FROM v$session s, v$sess_io i, v$process p
WHERE s.sid = i.sid and s.paddr=p.addr 
and s.username is not null
ORDER BY i.block_changes desc;

==================================================================

set pages 999
break on snap_time skip 2

col snap_time   format a19
col value       format 999,999,999

select
   to_char(begin_interval_time,'yyyy-mm-dd hh24:mi') snap_time,
   value
from
   dba_hist_sysstat
  natural join
   dba_hist_snapshot
where
   stat_name = 'physical writes'
order by
   to_char(begin_interval_time,'yyyy-mm-dd hh24:mi');

==================================================================

set pagesize 200

select
   to_char(begin_interval_time,'yyyy-mm-dd hh24') "date",
   round(avg(new_redo.value-old_redo.value)) "physical writes"
from
   dba_hist_sysstat old_redo,
   dba_hist_sysstat new_redo,
   natural join
   dba_hist_snapshot sn
where
   new_redo.snap_id = sn.snap_id
and
   old_redo.snap_id = sn.snap_id-1
and
  old_redo.stat_name = 'physical writes'
and
  new_redo.stat_name = 'physical writes'
group by
   to_char(begin_interval_time,'yyyy-mm-dd hh24')
order by 1;

=========================================================================================

col STAT_NAME for a30
with snap_shot as
(
select begin_time,SNAP_ID,rank from (
select trunc(BEGIN_INTERVAL_TIME,'MI') begin_time,SNAP_ID,rank() over (order by snap_id desc) as rank from DBA_HIST_SNAPSHOT
) where rank<3
),
new as
(select * from snap_shot where rank = 1),
old as
(select * from snap_shot where rank = 2)
select stat1.STAT_NAME,stat2.value-stat1.value value,(new.begin_time-old.begin_time)*24 duration_in_hour,
(stat2.value-stat1.value)/((new.begin_time-old.begin_time)*24) value_per_hour
from DBA_HIST_SYSSTAT stat1, DBA_HIST_SYSSTAT stat2,new,old
where stat1.snap_id=old.snap_id
and stat2.snap_id=new.snap_id
and stat1.STAT_NAME=stat2.STAT_NAME
and stat1.STAT_NAME in ('physical writes')
order by stat1.STAT_NAME;