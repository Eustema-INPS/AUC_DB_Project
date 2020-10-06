-- ===================================================================
-- Author:		Letizia Bellantoni
-- Modifica date: 2014-10-21
-- Descrizione  : aggiunti ausca_pec,aungi_descr_breve
-- ===================================================================
-- ===================================================================
-- Author:		  Letizia Bellantoni
-- Modifica date: 2014-10-27
-- Descrizione  : RF005 , aggiunti campi aupco_data_scad_autor,aupco_giorni_proroga,aupco_lavoratori_autonomi,aupco_ateco_2007(auate)
-- ===================================================================
-- ===================================================================
-- Author:		  Letizia Bellantoni
-- Modifica date: 2015-04-20
-- Descrizione  : AI 2060, modifica struttura DatiPopsizioneContributiva_Enpals,DatiPopsizioneContributiva_GestioneSeparata
-- ===================================================================
-- ===================================================================
-- Author:		  Raffaele Palmieri
-- Modifica date: 2016-06-13
-- Descrizione  : Introduzione dell'aurea 13 e del Datore Voucher
-- Modificata da: Raffaele
-- Data:		2016.10.03
-- Descrizione:	Conversione getdate
-- ===================================================================
-- ===================================================================
-- Author:		  Raffaele Palmieri
-- Modifica date: 2018-07-17
-- Descrizione  : Modificata la valorizzazione del codice sede INPS (AI 1089)
-- ===================================================================
CREATE PROCEDURE [dbo].[SP_FINDPOSCONTR_UNICA] 
	@aupoc_posizione varchar(50) = null,
	@aupoc_codice_pk int = null, 
	@aupoc_controcodice varchar(6) = null 
AS
BEGIN
SET NOCOUNT ON;

IF (@aupoc_posizione is not null)
	BEGIN
		SELECT 
		 [aupoc_codice_pk]
		,[aupoc_posizione] 
		--AI 2047:
		,[aupoc_denom_posiz_contr]
		--AI 2047.
		,[aupoc_data_modifica]
		,[aupoc_descr_utente]
		,[auspc_codice]
		,[auspc_descr]
		,[ausca_codice_fiscale]
		--AI 2047:
		,[ausca_denominazione]
		--AI 2047.
		--Letizia 20141021
		,ausca_pec
		,aungi_descr_breve
       --Letizia 20141021
		,[aupoc_contro_codice] 
		,[aupoc_cod_prov_istat]
		,[aupoc_cod_comune_istat]
		,[aupoc_prog_azienda_agr]
		,[aupoc_data_inizio_attivita]
		--AI 2051:
		,[aupoc_data_domanda_iscr]
		--AI 2051.
		,[aupoc_denom_posiz_contr]
		,[autdt_codice] -- tipo ditta (codice)
		,[autdt_descrizione]
		,[autd2_codice] 
		,[autd2_descrizione] 
-- AI 1089
		,case when isnull([aupoc_cod_sede_INPS],'--') = '--' then dbo.tb_ausin_sedi_inps_ct.ausin_codice_regione + dbo.tb_ausin_sedi_inps_ct.ausin_codice_sede 
		      else [aupoc_cod_sede_INPS] end as aupoc_cod_sede_INPS
-- AI 1089
		,ausin_descr
		--2013.08.27: dopo avvenuto allineamento di [aupoc_data_ultimo_stato] in produzione
		--,MAX([auvas_data_variazione_stato]) as auvas_data_variazione_stato_max
		,[aupoc_data_ultimo_stato] AS auvas_data_variazione_stato
		--2013.08.27.
		,[aupoc_ATECO] 
		-- Per estrazione Codici Autia
		,aupco_cod_stat_contr 
		,aupco_codici_autor 
		,autia_codice 
		,autia_descrizione 
		,[aupoc_progressivo_confluito] 
		,[aupoc_codice_categoria]
