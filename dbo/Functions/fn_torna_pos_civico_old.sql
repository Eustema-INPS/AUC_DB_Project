

CREATE FUNCTION [dbo].[fn_torna_pos_civico_old] (@indirizzo varchar(255)) 
RETURNS varcHAR(50)
AS

BEGIN
   DECLARE @pos_0 int
   DECLARE @pos_1 int
   DECLARE @pos_2 int
   DECLARE @pos_3 int
   DECLARE @pos_4 int
   DECLARE @pos_5 int
   DECLARE @pos_6 int
   DECLARE @pos_7 int
   DECLARE @pos_8 int
   DECLARE @pos_9 int
   declare @minimo int
   DECLARE @ret_val VARCHAR(50)

set @pos_0 = charindex('0', @indirizzo)
set @pos_1 = charindex('1', @indirizzo)
set @pos_2 = charindex('2', @indirizzo)
set @pos_3 = charindex('3', @indirizzo)
set @pos_4 = charindex('4', @indirizzo)
set @pos_5 = charindex('5', @indirizzo)
set @pos_6 = charindex('6', @indirizzo)
set @pos_7 = charindex('7', @indirizzo)
set @pos_8 = charindex('8', @indirizzo)
set @pos_9 = charindex('9', @indirizzo)

   set @minimo = 999
   if @pos_0 <> 0 and @pos_0 < @minimo 
	set @minimo = @pos_0

   if @pos_1 <> 0 and @pos_1 < @minimo 
	set @minimo = @pos_1

   if @pos_2 <> 0 and @pos_2 < @minimo 
	set @minimo = @pos_2
   if @pos_3 <> 0 and @pos_3 < @minimo 
	set @minimo = @pos_3
   if @pos_4 <> 0 and @pos_4 < @minimo 
	set @minimo = @pos_4
   if @pos_5 <> 0 and @pos_5 < @minimo 
	set @minimo = @pos_5
   if @pos_6 <> 0 and @pos_6 < @minimo 
	set @minimo = @pos_6
   if @pos_7 <> 0 and @pos_7 < @minimo 
	set @minimo = @pos_7
   if @pos_8 <> 0 and @pos_8 < @minimo 
	set @minimo = @pos_8
   if @pos_9 <> 0 and @pos_9 < @minimo 
	set @minimo = @pos_9

--				set @ret_val=@minimo
  if @minimo <> 999
  			set @ret_val=substring(@indirizzo,@minimo,50)
  else
			set @ret_val=''
    return @ret_val
END
