


CREATE VIEW [dbo].[VI_AU_Lista_Periodi_Contributivi]
as SELECT 
						aupoc_posizione as Posizione,
						convert(date,aupco_data_inizio_validita) as DataInizioOutput,
						convert(date,aupco_data_fine_validita) as DataFineOutput,
						aupco_cod_stat_contr as csc,
						aupco_codici_autor as CA,
						auate_cod_ateco_complessivo as Ateco2007,
						ausin_codice_sede as CodiceSede,
						ausin_descr as DescrizioneSede
						FROM tb_aupoc_pos_contr 
						left outer join tb_aupco_periodo_contr on aupco_aupoc_codice_pk = aupoc_codice_pk
						left outer join tb_auate_cod_ateco_ct on [aupco_auate_2007_codice_pk] = auate_codice_pk
						left outer join tb_ausin_sedi_inps_ct on aupoc_ausin_codice_pk = ausin_codice_pk 
						 where 1=1
						 and aupoc_aurea_codice_pk = 1

