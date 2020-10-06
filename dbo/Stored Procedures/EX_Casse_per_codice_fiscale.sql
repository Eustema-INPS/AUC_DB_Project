
-- =============================================
-- Autore:		Almaviva 
-- Data:		2018.11.08
-- Acquisisce un codice fiscale e ritorna l'elenco delle casse previdenziali associate alle posizioni pubbliche
-- Se il cf non viene fornito ritorna -1
-- Se il cf non esiste ritorna -2
-- Se non esistono posizioni pubbliche ritorna -3
-- =============================================
CREATE PROCEDURE [dbo].[EX_Casse_per_codice_fiscale]
	@cf as varchar(16)
AS
BEGIN
  SET NOCOUNT ON;

  if @cf is null
	return -1

IF ( EXISTS
	 (Select ausca_codice_pk FROM  tb_ausca_sog_contr_az
	  where ausca_codice_fiscale = @cf) 
	 ) 
	 begin
			if (exists (select top(1) aupoc_posizione,ausca_codice_fiscale from tb_aupoc_pos_contr
						inner join tb_ausca_sog_contr_az on ausca_codice_pk = aupoc_ausca_codice_pk
						where aupoc_aurea_codice_pk = 3 and ausca_codice_fiscale = @cf)
						
				)
				begin
					select	ausca_codice_fiscale as cf,
								aupoc_posizione as posizione,
								auica_cassa as cassa,
								aucas_descrizione_brevre as descrizioneCassa,
								convert(date,auica_data_inizio) as DataInizioValiditaCassa,
								convert(date,auica_data_fine) as DataFineValiditaCassa
						from tb_ausca_sog_contr_az
						inner join tb_aupoc_pos_contr on ausca_codice_pk = aupoc_ausca_codice_pk
						inner join tb_auica_iscritte_casse on aupoc_codice_pk = auica_aupoc_codice_pk
						inner join tb_aucas_casse_inpdap on aucas_codice = auica_cassa
						where ausca_codice_fiscale = @cf and aupoc_aurea_codice_pk = 3
				end
				else
					return -3 -- assenza di posizioni pubbliche
	 end
	 else
		return -2 --cf assente
	return 0

END

