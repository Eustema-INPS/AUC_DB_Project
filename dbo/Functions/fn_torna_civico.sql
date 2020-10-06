





CREATE FUNCTION [dbo].[fn_torna_civico] (@indirizzo varchar(255)) 
RETURNS @dati_civico TABLE 
(
	civico varchar(50),
	pos_min int,
	pos_max int,
	lung int,
	rapp decimal(6,2),
	ret_val int
)
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
   Declare @civico varchar(50)
   declare @min int
   declare @max int
   declare @lung int
   Declare @rapp decimal(6,2)
   DECLARE @ret_val int

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

   set @min = 999 
   set @max = -1
   set @lung = len(@indirizzo)

   if @pos_0 <> 0 and @pos_0 < @min
	set @min = @pos_0
   if @pos_1 <> 0 and @pos_1 < @min 
	set @min = @pos_1
   if @pos_2 <> 0 and @pos_2 < @min 
	set @min = @pos_2
   if @pos_3 <> 0 and @pos_3 < @min 
	set @min = @pos_3
   if @pos_4 <> 0 and @pos_4 < @min 
	set @min = @pos_4
   if @pos_5 <> 0 and @pos_5 < @min 
	set @min = @pos_5
   if @pos_6 <> 0 and @pos_6 < @min 
	set @min = @pos_6
   if @pos_7 <> 0 and @pos_7 < @min 
	set @min = @pos_7
   if @pos_8 <> 0 and @pos_8 < @min 
	set @min = @pos_8
   if @pos_9 <> 0 and @pos_9 < @min 
	set @min = @pos_9

  if @min <> 999
  			set @civico=substring(@indirizzo,@min,50)
  else
  begin
			set @civico=''
  end
  set @rapp = @min/convert(decimal(6,2),@lung)

  if @rapp  < 0.4 and @rapp >= 0
	set @ret_val = 1		-- Non buono
  else
	set @ret_val = 0		-- Buono

	insert @dati_civico
	values(	@civico, @min, @max, @lung, @rapp, @ret_val)
    return
END




