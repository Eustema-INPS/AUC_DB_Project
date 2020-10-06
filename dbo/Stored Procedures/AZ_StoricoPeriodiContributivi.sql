-- ==========================================================================================
-- Author:		<Letizia Bellantoni> / <Maurizio Picone>
-- Create date: <23/04/2012>
-- Description:	<Stored Procedure utilizzata nella pagina AZ_DettaglioPosizioneContributiva>
-- ==========================================================================================
-- ==========================================================================================
-- Author:		<Letizia Bellantoni>
-- Modifica date: <20/06/2014>
-- Description:	Aggiunti nuovi campi:cod.ateco 2007, lavoratori autonomi,giorni proroga,data scadenza autorizz.
-- ==========================================================================================
-- ==========================================================================================
-- Author:		<Letizia Bellantoni>
-- Modifica date: <23/07/2014>
-- Description:	Aggiunti nuovi campi:cod.ateco 1991
-- ==========================================================================================
CREATE PROCEDURE  [dbo].[AZ_StoricoPeriodiContributivi] 
	@codiceAupocPK as int
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT 
	   aupco_codice_pk,
	   tb_aupoc_pos_contr.aupoc_posizione as DB_PosizioneContributiva,
       aupco_cod_stat_contr  as DB_CodiceStatoContr,
       aupco_codici_autor as Db_CodiceAutore,
  	   aupco_cod_stat_contr	AS DB_CodStatistico,
  	   
	   --aggiunta per valorizzare tooltip del codice CSC
	   aucsc_settore						as DB_CscSettore,
	   aucsc_classe						    as DB_CscClasse,
	   aucsc_categoria						as DB_CscCategoria,

       CONVERT(VARCHAR(10), aupco_data_inizio_validita, 103) as DB_DataInizio,
       CONVERT(VARCHAR(10), aupco_data_fine_validita, 103) as DB_DataFine,

	   tb_auate_cod_ateco_ct.auate_cod_ateco_complessivo as DB_CodAteco2007,
	   tb_auate_cod_ateco_ct.auate_cod_sottocategoria_tit as DB_DescCodiceAteco2007,
	   [aupco_ateco_91] as DB_CodAteco1991,
	
	
	   [aupco_lavoratori_autonomi] as DB_LavAutonomi,
	   [aupco_giorni_proroga] as DB_GiorniProroga,
       CASE convert(varchar(10),[aupco_data_scad_autor],103)
		WHEN '01/01/1900' THEN ''
		ELSE convert(varchar(10),[aupco_data_scad_autor],103)
	   END		
	   as DB_DataScadAutor


  FROM dbo.tb_aupco_periodo_contr 
  
  INNER JOIN 
  tb_aupoc_pos_contr ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk

  --Potrebbe essere modificato quando sarà aggiunta FK su tabella AUPCO 
  LEFT OUTER JOIN 
  tb_aucsc_cod_stat_contr_ct
  on tb_aupco_periodo_contr.aupco_cod_stat_contr = tb_aucsc_cod_stat_contr_ct.aucsc_codice
  
  LEFT OUTER JOIN tb_auate_cod_ateco_ct
  on tb_auate_cod_ateco_ct.auate_codice_pk = [aupco_auate_2007_codice_pk]
 
  where tb_aupoc_pos_contr.aupoc_codice_pk=@codiceAupocPK
  
  order by aupco_data_inizio_validita desc

END

