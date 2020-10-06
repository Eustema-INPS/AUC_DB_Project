-- =============================================
-- Author:		Chiara Pugliese
-- Create date: 23-06-2011
-- Description:	Stored per la ricerca SCA tramite codice fiscale
-- =============================================
-- =============================================
-- Author:		Letizia Bellantoni
-- Modifica date: 16-10-2012
-- Description:	Aggiunto criterio di ricerca sul codice sede
-- =============================================
-- =============================================
-- Author:		Letizia Bellantoni
-- Modifica date: 07-11-2012
-- Description:	Modifica sul criterio di ricerca  codice sede;aggiunta FK su aupoc
-- =============================================
-- =============================================
-- Author:		Letizia Bellantoni
-- Modifica date: 16-01-2013
-- Description:	Modifica sul criterio di ricerca, eliminato filtro per codice sede
-- =============================================


CREATE PROCEDURE [dbo].[AZ_RicercaCF]
	@CF varchar(16)
AS
BEGIN	
SET NOCOUNT ON;

	SELECT 
		ausca_codice_pk as DB_CodiceAzienda,
		ausca_denominazione as DB_Denominazione,
		ausca_codice_fiscale as DB_CodiceFiscale,
		ausca_localita as DB_Localita,
		ausca_sigla_provincia as DB_SiglaProvincia,
		ausca_codice_toponimo as DB_CodiceToponimo,
		ausca_indirizzo as DB_Indirizzo,
		ausca_civico as DB_Civico,
		ausca_descr_comune as DB_Comune,
		ausca_regione as DB_Regione,
		ausca_cap as DB_Cap,
		ausca_soggetto_certificato as DB_SoggettoCertificato,
		ausca_auten_codice_pk as DB_CodiceTipoEntita,
		ausca_codice_entita_rif as DB_CodiceEntita
		
--		FROM         tb_aucfi_cod_fiscale INNER JOIN
--                      tb_ausca_sog_contr_az ON tb_aucfi_cod_fiscale.aucfi_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
--WHERE     (tb_aucfi_cod_fiscale.aucfi_codice_fiscale = @CF)

	FROM tb_ausca_sog_contr_az 
	WHERE 
		ausca_codice_fiscale = @CF
	
	ORDER by ausca_denominazione
  
 END
