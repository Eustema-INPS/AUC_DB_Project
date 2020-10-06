-- =============================================
-- Autore:		Raffaele Palmieri
-- Data:		12/2/2015
-- Per la posizione fornita ritorna un insieme di dati relativi ai soggetti aziendali ad essa collegati.
-- =============================================
-- =============================================
-- Autore:		Letizia Bellantoni
-- Data:		2015.11.25
-- Ottimizzazione della join con aggiunta di 
-- Modificata da: Raffaele
-- Data:		2016.10.03
-- Descrizione:	Conversione getdate
-- =============================================
CREATE PROCEDURE [dbo].[EX_ListaSoggettiCollegati]
	@aupoc_codice_pk int,
	@aupoc_controcodice int 
AS
--declare @aupoc_codice_pk integer;
SET NOCOUNT ON;

BEGIN
--verifico se esiste record su AUPOC
IF ( EXISTS
	 (Select tb_aupoc_pos_contr.aupoc_codice_pk FROM  tb_aupoc_pos_contr
	  where @AUPOC_CODICE_PK = tb_aupoc_pos_contr.aupoc_codice_pk AND @AUPOC_CONTROCODICE = tb_aupoc_pos_contr.aupoc_contro_codice) 
	 ) 
	BEGIN

	SELECT  
		    case when tb_aursp_rel_sog_pos.aursp_autis_codice_pk = 97 then 'B' else '' end as TipoRelazione,
			tb_ausco_sog_contr_col.ausco_nome AS Nome, 
			tb_ausco_sog_contr_col.ausco_cognome AS Cognome, 
            tb_ausco_sog_contr_col.ausco_codice_fiscale AS CF, 
--			NULL as PrefissoTelefono,
			CASE WHEN len(tb_ausco_sog_contr_col.ausco_telefono) < 3 THEN NULL ELSE tb_ausco_sog_contr_col.ausco_telefono END AS Telefono,
--			NULL as PrefissoCellulare, 
			CASE WHEN len(tb_ausco_sog_contr_col.ausco_telefono2) < 3 THEN NULL ELSE tb_ausco_sog_contr_col.ausco_telefono2 END AS CellulareTelefono, 
--			NULL as PrefissoFax,
			case when len(tb_ausco_sog_contr_col.ausco_fax)<3 then NULL else tb_ausco_sog_contr_col.ausco_fax end AS Fax, 
			tb_ausco_sog_contr_col.ausco_email AS Email, 
            case when len(tb_ausco_sog_contr_col.ausco_pec)<3 then NULL else tb_ausco_sog_contr_col.ausco_pec end  AS PEC,  
			CONVERT(date,tb_aursp_rel_sog_pos.aursp_data_inizio_validita) as DataInizioRelazione, 
			CONVERT(date,tb_aursp_rel_sog_pos.aursp_data_di_fine_validita) as DataFineRelazione,
			case
				when (
				(convert(date,GETDATE(),103) BETWEEN aursp_data_inizio_validita AND aursp_data_di_fine_validita)
				--(aursp_data_di_fine_validita >= GETDATE() )  and
				--(aursp_data_inizio_validita <= GETDATE() )
				) or 
				(aursp_data_di_fine_validita is null)
				or (aursp_data_inizio_validita is null)	then 1
				else 0
			end as ATTIVO,		
			tb_ausco_sog_contr_col.ausco_cap AS CAPResidenza, 
			tb_ausco_sog_contr_col.ausco_localita AS CITTAResidenza, 
            tb_ausco_sog_contr_col.ausco_provincia AS PROVINCIAResidenza, 
			tb_ausco_sog_contr_col.ausco_toponimo AS PrefissoStradaleResidenza, 
            tb_ausco_sog_contr_col.ausco_indirizzo AS IndirizzoViaResidenza, 
			tb_ausco_sog_contr_col.ausco_civico AS IndirizzoNumeroResidenza, 
            tb_ausco_sog_contr_col.ausco_comune_nascita AS ComuneDiNascita, 
			tb_ausco_sog_contr_col.ausco_prov_nascita AS ProvinciaDiNascita, 
            
			--CONVERT(date,tb_ausco_sog_contr_col.ausco_data_nascita) AS DataDiNascita 
			-- Italo 25/11/2015
			CASE isnull(tb_ausco_sog_contr_col.ausco_data_nascita,'1900-01-01 00:00:00.000') 
				WHEN '1900-01-01 00:00:00.000' 
					THEN '1900-01-01 00:00:00.000' 
					ELSE CONVERT(date,tb_ausco_sog_contr_col.ausco_data_nascita) 
				END AS DataDiNascita 

	FROM            tb_ausco_sog_contr_col WITH (READUNCOMMITTED) INNER JOIN
                         tb_aursp_rel_sog_pos WITH (READUNCOMMITTED) ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk INNER JOIN
                         tb_aupoc_pos_contr  WITH (READUNCOMMITTED) ON tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk
						 where 1=1
						 AND @AUPOC_CODICE_PK = tb_aupoc_pos_contr.aupoc_codice_pk
						 AND @AUPOC_CONTROCODICE = tb_aupoc_pos_contr.aupoc_contro_codice
						 AND tb_aursp_rel_sog_pos.aursp_autis_codice_pk = 97
