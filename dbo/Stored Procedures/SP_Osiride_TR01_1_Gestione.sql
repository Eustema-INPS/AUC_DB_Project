CREATE PROCEDURE [dbo].[SP_Osiride_TR01_1_Gestione]
AS
BEGIN
	IF OBJECT_ID('tempdb..#group_auvis') IS NOT NULL	
		DROP TABLE #group_auvis;

	CREATE TABLE #group_auvis(
	group_auvis_cf char(16),
	group_auvis_data date
	);
	
	INSERT INTO #group_auvis(group_auvis_cf, group_auvis_data)

		SELECT dbo.tb_auvis_visure.auvis_CF, MAX(CONVERT(date, dbo.tb_auvis_visure.auvis_DataEstrazione, 103)) AS MaxData
		FROM dbo.tb_auvis_visure 
		INNER JOIN  dbo.tb_ausca_sog_contr_az ON dbo.tb_auvis_visure.auvis_CF = dbo.tb_ausca_sog_contr_az.ausca_codice_fiscale
		WHERE dbo.tb_auvis_visure.auvis_elaborato <> 9
		AND dbo.tb_ausca_sog_contr_az.ausca_soggetto_certificato = 'S'
		AND (dbo.tb_ausca_sog_contr_az.ausca_cert_auten_cod_pk = 2 AND dbo.tb_ausca_sog_contr_az.ausca_cert_cod_entita_rif=1)
		AND dbo.tb_auvis_visure.auvis_flag03 = 1
		GROUP BY dbo.tb_auvis_visure.auvis_CF, dbo.tb_ausca_sog_contr_az.ausca_soggetto_certificato, dbo.tb_ausca_sog_contr_az.ausca_cert_auten_cod_pk, dbo.tb_ausca_sog_contr_az.ausca_cert_cod_entita_rif

				
	----SELECT * FROM #group_auvis;
	TRUNCATE TABLE [dbo].[TB_AUT01_OSIRIDE_TR01]

	INSERT INTO [dbo].[TB_AUT01_OSIRIDE_TR01]
           ([AUT01_R1_TIPO]
           ,[AUT01_R1_PROV_CCIAA]
           ,[AUT01_R1_NUM_IREA]
           ,[AUT01_R1_NUM_RIMP]
           ,[AUT01_R1_DATA_ISC]
           ,[AUT01_R1_FLAG_REA_AGG]
           ,[AUT01_R1_DATA_ULT_AGG]
           ,[AUT01_R1_PROV_SEDE]
           ,[AUT01_R1_NUM_ISC_SEDE]
           ,[AUT01_R1_RAGIONE_SOCE_1]
           ,[AUT01_R1_RAGIONE_SOCE_2]
           ,[AUT01_R1_COD_FISC_IMP]
           ,[AUT01_R1_PART_IVA]
           ,[AUT01_R1_NAT_GIU]
           ,[AUT01_R1_COD_PROVEN]
           ,[AUT01_R1_DATA_ISCR_REA]
           ,[AUT01_R1_DATA_ISCR_REG_IMP]
		   
           ,[AUT01_R1_COD_SEZ_SPECIALE_01]
           ,[AUT01_R1_DATA_INIZ_SEZ_SPE_01]
           ,[AUT01_R1_FLAG_COL_DIRETTO_01]		   
		   ,[AUT01_R1_DATA_FIN_APP_SEZ_SPE_01]
		   ,[AUT01_R1_COD_MOTIVO_FIN_APP_SEZ_SPECIALE_01]
		   
           ,[AUT01_R1_COD_SEZ_SPECIALE_02]
           ,[AUT01_R1_DATA_INIZ_SEZ_SPE_02]
           ,[AUT01_R1_FLAG_COL_DIRETTO_02]
		   ,[AUT01_R1_DATA_FIN_APP_SEZ_SPE_02]
		   ,[AUT01_R1_COD_MOTIVO_FIN_APP_SEZ_SPECIALE_02]
		   
           ,[AUT01_R1_COD_SEZ_SPECIALE_03]
           ,[AUT01_R1_DATA_INIZ_SEZ_SPE_03]
           ,[AUT01_R1_FLAG_COL_DIRETTO_03]
		   ,[AUT01_R1_DATA_FIN_APP_SEZ_SPE_03]
		   ,[AUT01_R1_COD_MOTIVO_FIN_APP_SEZ_SPECIALE_03]
           ,[AUT01_R1_FLAG_ISCR_ART_DECIS]
           ,[AUT01_R1_STATO_IMPRESA]
           ,[AUT01_R1_DATA_INIZIO_STATO_AT]
           ,[AUT01_R1_DATA_ULT_AGG_ARC_SE]
           ,[AUT01_R1_FLAG_FASE_AGG]
           ,[AUT01_R1_COD_CESS_INT]
           ,[AUT01_R1_DATA_CESS_INT]
           ,[AUT01_R1_DATA_DENUN_CESS_INT]
           ,[AUT01_R1_DATA_CAN_INFORM_INT]
           ,[AUT01_R1_COD_CESS_SEDE]
           ,[AUT01_R1_DATA_CESS_SEDE]
           ,[AUT01_R1_DATA_DENUN_CESS_SEDE]
           ,[AUT01_R1_DATA_CAN_INFORM_SEDE]
           ,[AUT01_R1_IND_TRASF_SEDE]
           ,[AUT01_R1_DATA_CESS_FUNZ_SEDE]
           ,[AUT01_R1_COD_CAUS_CESS]
           ,[AUT01_R1_DATA_AGG_ARC_IMP_NAZ]
           ,[AUT01_R1_FILLER])
	
	SELECT  
		'01' As AUT01_R1_TIPO
		,ausca_cciaa As AUT01_R1_PROV_CCIAA
		,right('000000000'+ausca_n_rea,9) As AUT01_R1_NUM_IREA
		--,ausca_n_iscrizione_ri As AUT01_R1_NUM_RIMP		
		--,CASE isnull(ausca_c_n_iscrizione_ri_old,'###') WHEN '###' THEN  ausca_n_iscrizione_ri  ELSE ausca_c_n_iscrizione_ri_old END As AUT01_R1_NUM_RIMP 				
		-- 08/01/2018
		,CASE isnull(ausca_c_n_iscrizione_ri_old,'###') WHEN '###' THEN  REPLICATE(' ', 21) ELSE ausca_c_n_iscrizione_ri_old END As AUT01_R1_NUM_RIMP 				
		
		,CONVERT(VARCHAR(10),ausca_data_iscrizione,112) As AUT01_R1_DATA_ISC
		,CASE WHEN[ausca_f_aggiornamento] = '1' THEN  'S' ELSE 'N' END As AUT01_R1_FLAG_REA_AGG
		,CONVERT(VARCHAR(8),group_auvis_data,112) As AUT01_R1_DATA_ULT_AGG
		,ausca_sigla_provincia As AUT01_R1_PROV_SEDE
		,right('000000000'+ausca_n_rea,9) As AUT01_R1_NUM_ISC_SEDE
		,CASE isnull(ausca_denominazione,'--') WHEN '--' 
			THEN REPLICATE(' ',160) 
			ELSE LEFT(SUBSTRING(LTRIM(RTRIM(ausca_denominazione)), 1, 160) + REPLICATE(' ', 160) , 160)
		END AS AUT01_R1_RAGIONE_SOCE_1
		,CASE isnull(ausca_denominazione,'--') WHEN '--' 
			THEN REPLICATE(' ',145) 
			ELSE LEFT(SUBSTRING(LTRIM(RTRIM(ausca_denominazione)), 161, 145) + REPLICATE(' ', 145) , 145)
		END AS AUT01_R1_RAGIONE_SOCE_2
		,ausca_codice_fiscale As AUT01_R1_COD_FISC_IMP
		,ausca_piva As AUT01_R1_PART_IVA
		,aungi_codice_forma As AUT01_R1_NAT_GIU
		,ausca_c_fonte As AUT01_R1_COD_PROVEN
		,CASE WHEN ausca_dt_annotazione IS NULL THEN  
			(CASE WHEN ausca_dt_iscrizione_rea IS NULL THEN  NULL ELSE CONVERT(VARCHAR(8),ausca_dt_iscrizione_rea,112) 	END )
			ELSE CONVERT(VARCHAR(8),ausca_dt_annotazione,112) 
		 END As AUT01_R1_DATA_ISCR_REA
		,CONVERT(VARCHAR(8),ausca_dt_iscrizione_rea,112) As [AUT01_R1_DATA_ISCR_REG_IMP]
		,ausca_codice_iscrizione_01 As AUT01_R1_COD_SEZ_SPECIALE_01
		,CONVERT(VARCHAR(8),ausca_dt_iscrizione_sezione_01,112) As AUT01_R1_DATA_INIZ_SEZ_SPE_01
		,ausca_f_colt_diretto_01 As AUT01_R1_FLAG_COL_DIRETTO_01
		,SPACE(8) As AUT01_R1_DATA_FIN_APP_SEZ_SPE_01
		,SPACE(3) As AUT01_R1_COD_MOTIVO_FIN_APP_SEZ_SPECIALE_01		
		,ausca_codice_iscrizione_02 As AUT01_R1_COD_SEZ_SPECIALE_02
		,CONVERT(VARCHAR(8),ausca_dt_iscrizione_sezione_03,112) As AUT01_R1_DATA_INIZ_SEZ_SPE_02
		,ausca_f_colt_diretto_02 As AUT01_R1_FLAG_COL_DIRETTO_02
		,SPACE(8) As AUT01_R1_DATA_FIN_APP_SEZ_SPE_02
		,SPACE(3) As AUT01_R1_COD_MOTIVO_FIN_APP_SEZ_SPECIALE_02				
		,ausca_codice_iscrizione_03 As AUT01_R1_COD_SEZ_SPECIALE_03		
		,CONVERT(VARCHAR(8),ausca_dt_iscrizione_sezione_03,112) As AUT01_R1_DATA_INIZ_SEZ_SPE_03
		,ausca_f_colt_diretto_03 As AUT01_R1_FLAG_COL_DIRETTO_03
		,SPACE(8) As AUT01_R1_DATA_FIN_APP_SEZ_SPE_03
		,SPACE(3) As AUT01_R1_COD_MOTIVO_FIN_APP_SEZ_SPECIALE_03				
		,NULL As AUT01_R1_FLAG_ISCR_ART_DECIS
		,CASE WHEN ausca_c_stato IS NULL THEN  'A' ELSE ausca_c_stato END As AUT01_R1_STATO_IMPRESA
		,CONVERT(VARCHAR(8),ausca_dt_inizio_attivita_impresa,112) As AUT01_R1_DATA_INIZIO_STATO_AT
		,NULL As AUT01_R1_DATA_ULT_AGG_ARC_SE
		,NULL As AUT01_R1_FLAG_FASE_AGG
		,ausca_c_causale_canc As [AUT01_R1_COD_CESS_INT]
		,CONVERT(VARCHAR(8),ausca_dt_cessazione_canc,112) As AUT01_R1_DATA_CESS_INT
		,CONVERT(VARCHAR(8),ausca_dt_domanda_canc,112) As [AUT01_R1_DATA_DENUN_CESS_INT]
		,CONVERT(VARCHAR(8),ausca_dt_canc_canc,112) As AUT01_R1_DATA_CAN_INFORM_INT
		,ausca_c_causale_canc As [AUT01_R1_COD_CESS_SEDE]
		,CONVERT(VARCHAR(8),ausca_dt_cessazione_canc,112) As [AUT01_R1_DATA_CESS_SEDE]
		,CONVERT(VARCHAR(8),ausca_dt_domanda_canc,112) As [AUT01_R1_DATA_DENUN_CESS_SEDE]
		,CONVERT(VARCHAR(8),ausca_dt_canc_canc,112) As [AUT01_R1_DATA_CAN_INFORM_SEDE]
		,ausca_codice_tipo_trasferimento As [AUT01_R1_IND_TRASF_SEDE]
		,CONVERT(VARCHAR(8),ausca_dt_cessazione_trasferimento,112) As [AUT01_R1_DATA_CESS_FUNZ_SEDE]
		,ausca_codice_causale_trasferimento As [AUT01_R1_COD_CAUS_CESS]
		,CONVERT(VARCHAR(8),group_auvis_data,112) As [AUT01_R1_DATA_AGG_ARC_IMP_NAZ]
		,SPACE(1028) As AUT01_R1_FILLER
		FROM #group_auvis WITH (READUNCOMMITTED) INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON 
			ausca_codice_fiscale = group_auvis_cf LEFT  JOIN tb_aungi_nat_giur_ct WITH (READUNCOMMITTED) ON 
			ausca_aungi_codice_pk = aungi_codice_pk

		--SELECT * FROM [dbo].[TB_AUT01_OSIRIDE_TR01];	
END	
