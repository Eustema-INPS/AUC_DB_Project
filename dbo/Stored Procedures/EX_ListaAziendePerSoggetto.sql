-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2015.02.17
-- Description:	Estrae dati delle pos. contibutive che afferiscono al sogg. collegato  TIT, Rapp. Legale o Altro Resp.
-- =============================================
-- =============================================
-- Autore:		Letizia Bellantoni
-- Data:		2015.11.25
-- Ottimizzata con aggiunta di WITH (READUNCOMMITTED) 
-- Modificata da: Raffaele
-- Data:		2016.10.03
-- Descrizione:	Conversione getdate
-- =============================================
CREATE PROCEDURE  [dbo].[EX_ListaAziendePerSoggetto]
	@codice_fiscale_SoggColl varchar(16)	

	
AS

BEGIN

	SET NOCOUNT ON;

	select

	 tb_ausca_sog_contr_az.ausca_codice_fiscale AS [CF_SoggettoContribuente]
	,tb_aupoc_pos_contr.aupoc_codice_pk as CodicePosizioneAUC
	,tb_aupoc_pos_contr.aupoc_contro_codice as ControCodicePosizioneAUC
	,tb_aupoc_pos_contr.aupoc_posizione as CodiceGestionale
	,tb_aurea_area_gestione.aurea_descrizione as Gestione
	,tb_aupoc_pos_contr.aupoc_denom_posiz_contr as DenominazionePosizione 
	,CASE tb_aurss_rel_sog_sog.aurss_autis_codice_pk
				WHEN 89 THEN '1'
				WHEN 90 THEN '1'
				else  '2'
	END	AS TipoSoggetto
	,tb_aurss_rel_sog_sog.aurss_data_inizio_validita as DataInizioRelazione--,DataInizioRelazione
	,tb_aurss_rel_sog_sog.aurss_data_di_fine_validita as DataFineRelazione--,DataFineRelazione
	,case
	  when ((tb_aurss_rel_sog_sog.aurss_data_di_fine_validita >= GETDATE() )  and
		(tb_aurss_rel_sog_sog.aurss_data_inizio_validita <= GETDATE() )) or 
		(tb_aurss_rel_sog_sog.aurss_data_di_fine_validita is null)
		or (tb_aurss_rel_sog_sog.aurss_data_inizio_validita is null)	then 1
		else 0
	end as ATTIVO		
	FROM   
	tb_ausco_sog_contr_col WITH (READUNCOMMITTED)
	INNER JOIN	tb_aurss_rel_sog_sog WITH (READUNCOMMITTED) ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk 
	INNER JOIN	tb_autis_tipo_sog_col_ct WITH (READUNCOMMITTED) ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk 
	INNER JOIN	tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
	INNER JOIN  tb_aupoc_pos_contr WITH (READUNCOMMITTED) ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk=tb_ausca_sog_contr_az.ausca_codice_pk
	INNER JOIN  tb_aurea_area_gestione WITH (READUNCOMMITTED) on tb_aurea_area_gestione.aurea_codice_pk=tb_aupoc_pos_contr.aupoc_aurea_codice_pk
	WHERE     tb_ausco_sog_contr_col.ausco_codice_fiscale = @codice_fiscale_SoggColl
								AND 
	(tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 89 OR tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 90
		or aurss_rappresentante_legale='S')
	

	UNION 

	select
	 tb_ausca_sog_contr_az.ausca_codice_fiscale AS [CF_SoggettoContribuente]
	,tb_aupoc_pos_contr.aupoc_codice_pk as CodicePosizioneAUC
	,tb_aupoc_pos_contr.aupoc_contro_codice as ControCodicePosizioneAUC
	,tb_aupoc_pos_contr.aupoc_posizione as CodiceGestionale
	,tb_aurea_area_gestione.aurea_descrizione as Gestione
	,tb_aupoc_pos_contr.aupoc_denom_posiz_contr as DenominazionePosizione 
	, 'B' AS TipoSoggetto
	,tb_aursp_rel_sog_pos.aursp_data_inizio_validita as DataInizioRelazione--,DataInizioRelazione
	,tb_aursp_rel_sog_pos.aursp_data_di_fine_validita  as DataFineRelazione--,DataFineRelazione
	,case
	 		when ( 
			(convert(date,GETDATE(),103) BETWEEN aursp_data_inizio_validita AND aursp_data_di_fine_validita)

			--(aursp_data_di_fine_validita >= GETDATE() )  and	(aursp_data_inizio_validita <= GETDATE() )
			) 
			     or 
				(aursp_data_di_fine_validita is null) or (aursp_data_inizio_validita is null)	then 1
				else 0
                     						
	end as ATTIVO					
	FROM   
	tb_ausco_sog_contr_col WITH (READUNCOMMITTED)
	INNER JOIN    tb_aursp_rel_sog_pos WITH (READUNCOMMITTED) ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk 
	INNER JOIN    tb_autis_tipo_sog_col_ct WITH (READUNCOMMITTED) ON tb_aursp_rel_sog_pos.aursp_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk 
	INNER JOIN    tb_aupoc_pos_contr WITH (READUNCOMMITTED) ON tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk
	INNER JOIN    tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk 
	INNER JOIN    tb_aurea_area_gestione WITH (READUNCOMMITTED) ON tb_aupoc_pos_contr.aupoc_aurea_codice_pk = tb_aurea_area_gestione.aurea_codice_pk 
	WHERE     tb_ausco_sog_contr_col.ausco_codice_fiscale = @codice_fiscale_SoggColl
	and tb_aursp_rel_sog_pos.aursp_autis_codice_pk = 97
                      						
END
