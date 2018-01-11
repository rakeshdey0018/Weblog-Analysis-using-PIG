--using CombinedLogLoader the input logfile is loaded from HDFS locaton '/user/cloudera/input_data'. 
--Piggybank.jar is registered to leverage the use of UDF combinedLogLoader

register '/usr/lib/pig/piggybank.jar' ;
 define CombinedLogLoader org.apache.pig.piggybank.storage.CombinedLogLoader();

logs_extract = LOAD '/user/cloudera/input_data/weblogs.txt' USING org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader()
AS (addr: chararray, logname: chararray, user: chararray, time: chararray, method: chararray, uri: chararray, proto: chararray,
status: int, bytes: int, referer: chararray, userAgent: chararray);

result_month_uri = GROUP log_month_specific by (month,uri);
result = foreach result_month_uri generate flatten(group) as (month,uri), COUNT($1) as count;

result_month = GROUP result by month;

result_top5Uri = foreach result_month { sorted = order result by count desc; 
                                        top_5 = limit sorted 5;
                                         generate flatten(top_5);
                                      }; 
                                   
STORE result_top5Uri INTO '/user/cloudera/pig_output/Top5Uri_everyMonth' USING org.apache.pig.piggybank.storage.CSVExcelStorage();
