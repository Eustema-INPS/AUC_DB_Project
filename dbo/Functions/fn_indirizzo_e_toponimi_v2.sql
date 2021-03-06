﻿

CREATE FUNCTION [dbo].[fn_indirizzo_e_toponimi_v2] (@indirizzo varchar(255))
RETURNS @Dati_indirizzo TABLE
( indirizzo varchar(255),
  toponimo varchar(50),
  codice_toponimo varchar(3),
  ret_val int
)
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
   Declare @nuovo_indirizzo varchar(255)
   Declare @toponimo varchar(50)
   Declare @codice_toponimo varchar(3)

set @ret_val = 0
set @primo_spazio   = CHARINDEX(' ', @indirizzo)
set @secondo_spazio = CHARINDEX(' ', SUBSTRING(@indirizzo, @primo_spazio + 1, 255))
set @primo_topo   = SUBSTRING(@indirizzo, 1, @primo_spazio)
set @secondo_topo = SUBSTRING(@indirizzo, 1, @primo_spazio + @secondo_spazio)

(select @primo_codice_toponimo=autop_toponimo_breve, @primo_toponimo=autop_toponimo from tb_autop_toponimi where @primo_topo = autop_valore)
(select @secondo_codice_toponimo=autop_toponimo_breve, @secondo_toponimo=autop_toponimo from tb_autop_toponimi where @secondo_topo = autop_valore)
--set @primo_codice_toponimo = (select autop_toponimo_breve from tb_autop_toponimi where @primo_topo = autop_valore)
--set @secondo_codice_toponimo = (select autop_toponimo_breve from tb_autop_toponimi where @secondo_topo = autop_valore)
--set @primo_toponimo = (select  from tb_autop_toponimi where @primo_topo = autop_valore)
--set @secondo_toponimo = (select autop_toponimo from tb_autop_toponimi where @secondo_topo = autop_valore)

if @primo_codice_toponimo is not null
begin
	set @nuovo_indirizzo = substring(@indirizzo,@primo_spazio+1, 255)
	set @toponimo = @primo_toponimo
	set @codice_toponimo = @primo_codice_toponimo
	set @ret_val = 100+@primo_spazio
end
else
	if @secondo_codice_toponimo is not null
	begin
		set @nuovo_indirizzo = substring(@indirizzo,@primo_spazio+@secondo_spazio+1, 255)
		set @toponimo = @secondo_toponimo
		set @codice_toponimo = @secondo_codice_toponimo
		set @ret_val = 200+@secondo_spazio
	end
	else
	begin
    	set @nuovo_indirizzo = @indirizzo
		set @toponimo = ' '
		set @codice_toponimo = ' '
		set @ret_val = 0
	end
	insert @Dati_indirizzo
	values (@nuovo_indirizzo, @toponimo, @codice_toponimo, @ret_val)
	return;

END






