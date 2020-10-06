-- ===================================================================
-- Author:		Martini e Maurizio Picone (modifica 10/5/2012)
-- Create date: 
-- Description:	Accesso alla tabella tb_aupoc_pos_contr
--  in join con: tb_auapp_appl 
--               tb_ausca_sog_contr_az
--               tb_auspc_stato_pos_contr_ct 
--               tb_auvas_var_stato_pos
--               tb_autdt_tipoditta_ct
--  qualificando: 
--	ausca_codice_fiscale = codice fiscale input
--	auapp_appname = AppName
--	aupoc_ausca_codice_pk = ausca_codice_pk
--  aupoc_auapp_codice_pk = codice applicazione 
-- ===================================================================
CREATE PROCEDURE [dbo].[SP_LISTAPOSCONTR] 

	@codice_fiscale_azienda varchar(16),
	@AppName varchar(20),
	@codice_applicazione int 
	
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
      --2013.08.27: dopo avvenuto allineamento di [aupoc_data_ultimo_stato] in produzione
      --,MAX([auvas_data_variazione_stato]) AS auvas_data_variazione_stato
      ,[aupoc_data_ultimo_stato] AS auvas_data_variazione_stato
      --2013.08.27.
      ------------------------------------ Fine Rel.2

  FROM  [dbo].[tb_aupoc_pos_contr]
  	  -- C'era: <on tb_auapp_appl.auapp_aussu_codice_pk = aupoc_auspc_codice_pk> 
	  -- Prendeva solo le "ATTIVE", <auapp_aussu_codice_pk> sono tutti = 1.

	  --left outer join  [dbo].[tb_auapp_appl]
	  --on tb_auapp_appl.auapp_codice_pk = aupoc_auapp_codice_pk 
	  -- commentato 1° agosto 2012
	  	  
	  left outer join   [dbo].[tb_ausca_sog_contr_az]
	  on tb_ausca_sog_contr_az.ausca_codice_pk = aupoc_ausca_codice_pk
	  
	  left outer join   [dbo].[tb_auspc_stato_pos_contr_ct]
	  on tb_auspc_stato_pos_contr_ct.auspc_codice_pk = aupoc_auspc_codice_pk
	  
	  --2013.08.27:
	  --left outer join   [dbo].[tb_auvas_var_stato_pos] -- Rel.2
	  --on tb_auvas_var_stato_pos.auvas_aupoc_codice_pk = aupoc_codice_pk
	  --2013.08.27.
	  
	  left outer join   [dbo].[tb_autdt_tipoditta_ct] -- Rel.2
	  on tb_autdt_tipoditta_ct.autdt_codice_pk = aupoc_autdt_codice_pk

  WHERE 
	  ausca_codice_fiscale = @codice_fiscale_azienda
	  
	  --commentato 1° agosto 2012
	  --and tb_auapp_appl.auapp_app_name = @AppName
	  --and aupoc_auapp_codice_pk = @codice_applicazione
	  
	  --AI 2023: commentato 2013.04.23
	  --and (aupoc_auspc_codice_pk = 1 or  aupoc_auspc_codice_pk = 5) -- "ATTIVA" o "RIATTIVATA"
	  --AI 2023.	  

  
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
		--2013.08.27:
		,aupoc_data_ultimo_stato
		--2013.08.27.
END
