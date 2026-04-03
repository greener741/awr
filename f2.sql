set linesize 300
set pagesize 1000
col file_name format a100
col TABLESPACE_NAME format a15

break on TABLESPACE_NAME skip 1
COMPUTE SUM LABEL 'TOTAL' of 'Size MB' on TABLESPACE_NAME
COMPUTE SUM LABEL 'TOTAL' of 'Free MB' on TABLESPACE_NAME

select a.TABLESPACE_NAME,
       a.FILE_NAME,
       round(a.bytes/1024/1024,2) "Size MB",
       ceil(nvl(sum(b.bytes)/1024/1024,0)) "Free MB",
       nvl(round(round(sum(b.bytes)/1024/1024,2)*100/round(a.bytes/1024/1024,2)),0) "Free %",
       a.AUTOEXTENSIBLE,
       round(a.MAXBYTES/1024/1024) "Max Size MB"
from dba_data_files a, dba_free_space b
where a.file_id=b.file_id(+)
and a.tablespace_name like '&1'
group by a.TABLESPACE_NAME, a.FILE_NAME, a.AUTOEXTENSIBLE, a.bytes, a.MAXBYTES
order by a.TABLESPACE_NAME;
