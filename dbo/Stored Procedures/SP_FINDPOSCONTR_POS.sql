


-- ===================================================================
-- Author:		Maurizio Picone 
-- Create date: 31 luglio 2012
-- ===================================================================
-- ===================================================================
-- Author:		Letizia Bellantoni
-- Modifica date: 2014-10-21
-- ===================================================================
-- ===================================================================
-- Author:		  Letizia Bellantoni
-- Modifica date: 2014-10-27
-- Descrizione  : RF005 , aggiunti campi aupco_data_scad_autor,aupco_giorni_proroga,aupco_lavoratori_autonomi,aupco_ateco_2007(auate)

-- ===================================================================

CREATE procedure [dbo].[SP_FINDPOSCONTR_POS] 
	@aupoc_posizione varchar(50)	
AS
BEGIN
	SET NOCOUNT ON;	
	
	SELECT 	 
	   [aupoc_codice_pk]
      ,[aupoc_posizione]    
      ,[aupoc_data_modifica]
      ,[aupoc_descr_utente]
      ,[auspc_descr]
      ,[ausca_codice_fiscale]
      ,[aupoc_contro_codice] 
      ,[auspc_descr] -- Descrizione Stato Pos Contr
      ,[aupoc_posizione]
      ,[aupoc_cida]
      ,[aupoc_cod_prov_istat]
      ,[aupoc_cod_comune_istat]
      ,[aupoc_prog_azienda_agr]
      ,[aupoc_data_inizio_attivita]
      ,[aupoc_denom_posiz_contr]
      ,[autdt_codice] -- tipo ditta (codice)
      ,[autdt_descrizione]
      ,[aupoc_cod_sede_INPS]
      -- patch 2013.10.17:
      --,MAX([auvas_data_variazione_stato])
      ,[aupoc_data_ultimo_stato] as 'auvas_data_variazione_stato'  
      -- patch 2013.10.17.
      ,[autd2_descrizione] 
      ,[aupoc_ATECO]       
 	  ,ISNULL(aupco_cod_stat_contr, '''') as DB_CSC  
 	  ,ISNULL(aupco_codici_autor, '''')   as DB_Codice_Autorizzazione 
	  ,ISNULL(autia_codice, '''')         as DB_Accentramento 
	  ,aupco_data_inizio_validita
	  ,aupco_data_fine_validita
      --AI 2037:
      	,auind_CAP
		,auind_civico
		,auind_descr_comune
		,auind_indirizzo
		,auind_sigla_provincia
		,auind_telefono1
		,auind_telefono2
		,auind_toponimo
      --AI 2037.
	  --Letizia 20141021
	  ,ausca_pec
	  ,ausca_denominazione
	  ,aungi_descr_breve
       --Letizia 20141021
	   --Letizia 20141027
	   ,aupco_data_scad_autor
	   ,aupco_giorni_proroga
	   ,aupco_lavoratori_autonomi
	   ,[auate_cod_ateco_complessivo]
	   --Letizia 20141027

	   --AI 2056:
	   ,aupoc_aurea_codice_pk
	   --AI 2056.
	
  FROM  [dbo].[tb_aupoc_pos_contr]

	  left outer join  [dbo].[tb_auapp_appl]
	  on tb_auapp_appl.auapp_codice_pk = aupoc_auapp_codice_pk 
	  	  
	  left outer join   [dbo].[tb_ausca_sog_contr_az]
	  on tb_ausca_sog_contr_az.ausca_codice_pk = aupoc_ausca_codice_pk
	  
	  left outer join   [dbo].[tb_auspc_stato_pos_contr_ct]
	  on tb_auspc_stato_pos_contr_ct.auspc_codice_pk = aupoc_auspc_codice_pk
	  
	  left outer join   [dbo].[tb_auvas_var_stato_pos] 
	  on tb_auvas_var_stato_pos.auvas_aupoc_codice_pk = aupoc_codice_pk
	  
	  left outer join   [dbo].[tb_autdt_tipoditta_ct] 
	  on tb_autdt_tipoditta_ct.autdt_codice_pk = aupoc_autdt_codice_pk
	  
	  left outer join   [dbo].[tb_autd2_tipoditta2_ct] 
	  on tb_autd2_tipoditta2_ct.autd2_codice_pk =  aupoc_autd2_codice_pk
	  	
	  left outer join dbo.tb_autia_tipo_accentr_ct -- AUTIA
	  ON aupoc_autia_codice_pk = autia_codice_pk
	  
	  left outer join dbo.tb_aupco_periodo_contr   -- AUPCO
	  ON aupco_aupoc_codice_pk = aupoc_codice_pk
	--AI 2039:
	  AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	--AI 2039.
			  	  
  	  --AI 2037:
 	  left outer join tb_auind_indirizzi 
	  ON UPPER(auind_tabella) = 'AUPOC' AND auind_tabella_codice_pk = aupoc_codice_pk
	  --AI 2037.
	  --Letizia 20141021
	   left outer join dbo.tb_aungi_nat_giur_ct
	  ON ausca_aungi_codice_pk = aungi_codice_pk     --AUNGI
	  --Letizia 20141021
	  --Letiza 20141027
		left outer join [dbo].[tb_auate_cod_ateco_ct] -- AUATE
		ON dbo.tb_aupco_periodo_contr.aupco_auate_2007_codice_pk = auate_codice_pk 
		--Letiza 20141027
	 
  WHERE 
	  aupoc_posizione = @aupoc_posizione 
	  
	  ---------------------------------	 
	  -- Per estrazione Codici Autia --
	  ---------------------------------
	--AI 2039:
	  --AND (aupco_data_inizio_validita <= GETDATE()) AND (aupco_data_fine_validita >= GETDATE())	  
	--AI 2039.
	  
  GROUP BY 	   
       [aupoc_codice_pk]
      ,[aupoc_posizione]    
      ,[aupoc_data_modifica]
      ,[aupoc_descr_utente]
      ,[auspc_descr]
      ,[ausca_codice_fiscale]
      ,[aupoc_contro_codice] 
      ,[auspc_descr] 
      ,[aupoc_posizione]
      ,[aupoc_cida]
      ,[aupoc_cod_prov_istat]
      ,[aupoc_cod_comune_istat]
      ,[aupoc_prog_azienda_agr]
      ,[aupoc_data_inizio_attivita]
      ,[aupoc_denom_posiz_contr]
      --patch 2013.10.17:
      ,[aupoc_data_ultimo_stato]
      --patch 2013.10.17.
      ,[autdt_codice]
      ,[autdt_descrizione]
      ,[aupoc_cod_sede_INPS]
      ,[autd2_descrizione] 
      ,[aupoc_ATECO]       
      ,[aupco_cod_stat_contr] 
      ,[aupco_codici_autor]   
      ,[autia_codice] 
	  ,aupco_data_inizio_validita
	  ,aupco_data_fine_validita
		--AI 2037:
      	,auind_CAP
		,auind_civico
		,auind_descr_comune
		,auind_indirizzo
		,auind_sigla_provincia
		,auind_telefono1
		,auind_telefono2
		,auind_toponimo
		--AI 2037.
		,ausca_pec
		,ausca_denominazione
		,aungi_descr_breve
		--Letizia 20141027
	   ,aupco_data_scad_autor
	   ,aupco_giorni_proroga
	   ,aupco_lavoratori_autonomi
	   ,[auate_cod_ateco_complessivo]
	   --Letizia 20141027
	   --AI 2056:
	   ,aupoc_aurea_codice_pk
	   --AI 2056.

END


