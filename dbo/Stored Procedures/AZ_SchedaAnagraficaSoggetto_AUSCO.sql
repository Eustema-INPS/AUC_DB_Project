


-- =============================================
-- Author:		PALETTA EMANUELA
-- Create date: 28-08-2018
-- Description:	Stored per caricare la scheda anagrafica del soggetto
-- =============================================
CREATE PROCEDURE [dbo].[AZ_SchedaAnagraficaSoggetto_AUSCO] 
	@codAusco varchar(500)
AS
BEGIN
	
	SET NOCOUNT ON;

    	SELECT 
		ausco_codice_pk 		AS DB_Codice, 		   
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
		ausco_residenza_codice_stato	AS DB_ResidenzaCodStato
	FROM
		tb_ausco_sog_contr_col 
		
	WHERE ausco_codice_pk = CONVERT(bigint, @codAusco)  
END



