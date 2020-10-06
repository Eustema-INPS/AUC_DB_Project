



CREATE VIEW [dbo].[Vi_AU_PEC_INDIR]
AS
SELECT     
	dbo.tb_ausca_sog_contr_az.ausca_codice_fiscale AS CF_Azienda, 
	dbo.tb_ausca_sog_contr_az.ausca_denominazione AS Ragione_Sociale,
	dbo.tb_ausca_sog_contr_az.ausca_toponimo AS Toponimo_Sede_Legale,
	dbo.tb_ausca_sog_contr_az.ausca_indirizzo AS Indirizzo_Sede_Legale,
	dbo.tb_ausca_sog_contr_az.ausca_civico AS Civico_Sede_Legale,
	dbo.tb_ausca_sog_contr_az.ausca_descr_comune AS Comune_Sede_Legale,
	dbo.tb_ausca_sog_contr_az.ausca_sigla_provincia AS  Provincia_Sede_Legale,
	dbo.tb_ausca_sog_contr_az.ausca_cap AS Cap_Sede_Legale,
	dbo.tb_ausca_sog_contr_az.ausca_email AS Email,
	dbo.tb_ausca_sog_contr_az.ausca_PEC AS PEC
FROM  dbo.tb_ausca_sog_contr_az 


