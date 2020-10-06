


-- =============================================
-- Author:		<Emanuela Paletta>
-- Create date: <15/05/2019>
-- Description:	<Storep Procedure utilizzata nella pagina AZ_StoricoPosizioneContributiva>
-- Descrizione: mostra il dettaglio dello storico contributivo

-- =============================================
CREATE PROCEDURE  [dbo].[AZ_DettaglioStoricoContributivo] 
	@datamodifica datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

  select 
	  [aupcs_codice_pk]
      ,[aupcs_aupoc_codice_pk]
      ,[aupcs_data_modifica] as DB_DataModifica
      ,CONVERT(VARCHAR(10), [aupcs_data_inizio_validita], 103) as DB_DataInizio
	  ,CONVERT(VARCHAR(10), [aupcs_data_fine_validita], 103) as DB_DataFine 
	  ,CONVERT(VARCHAR(10), [aupcs_data_scad_autor], 103) as DB_DataScadAutor 
      ,[aupcs_giorni_proroga] as DB_GiorniProroga
      ,[aupcs_cod_stat_contr] as DB_CodiceStatoContr
      ,[aupcs_codici_autor] as Db_CodiceAutore
      ,[aupcs_lavoratori_autonomi] as DB_LavAutonomi
      ,[aupcs_inserimento]
      ,[aupcs_ateco_91]
      ,[aupcs_auate_1991_codice_pk] as DB_CodAteco1991
      ,[aupcs_auate_2002_codice_pk] as DB_CodAteco2002
      ,[aupcs_auate_2007_codice_pk] as DB_CodAteco2007
      ,[aupcs_descr_utente]
  from [AUC].[dbo].[tb_aupcs_periodo_contr_storico]		 
   where  CONVERT(VARCHAR(19), [aupcs_data_modifica], 109)  = CONVERT(VARCHAR(19), @datamodifica, 109)
 
  
END



