--using CombinedLogLoader the input logfile is loaded from HDFS locaton '/user/cloudera/input_data'. 
--Piggybank.jar is registered to keverage the UDF combinedLogLoader

register '/usr/lib/pig/piggybank.jar' ;
 define CombinedLogLoader org.apache.pig.piggybank.storage.CombinedLogLoader();

logs_extract = LOAD '/user/cloudera/input_data/weblogs.txt' USING org.apache.pig.piggybank.storage.apachelog.CombinedLogLoader()
AS (addr: chararray, logname: chararray, user: chararray, time: chararray, method: chararray, uri: chararray, proto: chararray,
status: int, bytes: int, referer: chararray, userAgent: chararray);

log_month_specific = foreach logs_extract generate addr,SUBSTRING(time,3,6) as month,uri;

result_quarter1 = Filter log_month_specific by month =='Oct' OR month =='Nov' OR month =='Dec';
af = group result_quarter1 by month;

--genearating the result of total unique hit count of every month of that quarter based of distinct value of addr, uri both, 
result_quarter1_dist_byquarter =  foreach af  { 
                                               b = result_quarter1.(addr,uri);
                                               s = DISTINCT b; 
                                               generate flatten(group), COUNT(s);
                                               };

--temp col is created to sum up all value using group by that col

temp_var = foreach result_quarter1_dist_byquarter generate 'temp' as f1, quarters_month, count_id; 

grp_temp = group temp_var by f1;

Total_unique_count_in_Q1 = foreach grp_temp generate  SUM(temp_var.count_id);


STORE Total_unique_count_in_Q1 INTO '/user/cloudera/pig_output/UniqueUserAccess_Q1' USING org.apache.pig.piggybank.storage.CSVExcelStorage();

