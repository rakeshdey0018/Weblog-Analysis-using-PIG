--using CombinedLogLoader the input logfile is loaded from HDFS locaton '/user/cloudera/input_data'. 
--Piggybank.jar is registered to leverage the use of  UDF combinedLogLoader

register '/usr/lib/pig/piggybank.jar' ;
 define CombinedLogLoader org.apache.pig.piggybank.storage.CombinedLogLoader();

logs_extract = LOAD '/user/cloudera/input_data/weblogs.txt' USING org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader()
AS (addr: chararray, logname: chararray, user: chararray, time: chararray, method: chararray, uri: chararray, proto: chararray,
status: int, bytes: int, referer: chararray, userAgent: chararray);

-- load the data only taking user address, Month and URI
log_month_specific = foreach logs_extract generate addr,SUBSTRING(time,3,6) as month,uri;

result_month = GROUP log_month_specific by (month,uri);
result = foreach result_month generate flatten(group), COUNT($1);

-- load the output file in CSV Format
STORE result INTO '/user/cloudera/pig_output/TrendOfEachUriAccess_everymonth' USING org.apache.pig.piggybank.storage.CSVExcelStorage();

