CREATE FUNCTION [dbo].[fn_torna_PresenzaSosp] (@periodo_dal datetime,@periodo_al datetime,@aupoc_codice_pk integer)

RETURNS char(1)
AS

BEGIN

declare @sosp_min datetime = null
declare @riat_min datetime = null
declare @stato varchar(1) = 'N'
declare @stato_presente int = 0

--2016.07.22 AI 1088:
set @stato_presente = (select aupoc_auspc_codice_pk from tb_aupoc_pos_contr where aupoc_codice_pk = @aupoc_codice_pk)
--se la posizione è attualmente attiva, la si considera priva di sospensioni
if @stato_presente = 1
	begin
	return 'N'
end
--2016.07.22 AI 1088.

--set @periodo_dal = convert(date,'2013-10-01')
--set @periodo_al = convert(date,'2013-10-30')

set @sosp_min = (
Select max(auvas_data_variazione_stato) from tb_auvas_var_stato_pos
where auvas_interruzioni = 1 and auvas_aupoc_codice_pk = @aupoc_codice_pk and auvas_auspc_codice_pk = 4 and 
auvas_data_variazione_stato <= @periodo_dal
--2015.10.20 AI 6092:
and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
--2015.10.20 AI 6092.
)

if @sosp_min is not null 
begin
set @riat_min = (
Select min(auvas_data_variazione_stato) from tb_auvas_var_stato_pos
where auvas_interruzioni = 1 and auvas_aupoc_codice_pk = @aupoc_codice_pk and auvas_auspc_codice_pk = 5 and 
auvas_data_variazione_stato >= @sosp_min
--2015.10.20 AI 6092:
and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
--2015.10.20 AI 6092.
)
end 

if @sosp_min is not null and @riat_min is not null
begin
-- Modificato da Raffaele il 2015.09.27 era >= (AI 1086)
       if (@riat_min > @periodo_al)
             set @stato = 'S'
end

return @stato
END