-- Inizio 20160613
		,CASE 
			WHEN aupoc_aurea_codice_pk in (5,12,13) THEN --Inserita area 13 per Datore Voucher
				CASE aupoc_tipo_posizione 
					WHEN 1 THEN 1
					WHEN 2 THEN 2
					ELSE 3						-- Inserito Datore Voucher
				END
			ELSE
				CASE aupoc_tipo_posizione 
					WHEN 1 THEN 2
					ELSE 1
				END
		
		END AS aupoc_tipo_posizione
		,CASE 
			WHEN aupoc_aurea_codice_pk in (5,12,13) THEN --Inserita area 13 per Datore Voucher
				CASE aupoc_tipo_posizione 
					WHEN 1 THEN 'Committente'
					WHEN 2 THEN 'Professionista'
					ELSE 'Datore Voucher'				-- Inserito Datore Voucher
				END
			ELSE
				CASE aupoc_tipo_posizione 
					WHEN 1 THEN 'Autonomo'
					ELSE 'Datore Lavoro'
				END
		
		END AS aupoc_tipo_posizione_descr
-- Fine 20160613
		--AI 2036:
--		,CASE [aupoc_tipo_posizione] WHEN 0 THEN 1 WHEN 1 THEN 2 ELSE 0 END as aupoc_tipo_posizione
--		,CASE [aupoc_tipo_posizione] WHEN 0 THEN 'Datore Lavoro' WHEN 1 THEN 'Autonomo' ELSE 'Non specificato' END as aupoc_tipo_posizione_descr
		--AI 2036.
		,[aupoc_aurea_codice_pk]
		,[aurea_descrizione]
		,[aupoc_codice_gruppo]
		,[aupoc_attivita_dichiarata]
		,[aupoc_id_sin]
		,[aupoc_id_confluito]
		,[aupoc_cf_confluito]
		,[aupoc_progressivo_confluito]
		,aupco_data_inizio_validita
		,aupco_data_fine_validita
		,aucat_descr
		,auind_CAP
		,auind_civico
		,auind_descr_comune
		,auind_indirizzo
		,auind_sigla_provincia
		,auind_telefono1
		,auind_telefono2
		,auind_toponimo
		--Letizia 20141027
	   ,aupco_data_scad_autor
	   ,aupco_giorni_proroga
	   ,aupco_lavoratori_autonomi
	   ,AUATE_AUPCO.[auate_cod_ateco_complessivo]
	   --Letizia 20141027
	   --AI 2058:
	   ,AUATE_AUPOC.auate_cod_ateco_complessivo AS aupoc_ateco_2007
	   --AI 2058.
	  
	   --AI 2060
	  , aupoc_aucom_codice as aupoc_compartimento
	  ,[tb_aucom_compartimento_ct].aucom_descr
	  ,aupoc_descr_stato_GS
	  --AI 2060

		FROM [dbo].[tb_aupoc_pos_contr]	left outer join [dbo].[tb_ausca_sog_contr_az] on 
		     tb_ausca_sog_contr_az.ausca_codice_pk = aupoc_ausca_codice_pk left outer join [dbo].[tb_auspc_stato_pos_contr_ct] on 
			 tb_auspc_stato_pos_contr_ct.auspc_codice_pk = aupoc_auspc_codice_pk
			 --2013.08.27:
				--left outer join [dbo].[tb_auvas_var_stato_pos] 
				--on tb_auvas_var_stato_pos.auvas_aupoc_codice_pk = aupoc_codice_pk
			--2013.08.27.
			left outer join [dbo].[tb_autdt_tipoditta_ct] on 
			tb_autdt_tipoditta_ct.autdt_codice_pk = aupoc_autdt_codice_pk left outer join [dbo].[tb_autd2_tipoditta2_ct] on 
			tb_autd2_tipoditta2_ct.autd2_codice_pk = aupoc_autd2_codice_pk left outer join dbo.tb_autia_tipo_accentr_ct ON 
			aupoc_autia_codice_pk = autia_codice_pk	left outer join dbo.tb_aupco_periodo_contr ON 
			(
				aupco_aupoc_codice_pk = aupoc_codice_pk	
			    AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
--				AND (aupco_data_inizio_validita <= GETDATE()) 
--				AND (aupco_data_fine_validita >= GETDATE())
			)
			left outer join dbo.tb_ausin_sedi_inps_ct -- AUSIN
