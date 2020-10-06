
-- =============================================
-- Author:		Vincenzo Pinto
-- =============================================

-- =========================================================================================================
-- Modificata da:  Quirino
-- Data modifica:  18/06/2013
-- Description:		Cambio prelevamento dati. Tabella utilizzata "tb_aucfv_cfvar" Variazioni Codici Fiscali
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_ElencoVariazioni]
AS
BEGIN

-- modifica Quirino 18/06/2013  INIZIO
--SELECT  
--	Sync_DM_aupoc_variazioni.id, 
--	Sync_DM_aupoc_variazioni.St_aupoc_posizione AS DB_Posizione, 
--	Sync_DM_aupoc_variazioni.St_aupoc_codice_fiscale_DM AS DB_CodFisDM, 
--	Sync_DM_aupoc_variazioni.St_aupoc_codice_fiscale_AUC AS DB_CodFisAUC, 
--	Sync_DM_aupoc_variazioni.St_aupoc_Partita_IVA AS DB_PIva, 
--	Sync_DM_aupoc_variazioni.St_aupoc_ausca_codice_pk_DM AS DB_CodiceDM, 
--	Sync_DM_aupoc_variazioni.St_aupoc_ausca_codice_pk_AUC AS DB_CodiceAUC, 
--	Sync_DM_aupoc_variazioni.St_aupoc_ausin_codice_pk AS DB_CodiceAusin, 
--	Sync_DM_aupoc_variazioni.St_aupoc_data_modifica AS DB_DataModifica, 
--	Sync_DM_aupoc_variazioni.St_aupoc_aupoc_descr_utente AS DB_DescrUtente, 
--	Ausin.ausin_codice_sede + ' - ' + Ausin.ausin_descr AS  DB_SedeInps
--FROM 
--	Sync_DM_aupoc_variazioni LEFT OUTER JOIN tb_ausin_sedi_inps_ct AS Ausin ON 
--		Sync_DM_aupoc_variazioni.St_aupoc_ausin_codice_pk = Ausin.ausin_codice_pk

	SET NOCOUNT ON;
	
	SELECT 
		aucfv_codice_pk,
		aucfv_matricola_DM	AS DB_Posizione,
		aucfv_cf_partenza	AS DB_CFpartenza,
		aucfv_cf_target		AS DB_CFtarget,
		aucfv_tipo_azione	AS DB_TipoAzione,
		CONVERT(varchar(10), aucfv_data_modifica, 103)
							AS DB_DataModifica,
		aucfv_descr_utente	AS DB_DescrUtente
	FROM 
		tb_aucfv_cfvar
	ORDER BY 
		aucfv_data_modifica desc

	
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100
-- modifica Quirino 18/06/2013  FINE

END


