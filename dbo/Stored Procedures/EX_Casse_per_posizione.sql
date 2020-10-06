

-- =============================================
-- Autore:		Almaviva 
-- Data:		2018.11.08
-- Acquisisce una posizione e ritorna l'elenco delle casse previdenziali associate
-- Se la posizione non viene fornita ritorna -1
-- Se la posizione non esiste ritorna -2
-- Se la posizione non è pubblica ritorna -3
-- =============================================
create PROCEDURE [dbo].[EX_Casse_per_posizione]
	@posizione as varchar(50)
AS
BEGIN
  SET NOCOUNT ON;

  if @posizione is null
	return -1  -- posizione non fornita

IF ( EXISTS
	 (Select aupoc_codice_pk FROM  tb_aupoc_pos_contr
	  where aupoc_posizione = @posizione) 
	 ) 
	 begin
			if (exists (select top(1) aupoc_posizione from tb_aupoc_pos_contr
						where aupoc_aurea_codice_pk = 3 and aupoc_posizione = @posizione)
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
						where aupoc_posizione = @posizione and aupoc_aurea_codice_pk = 3
				end
				else
					return -3 -- posizione non pubblica
	 end
	 else
		return -2 --posizione assente
	return 0

END

