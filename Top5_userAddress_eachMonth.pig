--using CombinedLogLoader the input logfile is loaded from HDFS locaton '/user/cloudera/input_data'. 
--Piggybank.jar is registered to leverage the use of  UDF combinedLogLoader

register '/usr/lib/pig/piggybank.jar' ;
 define CombinedLogLoader org.apache.pig.piggybank.storage.CombinedLogLoader();

logs_extract = LOAD '/user/cloudera/input_data/weblogs.txt' USING org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader()
AS (addr: chararray, logname: chararray, user: chararray, time: chararray, method: chararray, uri: chararray, proto: chararray,
status: int, bytes: int, referer: chararray, userAgent: chararray);

log_month_specific = foreach logs_extract generate addr,SUBSTRING(time,3,6) as month,uri;

result_refer = GROUP log_month_specific by (month,addr);
result = foreach result_refer generate flatten(group) as (month,addr), COUNT($1) as count;

result_month = GROUP result by month;

top5_user_eachMonth = foreach result_month { sorted = order result by count desc; 
                                             top_5 = limit sorted 5;
                                             generate flatten(top_5);
                                             }; 
                                            
STORE top5_user_eachMonth INTO '/user/cloudera/pig_output/Top5_userAddress_eachMonth' USING org.apache.pig.piggybank.storage.CSVExcelStorage();
