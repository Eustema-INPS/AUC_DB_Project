


-- =============================================
-- Autore:		Raffaele Palmieri
-- Data:		29/2/2016
-- Per la posizione fornita ritorna un insieme di dati relativi ai soggetti aziendali ad essa collegati.
-- Viene richiamata da Simula
-- =============================================
CREATE PROCEDURE [dbo].[EX_ListaSoggetti] @aupoc_posizione varchar(50), @data date
AS
SET NOCOUNT ON;

BEGIN
-- verifico se esiste record su AUPOC
IF ( EXISTS
	 (Select tb_aupoc_pos_contr.aupoc_codice_pk FROM  tb_aupoc_pos_contr
	  where @AUPOC_POSIZIONE = tb_aupoc_pos_contr.aupoc_posizione )--and aupoc_aurea_codice_pk = 1) 
	 ) 
	BEGIN

	SELECT				ausca_codice_fiscale as CodiceFiscaleAzienda,
						aupoc_posizione as Posizione,
						CASE WHEN tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 89 THEN '1' 
						     WHEN tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 90 THEN '1' 
							 ELSE '2' 
					    END AS TipoRelazione, 
                        tb_ausco_sog_contr_col.ausco_codice_fiscale AS CF, 
						aurss_data_inizio_validita as data_inizio,
						aurss_data_di_fine_validita as data_fine
						FROM 
						tb_ausca_sog_contr_az WITH (READUNCOMMITTED) 
						INNER JOIN tb_aupoc_pos_contr WITH (READUNCOMMITTED) ON 
							 tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk
						left JOIN  tb_aurss_rel_sog_sog  WITH (READUNCOMMITTED) ON 
							 tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk 
    					inner join tb_ausco_sog_contr_col WITH (READUNCOMMITTED) ON 
							tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk

						 where 1=1
						 AND @AUPOC_POSIZIONE = tb_aupoc_pos_contr.aupoc_posizione
						 AND tb_aurss_rel_sog_sog.aurss_rappresentante_legale = 'S'
						 and tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
						 AND -- Data odierna compresa nelle date di inizio e fine validità
						 (
  							(@data >= convert(date,aurss_data_inizio_validita) AND @data <= convert(date,aurss_data_di_fine_validita))
							   or	 
							(@data >= convert(date,aurss_data_inizio_validita) AND aurss_data_di_fine_validita IS NULL)
						 ) 	
						 group by ausca_codice_fiscale, aupoc_posizione,-- aungi_codice_forma, ausin_codice_sede,
						 CASE WHEN tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 89 THEN '1' 
						     WHEN tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 90 THEN '1' 
							 ELSE '2' 
					     END ,  ausco_codice_fiscale, aurss_data_inizio_validita, aurss_data_di_fine_validita
END
		
ELSE
-- non esiste riga su aupoc  la stored ritorna False
RETURN 1
END

