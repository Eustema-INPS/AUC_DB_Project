CREATE PROCEDURE [dbo].[EX_DatiElencoMatricole]
  @MatricoleList AS MatricoleList READONLY
AS
BEGIN
  SET NOCOUNT ON;

SELECT   
	tb_ausca_sog_contr_az.ausca_codice_fiscale as CfSoggettoContribuente
	,tb_aurea_area_gestione.aurea_descrizione  as Gestione
	,tb_aupoc_pos_contr.aupoc_posizione as Matricola
	,tb_aupoc_pos_contr.aupoc_denom_posiz_contr as DenominazionePosizione
	,tb_aungi_nat_giur_ct.aungi_descr_breve as FormaGiuridica
	,tb_ausin_sedi_inps_ct.ausin_codice_sede as Sede 
	,tb_autia_tipo_accentr_ct.[autia_codice] as TipoAzienda
	,tb_auate_cod_ateco_ct.auate_cod_ateco_complessivo as  AttivitaEconomicaDichiarata
	,tb_aupco_periodo_contr.[aupco_cod_stat_contr] as CodiceStatisticoContributivo
	,tb_aupco_periodo_contr.[aupco_codici_autor] as CodiciAutorizzazione
	,Isnull(tb_auind_indirizzi.[auind_toponimo],' ') as PrefissoStradale
	,Isnull(tb_auind_indirizzi.[auind_indirizzo],' ')  as NomeVia
	,Isnull(tb_auind_indirizzi.[auind_civico],' ')  as NumeroCivico
	,Isnull(tb_auind_indirizzi.[auind_cap],' ')  as CAP
	,Isnull(tb_auind_indirizzi.[auind_descr_comune],' ')  as Comune
	,Isnull(tb_auind_indirizzi.[auind_sigla_provincia],' ')  as Provincia
	,Isnull(tb_ausca_sog_contr_az.ausca_toponimo,' ')  as PrefissoStradale_SL
	,Isnull(tb_ausca_sog_contr_az.ausca_indirizzo,' ')  as NomeVia_SL
	,Isnull(tb_ausca_sog_contr_az.ausca_civico,' ')  as NumeroCivico_SL
	,Isnull(tb_ausca_sog_contr_az.ausca_cap,' ')  as CAP_SL
	,Isnull(tb_ausca_sog_contr_az.ausca_descr_comune,' ')  as Comune_SL
	,Isnull(tb_ausca_sog_contr_az.ausca_sigla_provincia,' ')  as Provincia_SL
	,tb_auspc_stato_pos_contr_ct.auspc_codice as Stato
	,aupoc_codice_pk as Codice_AUC
	,aupoc_contro_codice as ControCodice_AUC
FROM  tb_aupoc_pos_contr WITH (READUNCOMMITTED) INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON 
	tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk --AUSCA
	LEFT JOIN tb_ausin_sedi_inps_ct WITH (READUNCOMMITTED)  ON 
			  tb_aupoc_pos_contr.aupoc_ausin_codice_pk = tb_ausin_sedi_inps_ct.ausin_codice_pk  --AUSIN
	LEFT JOIN tb_aungi_nat_giur_ct WITH (READUNCOMMITTED) ON 
			 tb_ausca_sog_contr_az.ausca_aungi_codice_pk = tb_aungi_nat_giur_ct.aungi_codice_pk --AUNGI
	LEFT JOIN tb_autia_tipo_accentr_ct  WITH (READUNCOMMITTED)  ON 
		aupoc_autia_codice_pk = autia_codice_pk-- AUTIA
	LEFT JOIN tb_aupco_periodo_contr WITH (READUNCOMMITTED) ON  
		aupco_aupoc_codice_pk = aupoc_codice_pk  AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita --AUPCO
	LEFT JOIN tb_auate_cod_ateco_ct WITH (READUNCOMMITTED)  ON 
		dbo.tb_aupco_periodo_contr.aupco_auate_2007_codice_pk = auate_codice_pk -- AUATE
	LEFT JOIN tb_auind_indirizzi   WITH (READUNCOMMITTED) ON 
		UPPER(auind_tabella) = 'AUPOC' AND auind_tabella_codice_pk = aupoc_codice_pk --AUIND
	INNER JOIN tb_aurea_area_gestione WITH (READUNCOMMITTED) ON 
		tb_aupoc_pos_contr.aupoc_aurea_codice_pk=tb_aurea_area_gestione.aurea_codice_pk --AUREA
	LEFT JOIN tb_auspc_stato_pos_contr_ct WITH (READUNCOMMITTED) ON 
		tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
	INNER JOIN @MatricoleList MatrList ON tb_aupoc_pos_contr.aupoc_posizione=MatrList.Matricola
END

