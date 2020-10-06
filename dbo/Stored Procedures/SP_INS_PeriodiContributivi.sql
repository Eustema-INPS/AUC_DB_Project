



-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2015.09.21
-- Description:	AI2064
-- =============================================
CREATE PROCEDURE [dbo].[SP_INS_PeriodiContributivi]
	-- Add the parameters for the stored procedure here
	@codice_aupoc  int, @PeriodiContributivi as dbo.PeriodoContributivo READONLY
AS
BEGIN
	
	SET NOCOUNT ON;


	INSERT INTO [dbo].[tb_aupco_periodo_contr]
        ([aupco_aupoc_codice_pk]
        ,[aupco_cod_stat_contr]
		,[aupco_aucsc_codice_pk]
	    ,[aupco_codici_autor]
		,[aupco_data_inizio_validita]
		,[aupco_data_fine_validita]
		,[aupco_auate_codice_pk]
		,[aupco_auate_2007_codice_pk]
		,[aupco_ateco_91] ---?
		,[aupco_auate_1991_codice_pk]
		,[aupco_lavoratori_autonomi]
		,[aupco_giorni_proroga]
		,[aupco_data_scad_autor]
		,[aupco_data_modifica]
		,[aupco_inserimento]
		,[aupco_descr_utente])

	select 
	@codice_aupoc
	,TabPeriodiContr.Cod_stat_contr --Cod_stat_contr
	,[aucsc_codice_pk]	
	,Codici_autor
	,Data_inizio_validita
	,Data_fine_validita
	,Auate_2007.auate_codice_pk	--Ateco_2007
	,Auate_2007.auate_codice_pk	--Ateco_2007
	,Ateco_91
	,Auate_91.auate_codice_pk
	,Lavoratori_autonomi
	,Giorni_proroga
	,Data_scad_autor
	,getdate()
	,convert (varchar(10),Data_inserimento,103)
	,TabPeriodiContr.Descr_utente

	from @PeriodiContributivi as TabPeriodiContr 
	LEFT  OUTER JOIN tb_auate_cod_ateco_ct as Auate_2007
	on TabPeriodiContr.Ateco_2007 = Auate_2007.auate_cod_ateco_complessivo and Auate_2007.auate_anno_riferimento='2007'
	LEFT  OUTER JOIN tb_auate_cod_ateco_ct as Auate_91
	on TabPeriodiContr.Ateco_91 = Auate_91.auate_cod_ateco_complessivo and Auate_91.auate_anno_riferimento='1991'
    LEFT OUTER JOIN 
    tb_aucsc_cod_stat_contr_ct
    on TabPeriodiContr.Cod_stat_contr = tb_aucsc_cod_stat_contr_ct.aucsc_codice

	SELECT isnull(SCOPE_IDENTITY(),0) AS id;
END