-- AI 1089
			ON dbo.tb_aupoc_pos_contr.aupoc_ausin_codice_pk = ausin_codice_pk 
-- AI 1089
			left outer join dbo.tb_aurea_area_gestione -- AUREA
			ON aupoc_aurea_codice_pk = aurea_codice_pk
			left outer join dbo.tb_aucat_categoria_ct -- AUCAT
			ON aupoc_codice_categoria = aucat_codice
			left outer join tb_auind_indirizzi 
			ON UPPER(auind_tabella) = 'AUPOC' AND auind_tabella_codice_pk = aupoc_codice_pk
			 --Letiza 20141027
			left outer join [dbo].[tb_auate_cod_ateco_ct] AUATE_AUPCO 
			ON dbo.tb_aupco_periodo_contr.aupco_auate_2007_codice_pk = AUATE_AUPCO.auate_codice_pk 
			--Letiza 20141027

			--Letizia 20141021
			left outer join dbo.tb_aungi_nat_giur_ct
	        ON ausca_aungi_codice_pk = aungi_codice_pk     --AUNGI
	        --Letizia 20141021

			--AI 2058:
			left outer join [dbo].[tb_auate_cod_ateco_ct] AUATE_AUPOC -- AUATE-AUPOC
			ON dbo.tb_aupoc_pos_contr.aupoc_auate_2007_codice_pk = AUATE_AUPOC.auate_codice_pk 
			--AI 2058.
			
			--AI 2060
		    left outer join [dbo].[tb_aucom_compartimento_ct] --AUCOM
		    ON dbo.tb_aupoc_pos_contr.[aupoc_aucom_codice] =  [dbo].[tb_aucom_compartimento_ct].[aucom_codice]
			--AI 2060

		WHERE 
		(dbo.tb_aupoc_pos_contr.aupoc_posizione = @aupoc_posizione)
		AND (@aupoc_codice_pk IS NULL OR dbo.tb_aupoc_pos_contr.aupoc_codice_pk = @aupoc_codice_pk)
		AND (@aupoc_controcodice IS NULL OR dbo.tb_aupoc_pos_contr.aupoc_contro_codice = @aupoc_controcodice)
		GROUP BY 
		[aupoc_codice_pk]
		,[aupoc_posizione] 
		--AI 2047:
		,[aupoc_denom_posiz_contr]
		--AI 2047.
		,[aupoc_data_modifica]
		,[aupoc_descr_utente]
		,[auspc_codice]
		,[auspc_descr]
		,[ausca_codice_fiscale]
		--AI 2047:
		,[ausca_denominazione]
		--AI 2047.
		,[aupoc_contro_codice] 
		,[auspc_descr] 
		,[aupoc_cod_prov_istat]
		,[aupoc_cod_comune_istat]
		,[aupoc_prog_azienda_agr]
		,[aupoc_data_inizio_attivita]
		--AI 2051:
		,[aupoc_data_domanda_iscr]
		--AI 2051.
		,[aupoc_denom_posiz_contr]
		,[autdt_codice]
		,[autdt_descrizione]
		,[aupoc_cod_sede_INPS]
--AI 1089
		,ausin_codice_regione
		,ausin_codice_sede
