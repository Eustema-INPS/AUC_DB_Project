CREATE FUNCTION [dbo].[FN_MLPS_SPLIT_CA] ( @stringa VARCHAR(100), @data_verifica date)
RETURNS
 @returnList TABLE (indice int, [CA] varchar(2), [Descrizione] varchar(200))
AS
BEGIN

--declare @stringa varchar(50)
declare @lunghezza int
declare @ca_da_cercare varchar(2)
declare @descr varchar(200)
declare @progressivo int

set @progressivo = 1
--declare @data_oggi date

--set @stringa = '0J5V'

--set @data_oggi = convert(date,getdate())

--valorizza lunghezza stringa
if @stringa is null
set @lunghezza = 0
else
set @lunghezza = len(@stringa)

while @lunghezza > 0
begin

	set @ca_da_cercare = substring(@stringa,1,2)
	set @descr = (select top(1) aucau_descrizione from [tb_aucau_cod_autor_ct] 
					where aucau_codice = @ca_da_cercare
						  --and convert(date,[aucau_data_inizio]) <= @data_oggi 
						  --and convert(date,[aucau_data_fine]) >= @data_oggi)
						  and convert(date,[aucau_data_inizio]) <= @data_verifica
						  and convert(date,[aucau_data_fine]) >= @data_verifica)
  INSERT INTO @returnList 
	SELECT @progressivo, @ca_da_cercare, @descr

set @progressivo = @progressivo + 1

  if @lunghezza > 1
   set @stringa = substring(@stringa,3,100-(@progressivo-1)*2)

	if (@stringa is null or @stringa = '')
	set @lunghezza = 0
	else
	set @lunghezza = len(@stringa)
	
end
return
end

