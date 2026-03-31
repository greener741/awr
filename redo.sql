col dated format a15
col 00 format 999
col 01 format 999
col 02 format 999
col 03 format 999
col 04 format 999
col 05 format 999
col 06 format 999
col 07 format 999
col 08 format 999
col 09 format 999
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


SELECT *
FROM (
    SELECT
        TO_CHAR(first_time, 'YYYY-MM-DD') AS dated,
        TO_CHAR(first_time, 'HH24')        AS hh
    FROM v$archived_log
    WHERE resetlogs_change# = (
          SELECT resetlogs_change#
          FROM v$database
    )
)
PIVOT (
    COUNT(*) FOR hh IN (
        '00' AS "00", '01' AS "01", '02' AS "02", '03' AS "03",
        '04' AS "04", '05' AS "05", '06' AS "06", '07' AS "07",
        '08' AS "08", '09' AS "09", '10' AS "10", '11' AS "11",
        '12' AS "12", '13' AS "13", '14' AS "14", '15' AS "15",
        '16' AS "16", '17' AS "17", '18' AS "18", '19' AS "19",
        '20' AS "20", '21' AS "21", '22' AS "22", '23' AS "23"
    )
)
ORDER BY dated;