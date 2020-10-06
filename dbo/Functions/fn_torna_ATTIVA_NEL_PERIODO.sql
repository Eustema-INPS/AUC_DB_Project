




CREATE FUNCTION [dbo].[fn_torna_ATTIVA_NEL_PERIODO] (@periodo_dal datetime,@periodo_al datetime,@aupoc_codice_pk integer)

RETURNS char(1)
AS

BEGIN

declare @sosp_min datetime = null
declare @riat_min datetime = null
declare @canc_min datetime = null
declare @riat_int datetime = null
declare @riat_max datetime = null

declare @stato varchar(1) = 'N'
declare @stato_presente int = 0
declare @data_inizio_attivita datetime = null
declare @data_ultimo_stato datetime = null

set @stato_presente = (select aupoc_auspc_codice_pk from tb_aupoc_pos_contr where aupoc_codice_pk = @aupoc_codice_pk)
set @data_inizio_attivita = (select aupoc_data_inizio_attivita from tb_aupoc_pos_contr where aupoc_codice_pk = @aupoc_codice_pk)
set @data_ultimo_stato = (select aupoc_data_ultimo_stato from tb_aupoc_pos_contr where aupoc_codice_pk = @aupoc_codice_pk)

--se la posizione è attualmente attiva ed è stata creata prima della fine del periodo in esame, la si considera attiva
if @stato_presente = 1 and @data_inizio_attivita <= @periodo_al
begin
	return 'S'
end

--se la posizione è stata creata dopo della fine del periodo in esame, la si considera non attiva
if (@data_inizio_attivita > @periodo_al)
begin
	return 'N'
end

--se la posizione è attualmente riattivata e la data di riattivazione è prima della fine del periodo in esame, la si considera attiva
if @stato_presente = 5 and @data_ultimo_stato <= @periodo_al
begin
	return 'S'
end

--se la posizione è attualmente sospesa o cessata e la data di sospensione o cessazione è prima dell'inizio del periodo in esame, la si considera sospesa
if @stato_presente IN (2,3,4) and @data_ultimo_stato <= @periodo_dal
begin
	return 'N'
end


--set @periodo_dal = convert(date,'2013-10-01')
--set @periodo_al = convert(date,'2013-10-30')

set @sosp_min = (
Select max(auvas_data_variazione_stato) from tb_auvas_var_stato_pos
where auvas_aupoc_codice_pk = @aupoc_codice_pk and auvas_auspc_codice_pk = 4 and 
auvas_data_variazione_stato <= @periodo_dal
and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
)

set @canc_min = (
Select max(auvas_data_variazione_stato) from tb_auvas_var_stato_pos
where auvas_aupoc_codice_pk = @aupoc_codice_pk and auvas_auspc_codice_pk IN (2,3) and 
auvas_data_variazione_stato <= @periodo_dal
and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
)

set @riat_min = (
Select max(auvas_data_variazione_stato) from tb_auvas_var_stato_pos
where auvas_aupoc_codice_pk = @aupoc_codice_pk and auvas_auspc_codice_pk = 5 and 
auvas_data_variazione_stato <= @periodo_dal
and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
)
set @riat_int = (
Select max(auvas_data_variazione_stato) from tb_auvas_var_stato_pos
where auvas_aupoc_codice_pk = @aupoc_codice_pk and auvas_auspc_codice_pk = 5 and 
auvas_data_variazione_stato > @periodo_dal and auvas_data_variazione_stato <= @periodo_al
and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
)

--set @riat_max = (
--Select min(auvas_data_variazione_stato) from tb_auvas_var_stato_pos
--where auvas_aupoc_codice_pk = @aupoc_codice_pk and auvas_auspc_codice_pk = 5 and 
--auvas_data_variazione_stato >= @sosp_min
----2015.10.20 AI 6092:
--and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
--)
if @sosp_min is null and @canc_min is null and @riat_min is null
begin
	set @stato = 'S' --Attiva
end
else
begin
	if @sosp_min is null and @canc_min is null --era riattivata
	begin
		set @stato = 'S' --Riattivata
	end
	else
		if @sosp_min is null --era cancellata o riattivata
		begin
			if @riat_int is not null or (@riat_min >= @canc_min) --and @riat_min <= @periodo_dal)
			begin
             			set @stato = 'S'--era cancellata ma e' stata riattivata
			end
			else
			begin
             			set @stato = 'N'--era cancellata e lo e' restata nel periodo
			end
		end
		else
		begin
			if @canc_min is null --era sospesa o riattivata
			begin
				if @riat_int is not null or (@riat_min >= @sosp_min) --and @riat_min <= @periodo_dal)
				begin
             				set @stato = 'S'--era sospesa ma e' stata riattivata
				end
				else
				begin
             				set @stato = 'N'--era sospesa e lo e' restata nel periodo
				end
			end
			else -- esiste sia una sospensione che una cancellazione che una riattivazione
			begin
				if @riat_min >= @sosp_min and @riat_min >= @canc_min 
				begin
						set @stato = 'S'--e' riattivata perchè la riattivazione è più recente
				end
				else
				begin
					if @sosp_min >= @canc_min --la piu' vicina e' sospesa 
					begin
						if @riat_int is not null
						begin
		         					set @stato = 'S'--era sospesa ma e' stata riattivata
						end
						else
						begin
		         					set @stato = 'N'--era sospesa e lo e' restata nel periodo
						end
					end
					else --la piu' vicina e' cancellata
					begin
						if @riat_int is not null 
						begin
		         					set @stato = 'S'--era cancellata ma e' stata riattivata
						end
						else
						begin
		         					set @stato = 'N'--era cancellata e lo e' restata nel periodo
						end
					end

				end

			end
		end
end


return @stato
END


