


-- =============================================
-- Author:		Maurizio Picone
-- Create date: 23/05/2012
-- Description:	Dettaglio della posizione Madre
-- =============================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  06/12/2012
-- Description:	Utilizzo della FK aupoc_ausin_codice_pk
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  11/01/2013
-- Description:	Aggiunto Settore concatenato alla Gestione Applicativa
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  24/06/2013
-- Description:	Aggiunta gestione contributiva da tb_aurea
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  31/03/2015
-- Description:	Cambiata la join con aupoc usato il codice madre invece della figlia
-- ======================================================================

CREATE procedure [dbo].[AZ_PosizioneMadre]
  @codice_pk_posizione_figlia int
AS
BEGIN
   SET NOCOUNT ON;
   
   SELECT 
 
  	   RIGHT( '0000000000'+ CONVERT(varchar(20),aupoc_codice_pk),10)+ isnull(tb_aupoc_pos_contr.aupoc_contro_codice,'') as DB_IdPosContr,
       aupoc_posizione			AS DB_PosizioneContributiva,
		tb_aurea_area_gestione.aurea_descrizione AS DB_GestioneContributiva,
		
		
   aurpp_aupoc_cod_pk_madre AS DB_CodiceMadre,

   (
     /* SUBQUERY per recuperare lo stato della posizione MADRE */ 
	 SELECT     
	 auspc_descr
		
	 FROM dbo.tb_aupoc_pos_contr 
		
	 INNER JOIN 
	 dbo.tb_auspc_stato_pos_contr_ct 
	 ON dbo.tb_aupoc_pos_contr.aupoc_auspc_codice_pk = dbo.tb_auspc_stato_pos_contr_ct.auspc_codice_pk
		
	 WHERE tb_aupoc_pos_contr.aupoc_codice_pk = aurpp_aupoc_cod_pk_madre
   )
   AS DB_Stato,
   
 
   tb_ausin_sedi_inps_ct.ausin_codice_sede + ' - '+  tb_ausin_sedi_inps_ct.ausin_descr As DB_Sede
  

   FROM dbo.tb_aupoc_pos_contr 
   
   
   INNER JOIN tb_auapp_appl ON 
   tb_aupoc_pos_contr.aupoc_auapp_codice_pk = tb_auapp_appl.auapp_codice_pk

   INNER JOIN
   dbo.tb_aurpp_rel_poc_poc 
   ON dbo.tb_aupoc_pos_contr.aupoc_codice_pk = dbo.tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_madre
   
   INNER JOIN
   dbo.tb_auspc_stato_pos_contr_ct 
   ON dbo.tb_aupoc_pos_contr.aupoc_auspc_codice_pk = dbo.tb_auspc_stato_pos_contr_ct.auspc_codice_pk
   	
   INNER JOIN tb_aurea_area_gestione ON
   tb_aupoc_pos_contr.aupoc_aurea_codice_pk=tb_aurea_area_gestione.aurea_codice_pk
   
   LEFT OUTER JOIN tb_ausin_sedi_inps_ct 
   ON 
   --right(tb_aupoc_pos_contr.aupoc_cod_sede_INPS,4)=tb_ausin_sedi_inps_ct.ausin_codice_sede
   --Modificato da Letizia 06/12/2012
   tb_aupoc_pos_contr.aupoc_ausin_codice_pk=tb_ausin_sedi_inps_ct.ausin_codice_pk
   
    --Aggiunto da Letizia 11/01/2013
	LEFT OUTER JOIN tb_aupco_periodo_contr ON 
	tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk AND
	convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
		
	LEFT OUTER JOIN tb_aucsc_cod_stat_contr_ct
	on aupco_cod_stat_contr=tb_aucsc_cod_stat_contr_ct.aucsc_codice
	--fine Letizia 11/01/2013
	
   WHERE dbo.tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia = @codice_pk_posizione_figlia
END


