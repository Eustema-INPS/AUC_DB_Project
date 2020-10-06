-- ======================================================================
-- Author:		Quirino Vannimartini
-- Create date: 13/10/2011
-- Description:	Stored Procedure per caricare i Soggetti Delegati dell'azienda
-- Modificata da: Raffaele
-- Data:		2016.10.03
-- Descrizione:	Conversione getdate
-- ======================================================================
CREATE PROCEDURE [dbo].[AZ_ElencoSoggettiDelegati]
	@codiceAzienda int

AS
BEGIN

	SET NOCOUNT ON;

	SELECT
		audel_codice_pk				AS DB_CodiceSoggetto,
		ISNULL(audel_cognome, '')	AS DB_Cognome,
		ISNULL(audel_nome, '')		AS DB_Nome,
		audel_codice_fiscale		AS DB_CodiceFiscale,
		audel_note					AS DB_Note,
		autid_tipo_delegato			AS DB_TipoDelegato,
		autid_descr					AS DB_Descrizione,
		ausca_denominazione			AS DB_DenomAzienda,
		ausca_codice_fiscale		AS DB_CodFiscAzienda,
		aupoc_posizione				AS DB_PosizioneContributiva,
		aurad_data_inizio_validita	AS DB_DataInizioValidita,
		aurad_data_fine_validita	AS DB_DataFineValidita,
		auapp_descr                 AS DB_Gestione
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
		ausca_codice_pk = @codiceAzienda AND 
		( (convert(date,GETDATE(),103) BETWEEN tb_aurad_rel_az_del.aurad_data_inizio_validita AND tb_aurad_rel_az_del.aurad_data_fine_validita)
		--tb_aurad_rel_az_del.aurad_data_fine_validita >= GETDATE() AND
		--tb_aurad_rel_az_del.aurad_data_inizio_validita <= GETDATE() 
		)
	ORDER BY
		DB_Cognome,
		DB_Nome,
		DB_CodiceSoggetto

END