--						 AND -- Data odierna compresa nelle date di inizio e fine validità
--						 (
--  							(getdate() >= aursp_data_inizio_validita AND getdate() <= aursp_data_di_fine_validita)
--							   or	 
--							(getdate() >= aursp_data_inizio_validita AND aursp_data_di_fine_validita IS NULL)
--						 ) 	
	UNION ALL
SELECT
						CASE WHEN tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 89 THEN '1' 
						     WHEN tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 90 THEN '1' 
							 ELSE '2' 
					    END AS TipoRelazione, 
						tb_ausco_sog_contr_col.ausco_nome AS Nome, 
						tb_ausco_sog_contr_col.ausco_cognome AS Cognome, 
                        tb_ausco_sog_contr_col.ausco_codice_fiscale AS CF, 
--						NULL as PrefissoTelefono,
						CASE WHEN len(tb_ausco_sog_contr_col.ausco_telefono) < 3 THEN NULL ELSE tb_ausco_sog_contr_col.ausco_telefono END AS Telefono,
--						NULL as PrefissoCellulare, 
						CASE WHEN len(tb_ausco_sog_contr_col.ausco_telefono2) < 3 THEN NULL ELSE tb_ausco_sog_contr_col.ausco_telefono2 END AS CellulareTelefono, 
--						NULL as PrefissoFax,
						CASE WHEN len(tb_ausco_sog_contr_col.ausco_fax) < 3 THEN NULL ELSE tb_ausco_sog_contr_col.ausco_fax END AS Fax, 
						tb_ausco_sog_contr_col.ausco_email AS Email, 
						CASE WHEN len(tb_ausco_sog_contr_col.ausco_pec) < 3 THEN NULL ELSE tb_ausco_sog_contr_col.ausco_pec END AS PEC, 
						CONVERT(date, tb_aurss_rel_sog_sog.aurss_data_inizio_validita) AS DataInizioRelazione, 
                        CONVERT(date, tb_aurss_rel_sog_sog.aurss_data_di_fine_validita) AS DataFineRelazione, 
						case
							when (
									  (convert(date,GETDATE(),103) BETWEEN aurss_data_inizio_validita AND aurss_data_di_fine_validita)
							  --      (tb_aurss_rel_sog_sog.aurss_data_di_fine_validita >= GETDATE() )  and
									--(tb_aurss_rel_sog_sog.aurss_data_inizio_validita <= GETDATE() )
									) or 
								(tb_aurss_rel_sog_sog.aurss_data_di_fine_validita is null)
								or (tb_aurss_rel_sog_sog.aurss_data_inizio_validita is null)	then 1
							else 0
						end as ATTIVO,		
						tb_ausco_sog_contr_col.ausco_cap AS CAPResidenza, 
                        tb_ausco_sog_contr_col.ausco_localita AS CITTAResidenza, 
						tb_ausco_sog_contr_col.ausco_provincia AS PROVINCIAResidenza, 
                        tb_ausco_sog_contr_col.ausco_toponimo AS PrefissoStradaleResidenza, 
						tb_ausco_sog_contr_col.ausco_indirizzo AS IndirizzoViaResidenza, 
                        tb_ausco_sog_contr_col.ausco_civico AS IndirizzoNumeroResidenza, 
						tb_ausco_sog_contr_col.ausco_comune_nascita AS ComuneDiNascita, 
                        tb_ausco_sog_contr_col.ausco_prov_nascita AS ProvinciaDiNascita, 
						--CONVERT(date, tb_ausco_sog_contr_col.ausco_data_nascita) AS DataDiNascita 
						-- Italo 25/11/2015
						CASE isnull(tb_ausco_sog_contr_col.ausco_data_nascita,'1900-01-01 00:00:00.000') 
							WHEN '1900-01-01 00:00:00.000' 
								THEN '1900-01-01 00:00:00.000' 
								ELSE CONVERT(date,tb_ausco_sog_contr_col.ausco_data_nascita) 
							END AS DataDiNascita 
						FROM tb_ausco_sog_contr_col WITH (READUNCOMMITTED) INNER JOIN  tb_aurss_rel_sog_sog  WITH (READUNCOMMITTED) ON 
							 tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON 
							 tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk INNER JOIN tb_aupoc_pos_contr WITH (READUNCOMMITTED) ON 
							 tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk
						 where 1=1
						 AND @AUPOC_CODICE_PK = tb_aupoc_pos_contr.aupoc_codice_pk
						 AND @AUPOC_CONTROCODICE = tb_aupoc_pos_contr.aupoc_contro_codice
						 AND tb_aurss_rel_sog_sog.aurss_rappresentante_legale = 'S'
						 and tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
--						 AND -- Data odierna compresa nelle date di inizio e fine validità
--						 (
--  							(getdate() >= aurss_data_inizio_validita AND getdate() <= aurss_data_di_fine_validita)
--							   or	 
--							(getdate() >= aurss_data_inizio_validita AND aurss_data_di_fine_validita IS NULL)
--						 ) 	
			
END
		
ELSE
--non esiste riga su aupoc  la stored ritorna False
RETURN 1
END
