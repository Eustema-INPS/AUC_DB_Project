
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,> 
-- =============================================

CREATE PROCEDURE [dbo].[EX_DatiMatricola_VGUNICO]
	@matricola as varchar(50),
	@codiceFiscale as varchar(20)
AS
BEGIN

IF(@matricola IS NOT NULL AND @codiceFiscale IS NULL)
BEGIN
	SELECT AUSCA.ausca_codice_fiscale as [CodiceFiscaleSoggettoContribuente]
		,SUBSTRING (@matricola ,12 , 5 ) as Progressivo
		,AUPOC.aupoc_posizione as Matricola
		,AUSCA.ausca_denominazione as [DenominazioneSoggettoContribuente]
		,AUPOC.aupoc_denom_posiz_contr as [DenominazionePosizione]
		,NG.aungi_descr_breve as [NaturaGiuridica]
		,NG.aungi_codice_forma as [ClassificazioneNaturaGiuridica]
		,AUSCA.ausca_piva as [PartitaIva]
		,PCON.[aupco_codici_autor] as [CodCA]
		,PCON.[aupco_cod_stat_contr] as [CodCSC]
		,AUATE.auate_cod_ateco_complessivo as [CodIstatAteco]
		,AUSCA.ausca_sigla_provincia as [SiglaProvinciaSedeLegale]
	    ,ausca.ausca_cod_com_ISTAT as [CodIstatComuneSedeLegale]
		,AUSCA.ausca_cap as [CapSedeLegale]
		,CONCAT(AUSCA.ausca_toponimo , ' ', AUSCA.ausca_indirizzo)  [IndirizzoSedeLegale] 		
		,ausca.ausca_civico as [CivicoSedeLegale]
		,AUSIN.ausin_codice_sede as [SedeInps4]
		,AUSIN.ausin_codice_regione+AUSIN.ausin_codice_sede as [SedeInps6]
		,AUPOC.aupoc_data_inizio_attivita as [DataInizioAttivita]
		,AUSPC.auspc_codice as StatoPosizione
		,AUPOC.aupoc_data_ultimo_stato as [DataUltimoStato]
		,AUCAS.aucas_descrizione_brevre as descrizioneCassa
		,convert(date,AUICA.auica_data_inizio) as DataInizioValiditaCassa
		,convert(date,AUICA.auica_data_fine) as DataFineValiditaCassa
		,AUSCA.ausca_cciaa AS [CodiceCCIAA]
		,ausca.ausca_PEC AS [Pec]
		,case when (EXISTS(select * from tb_aupoc_pos_contr
		inner join tb_auvas_var_stato_pos on auvas_aupoc_codice_pk = AUPOC.aupoc_codice_pk
		where auvas_auspc_codice_pk = 5 and aupoc_posizione = @matricola)) then (select max(convert(date,auvas_data_variazione_stato)) from tb_aupoc_pos_contr
		inner join tb_auvas_var_stato_pos on auvas_aupoc_codice_pk = aupoc_codice_pk
		where auvas_auspc_codice_pk = 5 and aupoc_posizione = @matricola)
		else convert(date,AUPOC.aupoc_data_domanda_iscr) end as DataRiattivazione
		FROM  
		tb_aupoc_pos_contr AUPOC WITH(NOLOCK)
		INNER JOIN tb_ausca_sog_contr_az AUSCA WITH(NOLOCK) ON AUPOC.aupoc_ausca_codice_pk = AUSCA.ausca_codice_pk 
		INNER JOIN tb_auica_iscritte_casse AUICA WITH(NOLOCK) on AUPOC.aupoc_codice_pk = AUICA.auica_aupoc_codice_pk
		INNER JOIN tb_aucas_casse_inpdap AUCAS WITH(NOLOCK) ON  AUICA.auica_aucas_codice_pk = AUCAS.aucas_codice_pk
		LEFT JOIN tb_ausin_sedi_inps_ct AUSIN WITH(NOLOCK) ON AUPOC.aupoc_ausin_codice_pk = AUSIN.ausin_codice_pk  --AUSIN
		LEFT JOIN tb_aungi_nat_giur_ct NG WITH(NOLOCK) ON AUSCA.ausca_aungi_codice_pk = NG.aungi_codice_pk --AUNGI
		LEFT JOIN tb_autia_tipo_accentr_ct AUTIA WITH(NOLOCK) ON aupoc_autia_codice_pk = autia_codice_pk-- AUTIA
		LEFT JOIN tb_aupco_periodo_contr PCON WITH(NOLOCK) ON  aupco_aupoc_codice_pk = aupoc_codice_pk 
		AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita --AUPCO
		LEFT JOIN tb_auate_cod_ateco_ct AUATE WITH(NOLOCK) ON PCON.aupco_auate_2007_codice_pk = auate_codice_pk -- AUATE
		INNER JOIN tb_aurea_area_gestione AUREA WITH(NOLOCK) ON AUPOC.aupoc_aurea_codice_pk=AUREA.aurea_codice_pk --AUREA
		LEFT JOIN tb_auspc_stato_pos_contr_ct AUSPC WITH(NOLOCK) ON AUPOC.aupoc_auspc_codice_pk = AUSPC.auspc_codice_pk
		where AUPOC.aupoc_posizione = @matricola
