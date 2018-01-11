--using CombinedLogLoader the input logfile is loaded from HDFS locaton '/user/cloudera/input_data'. 
--Piggybank.jar is registered to keverage the UDF combinedLogLoader

register '/usr/lib/pig/piggybank.jar' ;
 define CombinedLogLoader org.apache.pig.piggybank.storage.CombinedLogLoader();

logs_extract = LOAD '/user/cloudera/input_data/weblogs.txt' USING org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader()
AS (addr: chararray, logname: chararray, user: chararray, time: chararray, method: chararray, uri: chararray, proto: chararray,
status: int, bytes: int, referer: chararray, userAgent: chararray);

log_month_specific = foreach logs_extract generate addr,SUBSTRING(time,3,6) as month,uri;

--loading the data using FILTER only for First Quarter (OCT-DEC)
result_quarter1 = Filter log_month_specific by month =='Oct' OR month =='Nov' OR month =='Dec';

result_grpbyQ1 = GROUP result_quarter1 by (uri);

--Generating Extra column 'quarter1(Oct-dec)' for visualize the data in convenience way
result_countQ1 = foreach result_grpbyQ1 generate 'quarter1(Oct-dec)', flatten(group), COUNT($1) as count; 

result_countQ1_desc = order result_countQ1 by count desc;

top5_q1 = limit result_countQ1_desc 5;

STORE top5_q1 INTO '/user/cloudera/pig_output/Top5Uri_Q1' USING org.apache.pig.piggybank.storage.CSVExcelStorage();
