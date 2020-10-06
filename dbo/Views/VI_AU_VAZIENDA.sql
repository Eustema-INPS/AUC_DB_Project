
CREATE VIEW [dbo].[VI_AU_VAZIENDA]
AS
SELECT 
substring(dbo.tb_aupoc_pos_contr.aupoc_posizione,1,10) AS MatricolaAzienda
,dbo.tb_ausca_sog_contr_az.ausca_codice_fiscale AS CFAzienda
,CONVERT(varchar(10), dbo.tb_aupoc_pos_contr.aupoc_codice_pk) + CONVERT(varchar(2), dbo.tb_aupoc_pos_contr.aupoc_contro_codice) AS CodiceAUC
,SUBSTRING(dbo.tb_ausca_sog_contr_az.ausca_denominazione, 1, 50) AS RagioneSociale, dbo.tb_aungi_nat_giur_ct.aungi_codice_forma AS CodiceClassificazione
,SUBSTRING(dbo.tb_auind_indirizzi.auind_descr_comune, 1, 50) AS Luogo, substring(dbo.tb_auind_indirizzi.auind_cap,1,5) AS CAP
,dbo.tb_auind_indirizzi.auind_sigla_provincia AS Provincia, substring(dbo.tb_auate_cod_ateco_ct.auate_cod_ateco_complessivo,1,6) AS CodiceAteco
,CONVERT(varchar(2), dbo.tb_auspc_stato_pos_contr_ct.auspc_codice) AS CodiceStatoAzienda
,convert(date,dbo.tb_aupoc_pos_contr.aupoc_data_ultimo_stato) AS DataEventoStato
,CASE WHEN dbo.tb_aupoc_pos_contr.aupoc_data_domanda_iscr IS NULL 
     THEN convert(date,'19000101') ELSE convert(date,dbo.tb_aupoc_pos_contr.aupoc_data_domanda_iscr) END AS DataDomandaIscrizione
,convert(date,dbo.tb_aupoc_pos_contr.aupoc_data_inizio_attivita) AS DataInizioAttività

FROM            dbo.tb_auind_indirizzi WITH (READUNCOMMITTED) INNER JOIN
                         dbo.tb_ausca_sog_contr_az WITH (READUNCOMMITTED) INNER JOIN
                         dbo.tb_aupoc_pos_contr WITH (READUNCOMMITTED) ON dbo.tb_ausca_sog_contr_az.ausca_codice_pk = dbo.tb_aupoc_pos_contr.aupoc_ausca_codice_pk ON 
                         dbo.tb_auind_indirizzi.auind_tabella_codice_pk = dbo.tb_aupoc_pos_contr.aupoc_codice_pk INNER JOIN
                         dbo.tb_aungi_nat_giur_ct WITH (READUNCOMMITTED) ON dbo.tb_ausca_sog_contr_az.ausca_aungi_codice_pk = dbo.tb_aungi_nat_giur_ct.aungi_codice_pk LEFT OUTER JOIN
                         dbo.tb_auate_cod_ateco_ct WITH (READUNCOMMITTED) ON dbo.tb_aupoc_pos_contr.aupoc_auate_2007_codice_pk = dbo.tb_auate_cod_ateco_ct.auate_codice_pk LEFT OUTER JOIN
                         dbo.tb_auspc_stato_pos_contr_ct WITH (READUNCOMMITTED) ON dbo.tb_aupoc_pos_contr.aupoc_auspc_codice_pk = dbo.tb_auspc_stato_pos_contr_ct.auspc_codice_pk
WHERE        (dbo.tb_auind_indirizzi.auind_tabella = 'AUPOC') AND (dbo.tb_aupoc_pos_contr.aupoc_aurea_codice_pk = 1) AND 
                         (SUBSTRING(LTRIM(dbo.tb_aupoc_pos_contr.aupoc_posizione), 1, 1) <> 'Z')