--AI 1089
		,[autd2_codice] 
		,[autd2_descrizione] 
		,[aupoc_ateco] 
		,[aupco_cod_stat_contr] 
		,[aupco_codici_autor] 
		,[autia_codice] 
		,[aupoc_progressivo_confluito] 
		,[aupoc_codice_categoria]
		,[aupoc_tipo_posizione]
		,[aupoc_aurea_codice_pk]
		,[aurea_descrizione]
		,[aupoc_codice_gruppo]
		,[aupoc_attivita_dichiarata]
		,[aupoc_id_sin]
		,[aupoc_id_confluito]
		,[aupoc_cf_confluito]
		,ausin_descr
		,autia_descrizione 
		,aupco_data_inizio_validita
		,aupco_data_fine_validita
		,aucat_descr
		,auind_CAP
		,auind_civico
		,auind_descr_comune
		,auind_indirizzo
		,auind_sigla_provincia
		,auind_telefono1
		,auind_telefono2
		,auind_toponimo
		--2013.08.27:
		,aupoc_data_ultimo_stato
		--2013.08.27.
		  --Letizia 20141027
	   ,aupco_data_scad_autor
	   ,aupco_giorni_proroga
	   ,aupco_lavoratori_autonomi
	   ,AUATE_AUPCO.[auate_cod_ateco_complessivo]
	   --Letizia 20141027
	   --Letizia 20141024
	   ,ausca_pec
	   ,aungi_descr_breve
	 --Letizia 20141024
	 --AI 2058:
	 ,AUATE_AUPOC.auate_cod_ateco_complessivo
	 --AI 2058.
	 --AI 2060
	   ,aupoc_aucom_codice
	   ,[tb_aucom_compartimento_ct].aucom_descr
	   ,aupoc_descr_stato_GS
	  --AI 2060
	END

