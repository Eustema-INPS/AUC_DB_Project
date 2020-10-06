-- ======================================================================
-- Author:		Quirino Vannimartini
-- Create date: 06-10-2011
-- Description:	Stored per caricare la scheda anagrafica del soggetto Delegato
-- ======================================================================
CREATE PROCEDURE [dbo].[SD_SchedaAnagraficaSoggetto]
	@codSoggetto int
AS
BEGIN	
	SET NOCOUNT ON;
	
	SELECT
		audel_codice_pk				AS DB_CodiceSoggetto,
		ISNULL(audel_cognome, '')	AS DB_Cognome,
		ISNULL(audel_nome, '')		AS DB_Nome,
		audel_codice_fiscale		AS DB_CodiceFiscale,
		audel_note					AS DB_Note,
		audel_tipo_persona			AS DB_TipoPersona, 
		audel_sesso					AS DB_Sesso,
		audel_toponimo				AS DB_Toponimo,
		audel_indirizzo + ' ' + isnull(audel_civico, '')
									AS DB_Indirizzo,
		audel_cap					AS DB_Cap,
		audel_descr_comune			AS DB_Comune,
		audel_provincia				AS DB_Provincia,
		CONVERT(VARCHAR(10), audel_data_nascita, 103)
									AS DB_DataNascita,
		audel_comune_nascita		AS DB_ComuneNascita,
		audel_prov_nascita			AS DB_ProvinciaNascita,
		audel_telefono1				AS DB_Telefono1,
		audel_telefono2				AS DB_Telefono2,
		audel_fax					AS DB_Fax,
		autid_tipo_delegato			AS DB_TipoDelegato,
		autid_descr					AS DB_Descrizione,
		ausca_denominazione			AS DB_DenomAzienda,
		ausca_codice_fiscale		AS DB_CodFiscAzienda,
		aupoc_posizione				AS DB_PosizioneContributiva,
		audel_email		            AS DB_Email
	FROM
		tb_audel_del INNER JOIN
		tb_aurad_rel_az_del ON 
			audel_codice_pk = aurad_audel_codice_pk INNER JOIN
		tb_autid_tipo_del_ct ON 
			aurad_autid_codice_pk = autid_codice_pk INNER JOIN
		tb_aupoc_pos_contr ON 
			aurad_aupoc_codice_pk = aupoc_codice_pk INNER JOIN
		tb_ausca_sog_contr_az ON 
			aupoc_ausca_codice_pk = ausca_codice_pk
	WHERE 
		audel_codice_pk = @codSoggetto
END
