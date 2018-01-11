Below are the different type of use cases and associate pig script

USE CASE  1 - 

 # Some orgaization wants to find out trend of URI of every month, how many time people hit those URI for their pusrpose

  PIG script - TrendOfEachUriAccess_everymonth.pig
  
 USE CASE 2 - 
 
 #   Find out those top5 URIs which have been accessed frequently in every quarter
    
    PIG Script - Top5Uri_eachQuarter.pig
    
    In that script only 1st quarter(OCT-DEC) results are calculated. The script needs be run for Quarter2, Quarter3, Quarter4 just changing 
    month accordingly to quarter in below line code
    
             result_quarter1 = Filter log_month_specific by month =='Oct' OR month =='Nov' OR month =='Dec'
             
    For 4 quarters 4 output file will be generated and after that 4 output will be merged in single file manually or by code to visualize 
       the performance Quarter wise
   
USE CASE 3-  
   
 #     find out TOP 5 URI of every month to find out the top most uri those are accessed frequently
 
       PIG script - Top5Uri_everyMonth.pig
    
 
 USE CASE 4 - 
           
  #   Total Unique users access of each quarter. It helps business to drill down the information in more accurate way as no duplicate value will be calculated
        
        PIG Script - TotalUniqueUserAccess_eachQuarter.pig
        
        If any user access any URI in jan as well as march (Same Quarter) the code will count the access for one time. As analysis is done based on quarter.
         
       Lets say Input is 
       
       (15.55.12.23 Jan /product)--same
       (19.22.23.36 Feb /product)
       (15.55.12.23 Feb /product)--same only diff in month
       (22.32.12.69 Jan /product)
       (15.55.12.23 Jan /product1)

      output will be,  total count for that quarter - 4
      
      To Find out the reqult for every quarter below code will be changed for month column as per the quarter
      
               result_quarter1 = Filter log_month_specific by month =='Oct' OR month =='Nov' OR month =='Dec';
               
      So after running scripts  4 times for each quarter we will consolidate the result to visulaize the result quarter wise
      
      
 USE CASE 5 - 
 
 # Top 5 User Address of every Month
   
   PIG script - Top5_userAddress_eachMonth
 
 USE CASE 6 - 
 
 #  Find out trend of any product related item.  It will help to business to launch same  product in future. Also help organization to find out those product which are not popular so much
 
 Script - TrendOf_Product_Item.pig
 
 Log snippet -
 16.686.38.03 - - [27/Oct/2011:19:06:00 -0500] "GET /product/product4 HTTP/1.1" 200 0 "-" "Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.1.9) Gecko/20100401 Ubuntu/9.10 (karmic) Firefox/3.5.9"
 327.67.635.623 - - [27/Oct/2011:19:13:36 -0500] "GET /product/product2 HTTP/1.1" 200 0 "/product/product3" "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)"

 only visualize those uri consist String Product and accessed more than 100 times in every month
 
 
 
 
      
  
