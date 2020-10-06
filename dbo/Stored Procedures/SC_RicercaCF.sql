-- =============================================
-- Author:		Quirino Vannimartini
-- Create date: 10-08-2011
-- Description:	Stored per la ricerca SCO tramite codice fiscale
-- =============================================
CREATE PROCEDURE [dbo].[SC_RicercaCF]
	@CF varchar(16)
AS
BEGIN	
	SET NOCOUNT ON;
	
	SELECT TOP(1)
		ausco_codice_pk				AS DB_CodiceSoggetto,
		ISNULL(ausco_cognome, '') + ' ' + ISNULL(ausco_nome, '')
									AS DB_Denominazione,
		ausco_codice_fiscale		AS DB_CodiceFiscale,
		ausco_localita				AS DB_Localita,
		ausco_provincia				AS DB_SiglaProvincia,
		ausco_codice_toponimo		AS DB_CodiceToponimo,
		ausco_indirizzo				AS DB_Indirizzo,
		ausco_civico				AS DB_Civico,
		ausco_localita				AS DB_Comune,
		ausco_provincia				AS DB_Provincia,
		ausco_cap					AS DB_Cap,
		--AI 2050:
		[ausco_cert_auten_cod_pk],
		[ausco_cert_cod_entita_rif],
		[ausco_certificato_arca]
		--AI 2050.

	FROM tb_ausco_sog_contr_col
	WHERE 
		ausco_codice_fiscale = @CF
	ORDER by DB_Denominazione
  
END

