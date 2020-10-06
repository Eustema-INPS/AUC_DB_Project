-- ===================================================================
-- Author:		Maurizio Picone 
-- Create date: 31 luglio 2012
-- ===================================================================

CREATE PROCEDURE [dbo].[SP_FINDPOSCONTR_CIDA] 
	@aupoc_cida varchar(50)	
AS
BEGIN
	SET NOCOUNT ON;	
		
	
SELECT top 1
       [aupoc_posizione]  
      ,[auspc_descr] 
      ,[ausca_codice_fiscale]
	  ,[aupoc_codice_pk]
      ,[aupoc_contro_codice] 
      ,[aupoc_data_inizio_attivita]
      ,[ausca_codice_fiscale]
      --,aupoc_matricola_azienda  -- tolta dalla struttura del WS
      ,aupoc_cida
      ,aupoc_cod_prov_istat
      ,aupoc_cod_comune_istat
      ,aupoc_prog_azienda_agr
      ,[autdt_codice] -- tipo ditta (codice)
      ,[aupoc_denom_posiz_contr]
      ,[aupoc_cod_sede_INPS]
      ,[auvas_data_variazione_stato]
      ,[autd2_descrizione] 
      ,[aupoc_ATECO]       
 	  ,ISNULL(aupco_cod_stat_contr, '''') as DB_CSC  
 	  ,ISNULL(aupco_codici_autor, '''')   as DB_Codice_Autorizzazione 
	  ,ISNULL(autia_codice, '''')         as DB_Accentramento
	  ,aupco_data_inizio_validita
	  ,aupco_data_fine_validita

		
	FROM tb_aupoc_pos_contr
	 
	  left outer join [tb_ausca_sog_contr_az]
	  on tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk
	  
	  left outer join [tb_auspc_stato_pos_contr_ct]
	  on tb_auspc_stato_pos_contr_ct.auspc_codice_pk = aupoc_auspc_codice_pk
	  
	  left outer join [tb_auvas_var_stato_pos] 
	  on tb_auvas_var_stato_pos.auvas_aupoc_codice_pk = aupoc_codice_pk
	  
	  left outer join [tb_autdt_tipoditta_ct] 
	  on tb_autdt_tipoditta_ct.autdt_codice_pk = aupoc_autdt_codice_pk
	  
	  left outer join [tb_autd2_tipoditta2_ct] 
	  on tb_autd2_tipoditta2_ct.autd2_codice_pk =  aupoc_autd2_codice_pk
	  	
	  left outer join [tb_autia_tipo_accentr_ct] -- AUTIA
	  ON tb_aupoc_pos_contr.aupoc_autia_codice_pk = tb_autia_tipo_accentr_ct.autia_codice_pk
	  
	  left outer join dbo.tb_aupco_periodo_contr   -- AUPCO
	  ON tb_aupco_periodo_contr.aupco_aupoc_codice_pk = aupoc_codice_pk
	
	WHERE 
		tb_aupoc_pos_contr.aupoc_cida= @aupoc_cida
		
	group by
       [aupoc_posizione]  
      ,[auspc_descr]
      ,[ausca_codice_fiscale]
	  ,[aupoc_codice_pk]
      ,[aupoc_contro_codice] 
      ,[aupoc_data_inizio_attivita]
      ,[ausca_codice_fiscale]
      --,aupoc_matricola_azienda  -- tolta dalla struttura del WS
      ,aupoc_cida
      ,aupoc_cod_prov_istat
      ,aupoc_cod_comune_istat
      ,aupoc_prog_azienda_agr
      ,[autdt_codice] -- tipo ditta (codice)
      ,[aupoc_denom_posiz_contr]
      ,[aupoc_cod_sede_INPS]
      ,[auvas_data_variazione_stato]
      ,[autd2_descrizione] 
      ,[aupoc_ATECO]       
 	  ,aupco_cod_stat_contr
 	  ,aupco_codici_autor
	  ,autia_codice
	  ,aupco_data_inizio_validita
	  ,aupco_data_fine_validita


END
