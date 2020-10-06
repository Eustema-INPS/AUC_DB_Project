



-- ===================================================================
-- Author:		Martini e Maurizio Picone (modifica 10/5/2012)
-- Create date: 
-- Description:	Accesso alla tabella tb_aupoc_pos_contr
--  in join con: tb_auapp_appl 
--               tb_ausca_sog_contr_az
--               tb_auspc_stato_pos_contr_ct 
--               tb_auvas_var_stato_pos
--               tb_autdt_tipoditta_ct
--				 tb_autia_tipo_accentr_ct
--				 tb_aupco_periodo_cont
	  
--  qualificando: 
--	ausca_codice_fiscale = codice fiscale input
--	auapp_appname = AppName
--	aupoc_ausca_codice_pk = ausca_codice_pk
--  aupoc_auapp_codice_pk = codice applicazione 
-- ===================================================================
CREATE procedure [dbo].[SP_LISTAPOSCONTR_SEDI] 

	@codice_fiscale_azienda varchar(16),
	@codicesede varchar(6)
	
AS
BEGIN
	SET NOCOUNT ON;
	
	
	SELECT 	 
	   [aupoc_codice_pk]
      ,[aupoc_posizione]    
      ,[aupoc_data_modifica]
      ,[aupoc_descr_utente]
      ,[auspc_descr]
      
      ----------------------------------------- Rel.2
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
      
      
      ,MAX([auvas_data_variazione_stato])
      ------------------------------------ Fine Rel.2
      
      
      
      ----------------------------------------- Rel.4
      ,[autd2_descrizione] 
      ,[aupoc_ATECO]       
      
      
	  -- Per estrazione Codici Autia
 	  ,ISNULL(aupco_cod_stat_contr, '''') as DB_CSC  
 	  ,ISNULL(aupco_codici_autor, '''')   as DB_Codice_Autorizzazione 
	  ,ISNULL(autia_codice, '''')         as DB_Accentramento 
      ------------------------------------ Fine Rel.4
      
      
  FROM  [dbo].[tb_aupoc_pos_contr]

	  --left outer join  [dbo].[tb_auapp_appl]
	  --on tb_auapp_appl.auapp_codice_pk = aupoc_auapp_codice_pk 
	  --commentato 1° agosto 2012	
	    
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
		AND	convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	--AI 2039.
	  
	  --left outer join dbo.tb_ausin_sedi_inps_ct  -- AUSIN
	  --ON dbo.tb_aupoc_pos_contr.aupoc_cod_sede_INPS = dbo.tb_ausin_sedi_inps_ct.ausin_codice_sede  
	  
  WHERE 
	  ausca_codice_fiscale = @codice_fiscale_azienda
	  --AI 2023: commentato 2013.04.23
	  --and (aupoc_auspc_codice_pk = 1 or  aupoc_auspc_codice_pk = 5) -- "ATTIVA" o "RIATTIVATA"
	  --AI 2023.	  
	  ---------------------------------	 
	  -- Per estrazione Codici Autia --
	  ---------------------------------
	--AI 2039:
	  --AND  aupoc_codice_pk = aupco_aupoc_codice_pk
	  --AND (aupco_data_inizio_validita <= GETDATE()) 
	  --AND (aupco_data_fine_validita >= GETDATE())
	--AI 2039.
	  
	  -- FILTRO PER CODICE SEDE
	  AND SUBSTRING(dbo.tb_aupoc_pos_contr.aupoc_cod_sede_INPS,3,4) = SUBSTRING(@codicesede,3,4)
	  
	  
	  
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
      ,[autdt_codice]
      ,[autdt_descrizione]
      ,[aupoc_cod_sede_INPS]
      ,[autd2_descrizione] 
      ,[aupoc_ATECO]       
      ,[aupco_cod_stat_contr] 
      ,[aupco_codici_autor]   
      ,[autia_codice] 

END



