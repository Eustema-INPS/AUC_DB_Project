



-- ===================================================================
-- Author:		Maurizio Picone e Letizia Bellantoni
-- Create date: 20 Novembre 2012 
-- ===================================================================

CREATE PROCEDURE [dbo].[SP_FINDPOSCONTR_POS_RC] 
	@aupoc_posizione varchar(50)	
AS
BEGIN
	SET NOCOUNT ON;	

		
select 
	   [aupoc_codice_pk]
      ,[aupoc_posizione]    
      ,[aupoc_data_modifica]
      ,[aupoc_descr_utente]
      ,[auspc_codice]
      ,[ausca_codice_fiscale]
      ,[aupoc_contro_codice] 
      ,[auspc_descr]         
      ,[aupoc_cida]
      ,[aupoc_cod_prov_istat]
      ,[aupoc_cod_comune_istat]
      ,[aupoc_prog_azienda_agr]
      ,[aupoc_data_inizio_attivita]
      ,[aupco_ateco_91]      
	   ,aupoc_data_ultimo_stato 
      ,[aupoc_denom_posiz_contr]
      ,[autdt_codice] -- tipo ditta (codice)
      ,[autdt_descrizione]
      ,[aupoc_cod_sede_INPS]
	  ,[auvas_data_variazione_stato] 
      ,[autd2_descrizione] 
      ,[aupoc_ATECO]       
	  ,autia_codice 
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
		,aupoc_auspc_codice_pk,
		auvas_auspc_codice_pk
		
		into #temp
	  FROM  [dbo].[tb_aupoc_pos_contr]
	  left outer join  [dbo].[tb_auapp_appl]
	  on tb_auapp_appl.auapp_codice_pk = aupoc_auapp_codice_pk 
	  left outer join   [dbo].[tb_ausca_sog_contr_az]
	  on tb_ausca_sog_contr_az.ausca_codice_pk = aupoc_ausca_codice_pk
	  left outer join   [dbo].[tb_auspc_stato_pos_contr_ct]
	  on tb_auspc_stato_pos_contr_ct.auspc_codice_pk = aupoc_auspc_codice_pk
	  left outer join   [dbo].[tb_auvas_var_stato_pos] 
	  on tb_auvas_var_stato_pos.auvas_aupoc_codice_pk = aupoc_codice_pk
  	  --2015.09.09 AI 6092:
	  and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
      --2015.09.09 AI 6092.
	  left outer join   [dbo].[tb_autdt_tipoditta_ct] 
	  on tb_autdt_tipoditta_ct.autdt_codice_pk = aupoc_autdt_codice_pk
	  left outer join   [dbo].[tb_autd2_tipoditta2_ct] 
	  on tb_autd2_tipoditta2_ct.autd2_codice_pk =  aupoc_autd2_codice_pk
	  left outer join dbo.tb_autia_tipo_accentr_ct -- AUTIA
	  ON aupoc_autia_codice_pk = autia_codice_pk
	  left outer join dbo.tb_aupco_periodo_contr   -- AUPCO
	  ON aupco_aupoc_codice_pk = aupoc_codice_pk
	--AI 2039:
	  AND aupco_data_inizio_validita <=getdate() and getdate() <= aupco_data_fine_validita 
    --AI 2039.
	  left outer join tb_auind_indirizzi 
	  ON auind_tabella = 'AUPOC' AND auind_tabella_codice_pk = aupoc_codice_pk
  WHERE   aupoc_posizione = @aupoc_posizione


      
  select  top 1 [aupoc_codice_pk]
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
      , aupoc_posizione
      ,[aupoc_cida]
      ,[aupoc_cod_prov_istat]
      ,[aupoc_cod_comune_istat]
      ,[aupoc_prog_azienda_agr]
      ,[aupoc_data_inizio_attivita]
      ,[aupco_ateco_91]      -- aggiunto il 22 Nov
      , aupoc_data_modifica
	  ,aupoc_data_ultimo_stato -- Data Estinzione		
	  AS [auvas_data_variazione_stato]
      ,[aupoc_denom_posiz_contr]
      ,[autdt_codice] -- tipo ditta (codice)
      ,[autdt_descrizione]
      ,[aupoc_cod_sede_INPS]
       ,MAX([auvas_data_variazione_stato])
      ,[autd2_descrizione] 
      ,[aupoc_ATECO]   
	  --,autia_codice   
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
		
	   from #temp
       group by 
	  [aupoc_codice_pk]
      ,[aupoc_posizione]    
      ,[aupoc_data_modifica]
      ,[aupoc_descr_utente]
      ,[auspc_codice]
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
      ,autia_codice
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
      ,aupoc_data_ultimo_stato

		
END


