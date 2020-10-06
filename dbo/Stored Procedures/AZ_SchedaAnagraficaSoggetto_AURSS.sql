

-- =============================================
-- Author:		Chiara Pugliese
-- Create date: 23-06-2011
-- Description:	Stored per caricare la scheda anagrafica del soggetto
-- Modificata da: Raffaele
-- Data:		25.10.2012
-- Descrizione:	Modificata la validazione di DB_Cognome anche se andrebbe gestito come DB_Denominazione
-- Author:		Stefano Panuccio
-- Modifica date: 2017.08.07
-- Description:	(AI3116) Reperimento di nuovi campi (@codAzienda opzionale per preservare vecchia interfaccia)
-- =============================================
CREATE PROCEDURE [dbo].[AZ_SchedaAnagraficaSoggetto_AURSS] 
	@codAurss varchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	SELECT     
		ausco_codice_fiscale	AS DB_CodiceFiscale, 
		
		Case ausco_tipo_persona
		when 'G' then substring(ausco_denominazione,1,255) 
		else  ausco_cognome
		end	AS DB_Cognome,
		 
		ausco_nome				AS DB_Nome, 
		ausco_tipo_persona		AS DB_TipoPersona, 
		ausco_sesso				AS DB_Sesso,
		ausco_toponimo			AS DB_Toponimo,
		ausco_indirizzo + ' ' + isnull(ausco_civico, '')
								AS DB_Indirizzo,
		ausco_cap				AS DB_Cap,
		ausco_localita			AS DB_Luogo,
		ausco_provincia			AS DB_Provincia,
		ausco_sigla_nazione		AS DB_Nazione,
		ausco_cittadinanza		AS DB_Cittadinanza,
		ausco_comune_nascita	AS DB_ComuneNascita,
		CONVERT(VARCHAR(10), ausco_data_nascita, 103)
								AS DB_DataNascita,
		--isnull(ausco_prov_nascita, '') + ' ' + isnull(ausco_stato_estero_nascita, '')
		--						AS DB_ProvStatoNascita,
		ausco_prov_nascita			AS DB_ProvinciaNascita,
		ausco_stato_estero_nascita	AS DB_StatoEsteroNascita,
		ausco_telefono				AS DB_Telefono,
		ausco_fax					AS DB_Fax,
		ausco_email					AS DB_Email,
		ausco_pec					AS DB_Pec,
		ausco_legalmail				AS DB_LegalMail,
		ausco_note					AS DB_Note,
		ausco_residenza_frazione	AS DB_ResidenzaFrazione,
		ausco_residenza_altre_indic	AS DB_ResidenzaAltreIndic,
		ausco_codice_comune_nascita		AS DB_NascitaCodComune,
		ausco_residenza_codice_comune	AS DB_ResidenzaCodComune,
		ausco_residenza_codice_stato	AS DB_ResidenzaCodStato,
		aurss_prog_pers				AS DB_Progressivo,
		aurss_progressivo_carica	AS DB_ProgrCarica,
		aurss_cap_agire				AS DB_CapAgire,
		aurss_flag_se_elettore		AS DB_FlagElettore,
		aurss_potere_firma			AS DB_PotereFirma,
		aurss_quote_partec			AS DB_QuotePartecipazione,
		aurss_perce_partec			AS DB_PercPartecipazione,
		aurss_quote_partec_e		AS DB_QuotePartecipazioneEuro,
		aurss_quota_c_valuta		AS DB_CodValuta,
		aurss_cod_durata_carica		AS DB_CodDurataCarica,
		aurss_anni_ese_carica		AS DB_AnniEsercizioCarica,
		aurss_posizione				AS DB_Posizione,
		CONVERT(date, aurss_data_pres_carica, 103) AS DB_DataInizioCarica,
		tb_aurss_rel_sog_sog.aurss_codice_pk,
		tb_aurss_rel_sog_sog.aurss_posizione AS DB_Posizione
	FROM
		tb_ausco_sog_contr_col 
		INNER JOIN tb_aurss_rel_sog_sog ON tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk 
		INNER JOIN tb_ausca_sog_contr_az ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aurss_rel_sog_sog.aurss_ausca_codice_pk
		INNER JOIN tb_autis_tipo_sog_col_ct ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
	WHERE aurss_codice_pk = CONVERT(bigint, @codAurss)  
END


