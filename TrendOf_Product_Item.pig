--using CombinedLogLoader the input logfile is loaded from HDFS locaton '/user/cloudera/input_data'. 
--Piggybank.jar is registered to leverage the use of  UDF combinedLogLoader

register '/usr/lib/pig/piggybank.jar' ;
 define CombinedLogLoader org.apache.pig.piggybank.storage.CombinedLogLoader();

logs_extract = LOAD '/user/cloudera/input_data/weblogs.txt' USING org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader()
AS (addr: chararray, logname: chararray, user: chararray, time: chararray, method: chararray, uri: chararray, proto: chararray,
status: int, bytes: int, referer: chararray, userAgent: chararray);

log_month_specific = foreach logs_extract generate addr,SUBSTRING(time,3,6) as month,uri;

-- picking up the values where uri consist of '/product'
log_productCategory = FILTER log_month_specific by ((SUBSTRING(uri,0,8)=='/product'));

result_prod = GROUP log_productCategory by (month,uri);

result = foreach result_prod generate flatten(group) as (month,uri), COUNT($1) as count;

result_access_greaterThan100 = FILTER result by (count>100);

STORE result_access_greaterThan100 INTO '/user/cloudera/pig_output/TrendOf_Product_Item' USING org.apache.pig.piggybank.storage.CSVExcelStorage();
