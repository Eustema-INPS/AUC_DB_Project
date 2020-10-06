

CREATE FUNCTION [dbo].[fn_convert_int_date] (@date_in INT) 
RETURNS int
AS

BEGIN
   DECLARE @ret_val int
   DECLARE @yyyymm char(6)
   set @yyyymm=CAST(@date_in AS CHAR(6))
   if (len(@yyyymm)=6 )
	   begin
		   if ((convert(int,SUBSTRING(@yyyymm,1,4)) BETWEEN 1900 AND '2100' ) and  (convert(int,SUBSTRING(@yyyymm,5,2)) BETWEEN 1 AND 12))
			set @ret_val=0
		 	 
		   else
			   set @ret_val=1
		  
		  
	   end
   else
       set @ret_val=1
    return @ret_val
END
