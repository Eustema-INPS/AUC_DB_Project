-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 13-04-2012
-- Description:	Stored per la ricerca AZ tramite chiave AUPOC e ControCodice
-- =============================================
CREATE  PROCEDURE [dbo].[AZ_RicercaCodiceAuscaCC]
	@CodicePK integer,
	@ControCodice varchar(2)
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
	FROM tb_ausca_sog_contr_az 
	
	WHERE 
		[ausca_codice_pk]= @CodicePK
		and
		[ausca_contro_codice]=@ControCodice
END
