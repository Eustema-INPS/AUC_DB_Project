


CREATE FUNCTION [dbo].[fn_torna_Giacenza] (@azregion int, @azstapro int, @azstazon int, @periodo date)

RETURNS int
AS

BEGIN

	declare @giacenza int = 0

	set @giacenza = (
	 select [auraz_gi]+[auraz_perv1]+[auraz_perv2]-[auraz_defa]-[auraz_defr1]-[auraz_defr2]
	 FROM [AUC].[dbo].[tb_auraz_report_azst]
	 where auraz_codice_modello = '046010'
--			and [auraz_azregion] = @azregion
			and [auraz_azstapro] = @azstapro
			and [auraz_azstazon] = @azstazon
	 and [Auraz_data_inizio] = @periodo
	-- and  @periodo <= [Auraz_data_fine]
	 and auraz_stato = 1
	)

	if @giacenza is null
		set @giacenza = 0
	else if @giacenza < 0
		set @giacenza = 0

	return @giacenza
END

