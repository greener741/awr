def days_history=78
def interval_hours=1
def sql_id='fkmtujp836ubt'



               select
			       hs.instance_number inst,
                   to_char(trunc(sysdate-&days_history+1)+trunc((cast(hs.begin_interval_time as date)-(trunc(sysdate-&days_history+1)))*24/(&interval_hours))*(&interval_hours)/24,'yyyy-mm-dd hh24:mi:ss') time,
                   hss.PLAN_HASH_VALUE,
                   nvl(sum(hss.executions_delta),0) executions,
                   round(sum(hss.elapsed_time_delta)/1000000,3) elapsed_time_s_total,
                   round(sum(hss.elapsed_time_delta)/1000000/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) elapsed_time_s_1exec,
                   round(sum(hss.cpu_time_delta)/1000000/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) cpu_time_s_1exec,
                   round(sum(hss.iowait_delta)/1000000/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) iowait_s_1exec,
                   round(sum(hss.clwait_delta)/1000000/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) clwait_s_1exec,
                   round(sum(hss.apwait_delta)/1000000/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) apwait_s_1exec,
                   round(sum(hss.ccwait_delta)/1000000/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) ccwait_s_1exec,
                   round(sum(hss.rows_processed_delta)/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) rows_processed_1exec,
                   round(sum(hss.buffer_gets_delta)/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) buffer_gets_1exec,
                   round(sum(hss.disk_reads_delta)/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) disk_reads_1exec,
                   round(sum(hss.direct_writes_delta)/decode(sum(hss.executions_delta),0,null,sum(hss.executions_delta)),3) direct_writes_1exec
               from dba_hist_sqlstat hss, (select 
                                instance_number, 
                                             snap_id, min(hs2.begin_interval_time) begin_interval_time from dba_hist_snapshot hs2 
                                           group by 
                                instance_number, 
                                             snap_id) hs
               where hss.sql_id(+)='&sql_id'
               and hss.snap_id(+)=hs.snap_id
			   and hss.instance_number(+)=hs.instance_number
               and hs.begin_interval_time>=trunc(sysdate)-&days_history+1
               group by
			   hs.instance_number,
                    trunc(sysdate-&days_history+1)+trunc((cast(hs.begin_interval_time as date)-(trunc(sysdate-&days_history+1)))*24/(&interval_hours))*(&interval_hours)/24,hss.PLAN_HASH_VALUE
               order by
			   hs.instance_number,
                    trunc(sysdate-&days_history+1)+trunc((cast(hs.begin_interval_time as date)-(trunc(sysdate-&days_history+1)))*24/(&interval_hours))*(&interval_hours)/24;
