# Weblog-Analysis-using-PIG
 [BigData] weblog analysis on  one year data using PIG
 
 This repository consists of multiple PIG scripts to do detailed analysis of one year weblog  and make it visualize with Tableau.
 
# Purpose - 
Weblog analysis is important very much to analyze the trends of hits/access of any particular website or any product or subsite within that site from end user. So that people in organization can take decision and make  powerful the site in future. Detailed weblog analysis is also helpful to launch any product and identify the popular thing on their site [ It is helpful for online retail company]. The main purpose of this  is to assist system administrators to quickly capture and analyze data hidden in the massive potential value, thus providing an important basis for business decisions.


# Log Structure - 
Here Apache Combined Log Format is used. Logs has been captured from OCT,2012 - Sept,2013 (one Financial year). All the data is sample data.

Log format -  "%hostname %logname %username %time \"%r\" %>statuscode %bytes \"%{Referer}i\" \"%{User-Agent}i\""

Log snippet - 
       363.87.337.58 - - [27/Oct/2011:18:55:51 -0500] "GET /demo HTTP/1.1" 200 0 "/demo" "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; InfoPath.2; .NET CLR 2.0.50727; OfficeLiveConnector.1.3; OfficeLivePatch.0.0; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"
 
Log File size is 74 MB and name- 'weblogs.txt' has been used throughout the PIG scripts. No username and logname is there. Based on host name(user address) statistics has been calculated.



       
 
