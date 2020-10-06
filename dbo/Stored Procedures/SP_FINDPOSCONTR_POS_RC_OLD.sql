
-- ===================================================================
-- Author:		Maurizio Picone e Letizia Bellantoni
-- Create date: 20 Novembre 2012 
-- ===================================================================

CREATE PROCEDURE [dbo].[SP_FINDPOSCONTR_POS_RC_OLD] 
	@aupoc_posizione varchar(50)	
AS
BEGIN
	SET NOCOUNT ON;	
	
	SELECT top 1
	   [aupoc_codice_pk]
      ,[aupoc_posizione]    
      ,[aupoc_data_modifica]
      ,[aupoc_descr_utente]
      -- AI 2010:
      --,[auspc_descr]
      ,[auspc_codice]
      -- AI 2010.
      ,[ausca_codice_fiscale]
      ,[aupoc_contro_codice] 
      ,[auspc_descr]         -- descrizione stato poscontr
      ,[aupoc_posizione]
      ,[aupoc_cida]
      ,[aupoc_cod_prov_istat]
      ,[aupoc_cod_comune_istat]
      ,[aupoc_prog_azienda_agr]
      ,[aupoc_data_inizio_attivita]
      ,[aupco_ateco_91]      -- aggiunto il 22 Nov
      ,[aupoc_data_modifica] -- aggiunto il 22 Nov

 
      -- Per recupero crediti
      
      -- modifica per Action Item 2011 INIZIO
      
  --    ,CASE 
		--WHEN aupoc_auspc_codice_pk = 3 THEN -- CESSATA DEFINITIVA
		--(
		--    -- ---------------------------------------------------------------------
		--    -- Estrae una sola data dalla tabella delle variazioni (la piu' recente)
		--    -- ---------------------------------------------------------------------			
		--	SELECT CONVERT(VARCHAR(10),MAX([auvas_data_variazione_stato]),103) 
		--	FROM [tb_auvas_var_stato_pos] 
		--	WHERE auvas_aupoc_codice_pk = aupoc_codice_pk 	
		--)
		--ELSE ''
  --    END AS [auvas_data_variazione_stato] -- Data Estinzione
      
		    -- ---------------------------------------------------------------------
		    -- Estrae una sola data dalla tabella delle variazioni (la piu' recente)
		    -- ---------------------------------------------------------------------			
		-- patch 2013.10.17:
		--,(
		--	SELECT MAX([auvas_data_variazione_stato]) 
		--	FROM [tb_auvas_var_stato_pos] 
		--	WHERE auvas_aupoc_codice_pk = aupoc_codice_pk 	
		--)
		,aupoc_data_ultimo_stato
		-- patch 2013.10.17.
		AS [auvas_data_variazione_stato] -- Data Estinzione
		
      -- modifica per Action Item 2011 FINE

      ,[aupoc_denom_posiz_contr]
      ,[autdt_codice] -- tipo ditta (codice)
      ,[autdt_descrizione]
      ,[aupoc_cod_sede_INPS]
      ,MAX([auvas_data_variazione_stato])
      ,[autd2_descrizione] 
      ,[aupoc_ATECO]       
 	  ,ISNULL(aupco_cod_stat_contr, '''') as DB_CSC  
 	  ,ISNULL(aupco_codici_autor, '''')   as DB_Codice_Autorizzazione 
	  ,ISNULL(autia_codice, '''')         as DB_Accentramento 
	  ,aupco_data_inizio_validita
	  ,aupco_data_fine_validita
      ---------------
		,auind_CAP
		,auind_civico
		,auind_descr_comune
		,auind_indirizzo
		,auind_sigla_provincia
		,auind_telefono1
		,auind_telefono2
		,auind_toponimo
		,aupoc_attivita_dichiarata
		,aupco_cod_stat_contr
		,aupco_codici_autor
		,aupoc_auate_2007_codice_pk as aupoc_ateco_2007

      
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
	  --AND GETDATE() BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	  AND aupco_data_inizio_validita <= getdate() and aupco_data_fine_validita >= getdate()
	--AI 2039.
	  
	  left outer join tb_auind_indirizzi 
	  ON UPPER(auind_tabella) = 'AUPOC' AND auind_tabella_codice_pk = aupoc_codice_pk
			  	  
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
      -- AI 2010:
      --,[auspc_descr] 
      ,[auspc_codice]
      -- AI 2010.
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
	  ,auind_CAP
	  ,auind_civico
	  ,auind_descr_comune
	  ,auind_indirizzo
	  ,auind_sigla_provincia
	  ,auind_telefono1
	  ,auind_telefono2
	  ,auind_toponimo
	  ,aupoc_attivita_dichiarata
	  ,aupco_cod_stat_contr
	  ,aupco_codici_autor
	  ,aupoc_auate_2007_codice_pk
	  ,auvas_auspc_codice_pk
	  ,aupoc_auspc_codice_pk
      ,aupco_ateco_91
      ,aupoc_data_modifica
		-- patch 2013.10.17:
      ,aupoc_data_ultimo_stato
   		-- patch 2013.10.17.


END

