-- ======================================================================
-- Author:		Quirino Vannimartini
-- Create date: 03-10-2011
-- Description:	Stored per la ricerca dei Soggetti Delegati tramite codice fiscale
-- ======================================================================
CREATE PROCEDURE [dbo].[SD_RicercaCF]
	@CF varchar(16)
AS
BEGIN	
	SET NOCOUNT ON;
	
	SELECT  TOP(1)
		audel_codice_pk				AS DB_CodiceSoggetto,
		ISNULL(audel_cognome, '') + ' ' + ISNULL(audel_nome, '')
									AS DB_Denominazione,
		audel_codice_fiscale		AS DB_CodiceFiscale,
		audel_note					AS DB_Note,
		aurad_data_inizio_validita	AS DB_InizioVal,
		aurad_data_fine_validita	AS DB_FineVal,
		autid_tipo_delegato			AS DB_TipoDelegato,
		autid_descr					AS DB_Descrizione,
		ausca_denominazione			AS DB_DenomAzienda,
		ausca_codice_fiscale		AS DB_CodFiscAzienda,
		aupoc_posizione				AS DB_PosizioneContributiva,
--		aupoc_stato_posizione		AS DB_StatoPosizione,
		auapp_app_name				AS DB_Gestione
	FROM
		tb_audel_del INNER JOIN
		tb_aurad_rel_az_del ON 
			audel_codice_pk = aurad_audel_codice_pk INNER JOIN
		tb_autid_tipo_del_ct ON 
			aurad_autid_codice_pk = autid_codice_pk INNER JOIN
		tb_aupoc_pos_contr ON 
			aurad_aupoc_codice_pk = aupoc_codice_pk INNER JOIN
		tb_ausca_sog_contr_az ON 
			aupoc_ausca_codice_pk = ausca_codice_pk INNER JOIN
		tb_auapp_appl ON 
			aupoc_auapp_codice_pk = auapp_codice_pk
	WHERE 
		audel_codice_fiscale = @CF AND 
			((tb_aurad_rel_az_del.aurad_data_fine_validita IS NULL) or 
	( convert(varchar,tb_aurad_rel_az_del.aurad_data_fine_validita, 103) <= '31/12/2999'))

	ORDER by
		DB_Denominazione,
		DB_CodiceSoggetto

END
