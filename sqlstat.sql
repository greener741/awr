select 
sql_id,
plan_hash_value,
END_INTERVAL_TIME,
executions_delta,
round(ELAPSED_TIME_DELTA/(nonzeroexecutions*1000)/1000000,3) "Elapsed Average sec",
round(CPU_TIME_DELTA/(nonzeroexecutions*1000)/1000000,3) "CPU Average sec",
round(IOWAIT_DELTA/(nonzeroexecutions*1000)/1000000,3) "IO Average sec",
round(CLWAIT_DELTA/(nonzeroexecutions*1000)/1000000,3) "Cluster Average sec",
round(APWAIT_DELTA/(nonzeroexecutions*1000)/1000000,3) "Application Average sec",
round(CCWAIT_DELTA/(nonzeroexecutions*1000)/1000000,3) "Concurrency Average sec",
round(BUFFER_GETS_DELTA/nonzeroexecutions,3) "Average buffer gets",
round(DISK_READS_DELTA/nonzeroexecutions,3) "Average disk reads",
trunc(PHYSICAL_WRITE_BYTES_DELTA/(1024*1024*nonzeroexecutions)) "Average disk write megabytes",
round(ROWS_PROCESSED_DELTA/nonzeroexecutions,3) "Average rows processed"
from
(select 
ss.snap_id,
ss.sql_id,
ss.plan_hash_value,
sn.END_INTERVAL_TIME,
ss.executions_delta,
case ss.executions_delta when 0 then 1 else ss.executions_delta end nonzeroexecutions,
ELAPSED_TIME_DELTA,
CPU_TIME_DELTA,
IOWAIT_DELTA,
CLWAIT_DELTA,
APWAIT_DELTA,
CCWAIT_DELTA,
BUFFER_GETS_DELTA,
DISK_READS_DELTA,
PHYSICAL_WRITE_BYTES_DELTA,
ROWS_PROCESSED_DELTA
from DBA_HIST_SQLSTAT ss,DBA_HIST_SNAPSHOT sn
where ss.sql_id = '18g65qsv0jdvf'
and ss.plan_hash_value > 0
and ss.snap_id=sn.snap_id
and ss.INSTANCE_NUMBER=sn.INSTANCE_NUMBER)
where ELAPSED_TIME_DELTA > 0
order by snap_id,sql_id;

