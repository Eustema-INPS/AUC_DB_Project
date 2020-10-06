








CREATE VIEW [dbo].[VI_AU_VSOGGETTICOLLEGATI]
AS
SELECT                   tb_ausco_sog_contr_col.ausco_codice_fiscale as CFSoggettoCollegato, 
						 tb_ausca_sog_contr_az.ausca_codice_fiscale as CFAzienda, 
						 case 
						 when tb_autis_tipo_sog_col_ct.autis_codice_pk=89 then 'TIT'
						 when tb_autis_tipo_sog_col_ct.autis_codice_pk=90 then 'TIT'
						 else 'RL'
						 end as Tipo, 
						 
						 case
						 when tb_aurss_rel_sog_sog.aurss_data_inizio_validita is null then convert(date,'19000101')
						 else convert(date,tb_aurss_rel_sog_sog.aurss_data_inizio_validita) 
 						 end as DataInizio,
						 
						 case
						 when tb_aurss_rel_sog_sog.aurss_data_di_fine_validita = convert(datetime,'31/12/2999',103) then convert(date,'99991231')
						 else convert(date,tb_aurss_rel_sog_sog.aurss_data_di_fine_validita)
						 end as DataFine
						 

FROM            tb_aurss_rel_sog_sog WITH (READUNCOMMITTED) INNER JOIN
                         tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk INNER JOIN
                         tb_ausco_sog_contr_col WITH (READUNCOMMITTED) ON tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk INNER JOIN
                         Vi_Ausca_Con_Posizioni_DM WITH (READUNCOMMITTED) ON tb_ausca_sog_contr_az.ausca_codice_fiscale = Vi_Ausca_Con_Posizioni_DM.ausca_codice_fiscale LEFT OUTER JOIN
                         tb_autis_tipo_sog_col_ct WITH (READUNCOMMITTED) ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
WHERE        (tb_aurss_rel_sog_sog.aurss_rappresentante_legale = 'S')