ELSE
	BEGIN
		SELECT 
		 [aupoc_codice_pk]
		,[aupoc_posizione] 
		--AI 2047:
		,[aupoc_denom_posiz_contr]
		--AI 2047.
		,[aupoc_data_modifica]
		,[aupoc_descr_utente]
		,[auspc_codice]
		,[auspc_descr]
		,[ausca_codice_fiscale]
		--AI 2047:
		,[ausca_denominazione]
		--AI 2047.
		--Letizia 20141021
		,ausca_pec
		,aungi_descr_breve
       --Letizia 20141021
		,[aupoc_contro_codice] 
		,[aupoc_cod_prov_istat]
		,[aupoc_cod_comune_istat]
		,[aupoc_prog_azienda_agr]
		,[aupoc_data_inizio_attivita]
		--AI 2051:
		,[aupoc_data_domanda_iscr]
		--AI 2051.
		,[aupoc_denom_posiz_contr]
		,[autdt_codice] -- tipo ditta (codice)
		,[autdt_descrizione]
		,[autd2_codice] 
		,[autd2_descrizione] 
		,[aupoc_cod_sede_INPS]
		,ausin_descr
		--2013.08.27: dopo avvenuto allineamento di [aupoc_data_ultimo_stato] in produzione
		--,MAX([auvas_data_variazione_stato]) as auvas_data_variazione_stato_max
		,[aupoc_data_ultimo_stato] AS auvas_data_variazione_stato
		--2013.08.27.
		,[aupoc_ATECO] 
		-- Per estrazione Codici Autia
		,aupco_cod_stat_contr 
		,aupco_codici_autor 
		,autia_codice 
		,autia_descrizione 
		,[aupoc_progressivo_confluito] 
		,[aupoc_codice_categoria]
		--AI 2036:
		,CASE [aupoc_tipo_posizione] WHEN 0 THEN 1 WHEN 1 THEN 2 ELSE 0 END as aupoc_tipo_posizione
		,CASE [aupoc_tipo_posizione] WHEN 0 THEN 'Datore Lavoro' WHEN 1 THEN 'Autonomo' ELSE 'Non specificato' END as aupoc_tipo_posizione_descr
		--AI 2036.
		,[aupoc_aurea_codice_pk]
		,[aurea_descrizione]
		,[aupoc_codice_gruppo]
		,[aupoc_attivita_dichiarata]
		,[aupoc_id_sin]
		,[aupoc_id_confluito]
		,[aupoc_cf_confluito]
		,[aupoc_progressivo_confluito]
		,aupco_data_inizio_validita
		,aupco_data_fine_validita
		,aucat_descr
		,auind_CAP
		,auind_civico
		,auind_descr_comune
		,auind_indirizzo
		,auind_sigla_provincia
		,auind_telefono1
		,auind_telefono2
		,auind_toponimo
		--Letizia 20141027
	   ,aupco_data_scad_autor
	   ,aupco_giorni_proroga
	   ,aupco_lavoratori_autonomi
	   ,AUATE_AUPCO.[auate_cod_ateco_complessivo]
	   --Letizia 20141027
	   	   
	   --AI 2058:
	   ,AUATE_AUPOC.auate_cod_ateco_complessivo AS aupoc_ateco_2007
	   --AI 2058.
	   --AI 2060
	   , aupoc_aucom_codice as aupoc_compartimento
	   ,[tb_aucom_compartimento_ct].aucom_descr
	   ,aupoc_descr_stato_GS
	  --AI 2060
		FROM [dbo].[tb_aupoc_pos_contr]
		left outer join [dbo].[tb_ausca_sog_contr_az]
		on tb_ausca_sog_contr_az.ausca_codice_pk = aupoc_ausca_codice_pk
		left outer join [dbo].[tb_auspc_stato_pos_contr_ct]
		on tb_auspc_stato_pos_contr_ct.auspc_codice_pk = aupoc_auspc_codice_pk
		--2013.08.27:
		--left outer join [dbo].[tb_auvas_var_stato_pos] 
		--on tb_auvas_var_stato_pos.auvas_aupoc_codice_pk = aupoc_codice_pk
		--2013.08.27.
		left outer join [dbo].[tb_autdt_tipoditta_ct] 
		on tb_autdt_tipoditta_ct.autdt_codice_pk = aupoc_autdt_codice_pk
		left outer join [dbo].[tb_autd2_tipoditta2_ct] 
		on tb_autd2_tipoditta2_ct.autd2_codice_pk = aupoc_autd2_codice_pk
		left outer join dbo.tb_autia_tipo_accentr_ct -- AUTIA
		ON aupoc_autia_codice_pk = autia_codice_pk
		left outer join dbo.tb_aupco_periodo_contr -- AUPCO
		ON (
		aupco_aupoc_codice_pk = aupoc_codice_pk
	    AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
--		AND (aupco_data_inizio_validita <= GETDATE()) 
--		AND (aupco_data_fine_validita >= GETDATE())
		)
		left outer join dbo.tb_ausin_sedi_inps_ct -- AUSIN
		ON dbo.tb_aupoc_pos_contr.aupoc_cod_sede_INPS = dbo.tb_ausin_sedi_inps_ct.ausin_codice_regione + dbo.tb_ausin_sedi_inps_ct.ausin_codice_sede 
		left outer join dbo.tb_aurea_area_gestione -- AUREA
		ON aupoc_aurea_codice_pk = aurea_codice_pk
		left outer join dbo.tb_aucat_categoria_ct -- AUCAT
		ON aupoc_codice_categoria = aucat_codice
		left outer join tb_auind_indirizzi 
		ON UPPER(auind_tabella) = 'AUPOC' AND auind_tabella_codice_pk = aupoc_codice_pk
		--Letiza 20141027
		left outer join [dbo].[tb_auate_cod_ateco_ct] AUATE_AUPCO 
		ON dbo.tb_aupco_periodo_contr.aupco_auate_2007_codice_pk = AUATE_AUPCO.auate_codice_pk 
		--Letiza 20141027
		--Letizia 20141021
		left outer join dbo.tb_aungi_nat_giur_ct
	    ON ausca_aungi_codice_pk = aungi_codice_pk     --AUNGI
	    --Letizia 20141021

			--AI 2058:
			left outer join [dbo].[tb_auate_cod_ateco_ct] AUATE_AUPOC -- AUATE-AUPOC
			ON dbo.tb_aupoc_pos_contr.aupoc_auate_2007_codice_pk = AUATE_AUPOC.auate_codice_pk 
			--AI 2058.
		--AI 2060
	   left outer join [dbo].[tb_aucom_compartimento_ct] --AUCOM
	   ON dbo.tb_aupoc_pos_contr.[aupoc_aucom_codice] =  [dbo].[tb_aucom_compartimento_ct].[aucom_codice]
	   --AI 2060

		WHERE 
		(@aupoc_posizione IS NULL OR dbo.tb_aupoc_pos_contr.aupoc_posizione = @aupoc_posizione)
		AND (@aupoc_codice_pk IS NULL OR dbo.tb_aupoc_pos_contr.aupoc_codice_pk = @aupoc_codice_pk)
		AND (@aupoc_controcodice IS NULL OR dbo.tb_aupoc_pos_contr.aupoc_contro_codice = @aupoc_controcodice)
		GROUP BY 
		[aupoc_codice_pk]
		,[aupoc_posizione] 
		--AI 2047:
		,[aupoc_denom_posiz_contr]
		--AI 2047.
		,[aupoc_data_modifica]
		,[aupoc_descr_utente]
		,[auspc_codice]
		,[auspc_descr]
		,[ausca_codice_fiscale]
		--AI 2047:
		,[ausca_denominazione]
		--AI 2047.
		,[aupoc_contro_codice] 
		,[auspc_descr] 
		,[aupoc_cod_prov_istat]
		,[aupoc_cod_comune_istat]
		,[aupoc_prog_azienda_agr]
		,[aupoc_data_inizio_attivita]
		--AI 2051:
		,[aupoc_data_domanda_iscr]
		--AI 2051.
		,[aupoc_denom_posiz_contr]
		,[autdt_codice]
		,[autdt_descrizione]
		,[aupoc_cod_sede_INPS]
		,[autd2_codice] 
		,[autd2_descrizione] 
		,[aupoc_ateco] 
		,[aupco_cod_stat_contr] 
		,[aupco_codici_autor] 
		,[autia_codice] 
		,[aupoc_progressivo_confluito] 
		,[aupoc_codice_categoria]
		,[aupoc_tipo_posizione]
		,[aupoc_aurea_codice_pk]
		,[aurea_descrizione]
		,[aupoc_codice_gruppo]
		,[aupoc_attivita_dichiarata]
		,[aupoc_id_sin]
		,[aupoc_id_confluito]
		,[aupoc_cf_confluito]
		,ausin_descr
		,autia_descrizione 
		,aupco_data_inizio_validita
		,aupco_data_fine_validita
		,aucat_descr
		,auind_CAP
		,auind_civico
		,auind_descr_comune
		,auind_indirizzo
		,auind_sigla_provincia
		,auind_telefono1
		,auind_telefono2
		,auind_toponimo
		--2013.08.27:
		,aupoc_data_ultimo_stato
		--2013.08.27.
	  --Letizia 20141027
	   ,aupco_data_scad_autor
	   ,aupco_giorni_proroga
	   ,aupco_lavoratori_autonomi
	   ,AUATE_AUPCO.[auate_cod_ateco_complessivo]
	   --Letizia 20141027
	    --Letizia 20141024
	   ,ausca_pec
	   ,aungi_descr_breve
	 --Letizia 20141024
	 --AI 2058:
	 ,AUATE_AUPOC.auate_cod_ateco_complessivo
	 --AI 2058.
	 --AI 2060
	  ,aupoc_aucom_codice
	  ,[tb_aucom_compartimento_ct].aucom_descr
	  ,aupoc_descr_stato_GS
	   --AI 2060
	END
END
