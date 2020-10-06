-- ===================================================================
-- Author:		Letizia Bellantoni
-- Create date: 17-04-2012
-- Description:	Stored per la ricerca AZ tramite codice poscontr
-- ===================================================================
CREATE  PROCEDURE [dbo].[AZ_RicercaPosContributiva]
	
	@PosContributiva varchar(50)
AS
BEGIN	
	SET NOCOUNT ON;
	 SELECT top 1
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
	inner join
	tb_aupoc_pos_contr
	on tb_aupoc_pos_contr.aupoc_ausca_codice_pk=tb_ausca_sog_contr_az.ausca_codice_pk
	WHERE 
		tb_aupoc_pos_contr.aupoc_posizione= @PosContributiva
		
END
