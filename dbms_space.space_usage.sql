set serveroutput on
declare
  owner varchar2(32) := 'SYS';
  segment_name varchar2(64) := 'AUD$';
  segment_type varchar2(64) := 'TABLE';
  unf number;
  unfb number;
  fs1 number;
  fs1b number;
  fs2 number;
  fs2b number;
  fs3 number;
  fs3b number;
  fs4 number;
  fs4b number;
  full number;
  fullb number;
begin
  dbms_space.space_usage(owner,segment_name,segment_type,unf,unfb,fs1,fs1b,fs2,fs2b,fs3,fs3b,fs4,fs4b,full,fullb);
  dbms_output.put_line('Total number of blocks that are unformatted: '||unf);
  dbms_output.put_line('Number of blocks that has at least 0 to 25% free space: '||fs1);
  dbms_output.put_line('Number of blocks that has at least 25 to 50% free space: '||fs2);
  dbms_output.put_line('Number of blocks that has at least 50 to 75% free space: '||fs3);
  dbms_output.put_line('Number of blocks that has at least 75 to 100% free space: '||fs4);
  dbms_output.put_line('Total number of blocks that are full in the segment: '||full);
  dbms_output.put_line('Number of mbytes that has at least 0 to 25% free space: '||round(fs1b/power(1024,2),2));
  dbms_output.put_line('Number of mbytes that has at least 25 to 50% free space: '||round(fs2b/power(1024,2),2));
  dbms_output.put_line('Number of mbytes that has at least 50 to 75% free space: '||round(fs3b/power(1024,2),2));
  dbms_output.put_line('Number of mbytes that has at least 75 to 100% free space: '||round(fs4b/power(1024,2),2));  
  dbms_output.put_line('Total number of mbytes that are full in the segment: '||round(fullb/power(1024,2),2));
end;
/ 
