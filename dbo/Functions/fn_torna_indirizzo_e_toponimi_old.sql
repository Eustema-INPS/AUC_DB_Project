


CREATE FUNCTION [dbo].[fn_torna_indirizzo_e_toponimi_old] (@indirizzo varchar(255), @toponimo varchar(50), @codice_toponimo varchar(3)) 
RETURNS varchar(50)
AS

BEGIN
   DECLARE @ret_val int

   Declare @primo_spazio int
   Declare @secondo_spazio int
   Declare @primo_topo varchar(50)
   Declare @secondo_topo varchar(50)
   Declare @primo_codice_toponimo varchar(3)
   Declare @secondo_codice_toponimo varchar(3)
   Declare @primo_toponimo varchar(50)
   Declare @secondo_toponimo varchar(50)
   
   --declare @indirizzo varchar(255)
   --declare @toponimo varchar(50)
   --declare @codice_toponimo varchar(3)

   --set @indirizzo = 'via domodossola 25'


set @ret_val = 0
set @primo_spazio = CHARINDEX(' ', @indirizzo)
set @secondo_spazio = CHARINDEX(' ', SUBSTRING(@indirizzo, CHARINDEX(' ', @indirizzo) + 1, 50))
set @primo_topo = SUBSTRING(@indirizzo, 1, @primo_spazio)
set @secondo_topo = SUBSTRING(@indirizzo, 1, @primo_spazio + @secondo_spazio)

set @primo_codice_toponimo = (select autop_toponimo_breve from tb_autop_toponimi where @primo_topo = autop_valore)
set @secondo_codice_toponimo = (select autop_toponimo_breve from tb_autop_toponimi where @secondo_topo = autop_valore)
set @primo_toponimo = (select autop_toponimo from tb_autop_toponimi where @primo_toponimo = autop_valore)
set @secondo_toponimo = (select autop_toponimo from tb_autop_toponimi where @secondo_toponimo = autop_valore)


if @primo_codice_toponimo is not null
begin
	set @toponimo = @primo_toponimo
	set @codice_toponimo = @primo_codice_toponimo
	set @ret_val = 1
end
else
	if @secondo_codice_toponimo is not null
	begin
		set @toponimo = @secondo_toponimo
		set @codice_toponimo = @secondo_codice_toponimo
		set @ret_val = 2
	end
	else
	begin
		set @toponimo = ' '
		set @codice_toponimo = ' '
		set @ret_val = 0
	end
	--print N'ind ' +  @indirizzo;
	--print N'primo topo ' + @primo_topo
	--print N'secondo topo ' + @secondo_topo
	--print N'primo codice topo ' + @primo_codice_toponimo
	--print N'secondo codice topo ' + @secondo_codice_toponimo
	--print N'primo toponimo ' + @primo_toponimo
	--print N'secondo toponimo ' + @secondo_toponimo


    return @ret_val
END