END

IF(@codiceFiscale IS NOT NULL AND @matricola IS NULL)
BEGIN
	SELECT AUSCA.ausca_codice_fiscale as [CodiceFiscaleSoggettoContribuente]
		,SUBSTRING (@matricola ,12 , 5 ) as Progressivo
		,AUPOC.aupoc_posizione as Matricola
		,AUSCA.ausca_denominazione as [DenominazioneSoggettoContribuente]
		,AUPOC.aupoc_denom_posiz_contr as [DenominazionePosizione]
		,NG.aungi_descr_breve as [NaturaGiuridica]
		,NG.aungi_codice_forma as [ClassificazioneNaturaGiuridica]
		,AUSCA.ausca_piva as [PartitaIva]
		,PCON.[aupco_codici_autor] as [CodCA]
		,PCON.[aupco_cod_stat_contr] as [CodCSC]
		,AUATE.auate_cod_ateco_complessivo as [CodIstatAteco]
		,AUSCA.ausca_sigla_provincia as [SiglaProvinciaSedeLegale]
	    ,ausca.ausca_cod_com_ISTAT as [CodIstatComuneSedeLegale]
		,AUSCA.ausca_cap as [CapSedeLegale]
		,CONCAT(AUSCA.ausca_toponimo , ' ', AUSCA.ausca_indirizzo)  [IndirizzoSedeLegale] 		
		,ausca.ausca_civico as [CivicoSedeLegale]
		,AUSIN.ausin_codice_sede as [SedeInps4]
		,AUSIN.ausin_codice_regione+AUSIN.ausin_codice_sede as [SedeInps6]
		,AUPOC.aupoc_data_inizio_attivita as [DataInizioAttivita]
		,AUSPC.auspc_codice as StatoPosizione
		,AUPOC.aupoc_data_ultimo_stato as [DataUltimoStato]
		,AUCAS.aucas_descrizione_brevre as descrizioneCassa
		,convert(date,AUICA.auica_data_inizio) as DataInizioValiditaCassa
		,convert(date,AUICA.auica_data_fine) as DataFineValiditaCassa
		,AUSCA.ausca_cciaa AS [CodiceCCIAA]
		,ausca.ausca_PEC AS [Pec]
		,case when (EXISTS(select * from tb_aupoc_pos_contr
		inner join tb_auvas_var_stato_pos on auvas_aupoc_codice_pk = AUPOC.aupoc_codice_pk
		where auvas_auspc_codice_pk = 5 and aupoc_posizione = @matricola)) then (select max(convert(date,auvas_data_variazione_stato)) from tb_aupoc_pos_contr
		inner join tb_auvas_var_stato_pos on auvas_aupoc_codice_pk = aupoc_codice_pk
		where auvas_auspc_codice_pk = 5 and aupoc_posizione = @matricola)
		else convert(date,AUPOC.aupoc_data_domanda_iscr) end as DataRiattivazione
		FROM  
		tb_aupoc_pos_contr AUPOC WITH(NOLOCK)
		INNER JOIN tb_ausca_sog_contr_az AUSCA WITH(NOLOCK) ON AUPOC.aupoc_ausca_codice_pk = AUSCA.ausca_codice_pk 
		INNER JOIN tb_auica_iscritte_casse AUICA WITH(NOLOCK) on AUPOC.aupoc_codice_pk = AUICA.auica_aupoc_codice_pk
		INNER JOIN tb_aucas_casse_inpdap AUCAS WITH(NOLOCK) ON  AUICA.auica_aucas_codice_pk = AUCAS.aucas_codice_pk
		LEFT JOIN tb_ausin_sedi_inps_ct AUSIN WITH(NOLOCK) ON AUPOC.aupoc_ausin_codice_pk = AUSIN.ausin_codice_pk  --AUSIN
		LEFT JOIN tb_aungi_nat_giur_ct NG WITH(NOLOCK) ON AUSCA.ausca_aungi_codice_pk = NG.aungi_codice_pk --AUNGI
		LEFT JOIN tb_autia_tipo_accentr_ct AUTIA WITH(NOLOCK) ON aupoc_autia_codice_pk = autia_codice_pk-- AUTIA
		LEFT JOIN tb_aupco_periodo_contr PCON WITH(NOLOCK) ON  aupco_aupoc_codice_pk = aupoc_codice_pk 
		AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita --AUPCO
		LEFT JOIN tb_auate_cod_ateco_ct AUATE WITH(NOLOCK) ON PCON.aupco_auate_2007_codice_pk = auate_codice_pk -- AUATE
		INNER JOIN tb_aurea_area_gestione AUREA WITH(NOLOCK) ON AUPOC.aupoc_aurea_codice_pk=AUREA.aurea_codice_pk --AUREA
		LEFT JOIN tb_auspc_stato_pos_contr_ct AUSPC WITH(NOLOCK) ON AUPOC.aupoc_auspc_codice_pk = AUSPC.auspc_codice_pk
		where ausca.ausca_codice_fiscale = @codiceFiscale
END

END
