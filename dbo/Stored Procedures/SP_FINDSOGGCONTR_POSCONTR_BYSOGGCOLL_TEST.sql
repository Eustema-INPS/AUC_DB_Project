-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2013.11.27
-- Description:	Estrae dati dell'azienda/e o della/e posizione contributiva che afferiscono al soggetto collegato.
-- Aggiornamento: 2014.04.07 Aggiunto su richiesta estrazione codice sede Inps
-- =============================================
CREATE PROCEDURE  [dbo].[SP_FINDSOGGCONTR_POSCONTR_BYSOGGCOLL_TEST]
	@codice_fiscale varchar(16)	

	
AS

declare @ausco_codice_pk integer;
SET NOCOUNT ON;
BEGIN
--verifico se esiste record su AUSCO
IF ( EXISTS
	 (Select tb_ausco_sog_contr_col.ausco_codice_pk FROM  tb_ausco_sog_contr_col
	  where tb_ausco_sog_contr_col.ausco_codice_fiscale = @codice_fiscale) 
	 ) 
		BEGIN
		--cerco relazioni su AURSS
				

						DECLARE @TT_AURSS TABLE 
						(
						RifTable varchar(10),
						[Codice_Fiscale] varchar(16),
						[Identificativo_AUC] varchar (50), 
						Denominazione varchar(405),
						[Ruolo_Utente] varchar(50),
						[Carica_Utente] varchar(50),
						Aurss_codice_PK bigint,
						Ausco_Codice_fiscale varchar(16),
						rownumber int
						)



						Insert into @TT_AURSS
											SELECT 
									
											'AURSS' as [RifTable],
											tb_ausca_sog_contr_az.ausca_codice_fiscale AS [Codice_Fiscale], 
											convert(varchar,tb_ausca_sog_contr_az.ausca_codice_pk) as [Identificativo_AUC], 
											tb_ausca_sog_contr_az.ausca_denominazione AS Denominazione, 
											CASE tb_aurss_rel_sog_sog.aurss_autis_codice_pk
														WHEN 89 THEN 'Titolare'
														WHEN 90 THEN 'Titolare'
														else  'Rappresentante Legale'
											END	AS [Ruolo_Utente],
											--tb_aurss_rel_sog_sog.aurss_autis_codice_pk,
											tb_autis_tipo_sog_col_ct.autis_descr AS [Carica_Utente],
											tb_aurss_rel_sog_sog.aurss_codice_pk as Aurss_codice_PK,
											tb_ausco_sog_contr_col.ausco_codice_fiscale as Ausco_Codice_fiscale,
											row_number() over (partition by tb_ausca_sog_contr_az.ausca_codice_fiscale order by tb_autis_tipo_sog_col_ct.autis_ordinamento  )AS rownumber
													
											
											FROM   
											tb_ausco_sog_contr_col INNER JOIN
											tb_aurss_rel_sog_sog ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk INNER JOIN
											tb_autis_tipo_sog_col_ct ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk INNER JOIN
											tb_ausca_sog_contr_az ON tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
											WHERE     tb_ausco_sog_contr_col.ausco_codice_fiscale = @codice_fiscale
																	  AND 
											(tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 89 OR tb_aurss_rel_sog_sog.aurss_autis_codice_pk = 90
											  or aurss_rappresentante_legale='S')
											AND
											(
												((tb_aurss_rel_sog_sog.aurss_data_di_fine_validita >= GETDATE() )  and
												(tb_aurss_rel_sog_sog.aurss_data_inizio_validita <= GETDATE() )) or 
												(tb_aurss_rel_sog_sog.aurss_data_di_fine_validita is null)
												or (tb_aurss_rel_sog_sog.aurss_data_inizio_validita is null)	
											)
								
							
						select * from @TT_AURSS A
						where A.Aurss_codice_PK in 
						(
						SELECT TOP 1 B.Aurss_codice_PK FROM @TT_AURSS B 
						where
						A.[Codice_Fiscale]=B.[Codice_Fiscale] 
						order by  rownumber asc)


													
								
			    	-- cerco relazione su AURSP e restituisco Elenco B 
							
				
					--SELECT   
					
					--  'AURSP' as [RifTable],
					--  tb_ausco_sog_contr_col.ausco_codice_pk, 
					--  tb_ausca_sog_contr_az.ausca_codice_fiscale AS [Codice_Fiscale], 
     --                 tb_aupoc_pos_contr.aupoc_denom_posiz_contr AS Denominazione, 
     --                 tb_aurea_area_gestione.aurea_descrizione AS [Tipo_Gestione], 
     --                 tb_aupoc_pos_contr.aupoc_posizione AS Posizione,
     --                 --Letizia aggiornamento 20140407
     --                 tb_aupoc_pos_contr.aupoc_cod_sede_INPS  as [Codice_Sede_Inps],
     --                 --Letizia aggiornamento 20140407 end
     --                 CONVERT(varchar, tb_aupoc_pos_contr.aupoc_codice_pk) AS [Identificativo_AUC],
     --                  tb_auspc_stato_pos_contr_ct.auspc_descr AS [Stato_Posizione], 
     --                 'Altro Responsabile' AS [Ruolo_Utente]
					--  FROM         tb_ausco_sog_contr_col INNER JOIN
     --                 tb_aursp_rel_sog_pos ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk INNER JOIN
     --                 tb_autis_tipo_sog_col_ct ON tb_aursp_rel_sog_pos.aursp_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk INNER JOIN
     --                 tb_aupoc_pos_contr ON tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk INNER JOIN
     --                 tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk INNER JOIN
     --                 tb_aurea_area_gestione ON tb_aupoc_pos_contr.aupoc_aurea_codice_pk = tb_aurea_area_gestione.aurea_codice_pk INNER JOIN
     --                 tb_auspc_stato_pos_contr_ct ON tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
					--	WHERE     
					--	tb_ausco_sog_contr_col.ausco_codice_fiscale = @codice_fiscale
					--	AND	
						  
     --                  --escludo le righe in cui azienda (codice fiscale ausca) compare già come risultato della prima query
     --                  tb_ausca_sog_contr_az.ausca_codice_fiscale  not in
     --                  (SELECT B.[Codice_Fiscale]  FROM @TT_AURSS B )
					--	AND
					--  (tb_aursp_rel_sog_pos.aursp_autis_codice_pk = 97) AND (tb_aursp_rel_sog_pos.aursp_data_di_fine_validita >= GETDATE()) AND 
     --                 (tb_aursp_rel_sog_pos.aursp_data_inizio_validita <= GETDATE()) OR
     --                 (tb_aursp_rel_sog_pos.aursp_autis_codice_pk = 97) AND (tb_aursp_rel_sog_pos.aursp_data_di_fine_validita IS NULL) OR
     --                 (tb_aursp_rel_sog_pos.aursp_autis_codice_pk = 97) AND (tb_aursp_rel_sog_pos.aursp_data_inizio_validita IS NULL)
                 SELECT   
					
					  'AURSP' as [RifTable],
					  tb_ausco_sog_contr_col.ausco_codice_pk, 
					  tb_ausca_sog_contr_az.ausca_codice_fiscale AS [Codice_Fiscale], 
                      tb_aupoc_pos_contr.aupoc_denom_posiz_contr AS Denominazione, 
                      tb_aurea_area_gestione.aurea_descrizione AS [Tipo_Gestione], 
                      tb_aupoc_pos_contr.aupoc_posizione AS Posizione,
                      --Letizia aggiornamento 20140407
                      tb_aupoc_pos_contr.aupoc_cod_sede_INPS  as [Codice_Sede_Inps],
                      --Letizia aggiornamento 20140407 end
                      CONVERT(varchar, tb_aupoc_pos_contr.aupoc_codice_pk) AS [Identificativo_AUC],
                       tb_auspc_stato_pos_contr_ct.auspc_descr AS [Stato_Posizione], 
                      'Altro Responsabile' AS [Ruolo_Utente],
					  tb_ausca_sog_contr_az.ausca_codice_fiscale,tb_aursp_rel_sog_pos.aursp_autis_codice_pk,tb_aursp_rel_sog_pos.aursp_data_di_fine_validita,tb_aursp_rel_sog_pos.aursp_data_inizio_validita
					  INTO #TEMP01
					  FROM         tb_ausco_sog_contr_col INNER JOIN
                      tb_aursp_rel_sog_pos ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk INNER JOIN
                      tb_autis_tipo_sog_col_ct ON tb_aursp_rel_sog_pos.aursp_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk INNER JOIN
                      tb_aupoc_pos_contr ON tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk INNER JOIN
                      tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk INNER JOIN
                      tb_aurea_area_gestione ON tb_aupoc_pos_contr.aupoc_aurea_codice_pk = tb_aurea_area_gestione.aurea_codice_pk INNER JOIN
                      tb_auspc_stato_pos_contr_ct ON tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
						WHERE     
						tb_ausco_sog_contr_col.ausco_codice_fiscale ='BRGMLA60B67D284H'
						OPTION (FORCE ORDER);


						SELECT   
						  'AURSP' as [RifTable],
					  ausco_codice_pk, 
					   [Codice_Fiscale], 
                       Denominazione, 
                       [Tipo_Gestione], 
                       Posizione,
                      --Letizia aggiornamento 20140407
                       [Codice_Sede_Inps],
                      --Letizia aggiornamento 20140407 end
					  Identificativo_AUC,
                       [Stato_Posizione], 
                       [Ruolo_Utente]
					   FROM #TEMP01
						  WHERE
                       --escludo le righe in cui azienda (codice fiscale ausca) compare già come risultato della prima query
                       ausca_codice_fiscale  not in                    (SELECT B.[Codice_Fiscale]  FROM @TT_AURSS B ) AND
					  (aursp_autis_codice_pk = 97) AND (aursp_data_di_fine_validita >= GETDATE()) AND 
                      (aursp_data_inizio_validita <= GETDATE()) OR
                      (aursp_autis_codice_pk = 97) AND (aursp_data_di_fine_validita IS NULL) OR
                      (aursp_autis_codice_pk = 97) AND (aursp_data_inizio_validita IS NULL)
				
				END
		
ELSE
--non esiste riga su ausco  la stored ritorna False
RETURN 1
END

