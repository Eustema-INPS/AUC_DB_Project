


-- =============================================
-- Author:		Emanuela
-- Create date: 2019.01.08
-- Description:	Stored per caricare i CF Collegati
-- =============================================

CREATE PROCEDURE [dbo].[VA_CFCollegati] 
	@codsogg int
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT       TB_AUIAC_INTERFACCIA_ARCA_COLLEGATO.AUIAC_CODICE_PK, TB_AUIAC_INTERFACCIA_ARCA_COLLEGATO.AUIAC_CHIAVE_AUC, 
                         TB_AUIAC_INTERFACCIA_ARCA_COLLEGATO.AUIAC_CODICE_FISCALE_COLLEGATO, TB_AUIAC_INTERFACCIA_ARCA_COLLEGATO.AUIAC_Attuale_Collegato, 
                         TB_AUIAC_INTERFACCIA_ARCA_COLLEGATO.AUIAC_DATA_INSERIMENTO, tb_ausco_sog_contr_col.ausco_codice_pk AS DB_Codice, tb_ausco_sog_contr_col.ausco_codice_fiscale AS DB_CodiceFiscale, 
                         CASE ausco_tipo_persona WHEN 'G' THEN substring(ausco_denominazione, 1, 255) ELSE ausco_cognome END AS DB_Cognome, tb_ausco_sog_contr_col.ausco_nome AS DB_Nome, 
                         tb_ausco_sog_contr_col.ausco_tipo_persona AS DB_TipoPersona, tb_ausco_sog_contr_col.ausco_sesso AS DB_Sesso, tb_ausco_sog_contr_col.ausco_toponimo AS DB_Toponimo, 
                         tb_ausco_sog_contr_col.ausco_indirizzo + ' ' + ISNULL(tb_ausco_sog_contr_col.ausco_civico, '') AS DB_Indirizzo, tb_ausco_sog_contr_col.ausco_cap AS DB_Cap, 
                         tb_ausco_sog_contr_col.ausco_localita AS DB_Luogo, tb_ausco_sog_contr_col.ausco_provincia AS DB_Provincia, tb_ausco_sog_contr_col.ausco_sigla_nazione AS DB_Nazione, 
                         tb_ausco_sog_contr_col.ausco_cittadinanza AS DB_Cittadinanza, tb_ausco_sog_contr_col.ausco_comune_nascita AS DB_ComuneNascita, CONVERT(VARCHAR(10), tb_ausco_sog_contr_col.ausco_data_nascita, 
                         103) AS DB_DataNascita, tb_ausco_sog_contr_col.ausco_prov_nascita AS DB_ProvinciaNascita, tb_ausco_sog_contr_col.ausco_stato_estero_nascita AS DB_StatoEsteroNascita, 
                         tb_ausco_sog_contr_col.ausco_telefono AS DB_Telefono, tb_ausco_sog_contr_col.ausco_fax AS DB_Fax, tb_ausco_sog_contr_col.ausco_email AS DB_Email, tb_ausco_sog_contr_col.ausco_pec AS DB_Pec, 
                         tb_ausco_sog_contr_col.ausco_legalmail AS DB_LegalMail, tb_ausco_sog_contr_col.ausco_note AS DB_Note, tb_ausco_sog_contr_col.ausco_residenza_frazione AS DB_ResidenzaFrazione, 
                         tb_ausco_sog_contr_col.ausco_residenza_altre_indic AS DB_ResidenzaAltreIndic, tb_ausco_sog_contr_col.ausco_codice_comune_nascita AS DB_NascitaCodComune, 
                         tb_ausco_sog_contr_col.ausco_residenza_codice_comune AS DB_ResidenzaCodComune, tb_ausco_sog_contr_col.ausco_residenza_codice_stato AS DB_ResidenzaCodStato
FROM            tb_ausco_sog_contr_col INNER JOIN
                         TB_AUIAC_INTERFACCIA_ARCA_COLLEGATO ON TB_AUIAC_INTERFACCIA_ARCA_COLLEGATO.AUIAC_CHIAVE_AUC = tb_ausco_sog_contr_col.ausco_codice_pk
WHERE        (tb_ausco_sog_contr_col.ausco_codice_pk = CONVERT(bigint, @codsogg))
END

