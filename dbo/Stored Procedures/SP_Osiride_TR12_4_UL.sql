CREATE PROCEDURE [dbo].[SP_Osiride_TR12_4_UL] 	
AS
BEGIN

--	SET NOCOUNT ON;
	
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

	INSERT INTO [dbo].[TB_AUT12_OSIRIDE_TR12]
			   ([AUT12_R12_TIPO]
			   ,[AUT12_R12_PROV_CCIAA]
			   ,[AUT12_R12_NUM_IREA]
			   ,[AUT12_R12_CODICE_FISCALE]
		       ,[AUT12_R12_AUULO_CODICE_PK]
			   ,[AUT12_R12_PROGRESSIVO_UL]
			   ,[AUT12_R12_CODICE_TIPO_UL]
			   ,[AUT12_R12_TIPO_UL]
			   ,[AUT12_R12_DENOMINAZIONE_UL]
			   ,[AUT12_R12_INSEGNA_UL]
			   ,[AUT12_R12_DATA_APERTURA_UL]
			   ,[AUT12_R12_PROVINCIA_UL]
			   ,[AUT12_R12_COD_ISTAT_COMUNE_UL]
			   ,[AUT12_R12_COMUNE_UL]
			   ,[AUT12_R12_COD_TOPONIMO_UL]
			   ,[AUT12_R12_INDIRIZZO_UL]
			   ,[AUT12_R12_CIVICO_UL]
			   ,[AUT12_R12_CAP_UL]
			   ,[AUT12_R12_COD_STATO_ESTERO_UL]
			   ,[AUT12_R12_FRAZIONE_UL]
			   ,[AUT12_R12_ALTRE_INDICAZIONI_UL]
			   ,[AUT12_R12_COD_STRADARIO_UL]
			   ,[AUT12_R12_TELEFONO_UL]
			   ,[AUT12_R12_FAX_UL]
			   ,[AUT12_R12_NREA_FUORI_PROV]
			   ,[AUT12_R12_COD_CAUSA_CESSAZIONE]
			   ,[AUT12_R12_DATA_CESSAZIONE_UL]
			   ,[AUT12_R12_DATA_DENUNCIA_CESS_UL]
			   ,[AUT12_R12_ANNO_DENUNCIA_ADDETTI]
			   ,[AUT12_R12_NUM_ADDETTI_FAM]
			   ,[AUT12_R12_NUM_ADDETTI_SUB]
			   ,[AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_01]
			   ,[AUT12_R12_COD_ENTE_RILASCIANTE_01]
			   ,[AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_02]
			   ,[AUT12_R12_COD_ENTE_RILASCIANTE_02]
			   ,[AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_03]
			   ,[AUT12_R12_COD_ENTE_RILASCIANTE_03]
			   ,[AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_04]
			   ,[AUT12_R12_COD_ENTE_RILASCIANTE_04]
			   ,[AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_05]
			   ,[AUT12_R12_COD_ENTE_RILASCIANTE_05]
			   ,[AUT12_R12_FLAG_OMISSIS_INI_ATT]
			   ,[AUT12_R12_DESCR_ATT_UL_01]
			   ,[AUT12_R12_DESCR_ATT_UL_02]
			   ,[AUT12_R12_DESCR_ATT_UL_03]
			   ,[AUT12_R12_DESCR_ATT_UL_04]
			   ,[AUT12_R12_DESCR_ATT_UL_05]
			   ,[AUT12_R12_FLAG_OMISSIS_ATT_2007]
			   ,[AUT12_R12_SUPER_VENDITA]
			   ,[AUT12_R12_SETT_MERC]
			   ,[AUT12_R12_DATA_DENUNCIA_INIZ_ATT]
			   ,[AUT12_R12_FLAG_OMISSIS_DESCR_ATT]) --raf
		SELECT  
			'12' as AUT12_R12_TIPO,
			ausca_cciaa as AUT12_R12_PROV_CCIAA,
			right('000000000'+ausca_n_rea,9) as AUT12_R12_NUM_IREA,
			ausca_codice_fiscale as AUT12_R12_CODICE_FISCALE,
			auulo_codice_pk,
			CASE isnull(auulo_progressivo_localizz,'---')   WHEN '---' THEN '0000' ELSE right('0000'+ ltrim(rtrim(auulo_progressivo_localizz)),4) END AS AUT12_R12_PROGRESSIVO_UL,
			--CASE isnull(auulo_descr_tipo_localizz,'000000000000000') WHEN '000000000000000' THEN space(15) ELSE left(ltrim(rtrim(auulo_descr_tipo_localizz)) + space(15) ,15) END AS AUT12_R12_CODICE_TIPO_UL, 
			'000000000000000' As AUT12_R12_CODICE_TIPO_UL,
			CASE IsNull(auulo_Tipo_localizz,'XX') WHEN 'XX' THEN 'SE' ELSE UPPER(auulo_Tipo_localizz) END as AUT12_R12_TIPO_UL,
			CASE isnull(auulo_denominazione,'--') WHEN '--' THEN space(305) ELSE left(ltrim(rtrim(auulo_denominazione)) + space(305) ,305) END AS AUT12_R12_DENOMINAZIONE_UL, 
			CASE isnull(auulo_insegna,'--') WHEN '--' THEN space(50) ELSE left(ltrim(rtrim(auulo_insegna)) + space(50),50) END AS AUT12_R12_INSEGNA_UL, 
			convert(varchar(8),[auulo_data_apertura],112) as AUT12_R12_DATA_APERTURA_UL,
			[auulo_sigla_prov] as AUT12_R12_PROVINCIA_UL,
			[auulo_cod_istat_comune] as AUT12_R12_COD_ISTAT_COMUNE_UL,
			[auulo_comune] as AUT12_R12_COMUNE_UL,						
			[auulo_toponimo] as AUT12_R12_COD_TOPONIMO_UL,				
			[auulo_via] as AUT12_R12_INDIRIZZO_UL,						
			[auulo_civico] as AUT12_R12_CIVICO_UL,						
			[auulo_cap] as AUT12_R12_CAP_UL,
			[auulo_codice_stato_estero] as AUT12_R12_COD_STATO_ESTERO_UL, 
			substring([auulo_frazione],1,25) as AUT12_R12_FRAZIONE_UL,
			substring([auulo_altre_indicazioni],1,30) as AUT12_R12_ALTRE_INDICAZIONI_UL,
			[auulo_cod_stradario] as AUT12_R12_COD_STRADARIO_UL,
			[auulo_telefono] as AUT12_R12_TELEFONO_UL,
			[auulo_fax] as AUT12_R12_FAX_UL,
			CASE isnull(Auulo_nrea_ul,'000000000') WHEN '000000000' THEN '000000000' ELSE right('000000000'+ ltrim(rtrim(Auulo_nrea_ul)),9) END AS AUT12_R12_NREA_FUORI_PROV, 
			[auulo_cod_causa_cess] as AUT12_R12_COD_CAUSA_CESSAZIONE,
			convert(varchar(8),[auulo_data_cessazione],112) as AUT12_R12_DATA_CESSAZIONE_UL,
			convert(varchar(8),[auulo_data_denuncia_cessazione],112) as AUT12_R12_DATA_DENUNCIA_CESS_UL,
			'0000' as AUT12_R12_ANNO_DENUNCIA_ADDETTI,
			'0000' As AUT12_R12_NUM_ADDETTI_FAM,
			'000000000' As AUT12_R12_NUM_ADDETTI_SUB,
			Space(1)  As AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_01,
			Space(1)  As AUT12_R12_COD_ENTE_RILASCIANTE_01,
			Space(1)  As AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_02,
			Space(1)  As AUT12_R12_COD_ENTE_RILASCIANTE_02,
			Space(1)  As AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_03,
			Space(1)  As AUT12_R12_COD_ENTE_RILASCIANTE_03,
			Space(1)  As AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_04,
			Space(1)  As AUT12_R12_COD_ENTE_RILASCIANTE_04,
			Space(1)  As AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_05,
			Space(1)  As AUT12_R12_COD_ENTE_RILASCIANTE_05,
			Space(1)  As AUT12_R12_FLAG_OMISSIS_INI_ATT,
			Space(1)  As AUT12_R12_DESCR_ATT_UL_01,
			Space(1)  As AUT12_R12_DESCR_ATT_UL_02,
			Space(1)  As AUT12_R12_DESCR_ATT_UL_03,
			Space(1)  As AUT12_R12_DESCR_ATT_UL_04,
			Space(1)  As AUT12_R12_DESCR_ATT_UL_05,			
			'0'       As AUT12_R12_FLAG_OMISSIS_ATT_2007,
			'0000'    As AUT12_R12_SUPER_VENDITA,
		    space(1)  As AUT12_R12_SETT_MERC,
		    space(8)  As AUT12_R12_DATA_DENUNCIA_INIZ_ATT,
			'0'		  As AUT12_R12_FLAG_OMISSIS_DESCR_ATT --raf
		FROM #group_auvis WITH (READUNCOMMITTED) INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON 
			 ausca_codice_fiscale = group_auvis_cf INNER JOIN tb_auulo_unita_locale WITH (READUNCOMMITTED) ON 
			 auulo_ausca_codice_pk = ausca_codice_pk ;			 		
			
		-- 
		TRUNCATE TABLE [TB_AUT12_BIS]	

		INSERT INTO [dbo].[TB_AUT12_BIS]
			([aut12_r12_codice_fiscale]
			,[aut12_r12_auulo_codice_pk]
			,[AUT12_R12_PROV_CCIAA]
			,[AUT12_R12_NUM_IREA]
			,[AUT12_R12_PROGRESSIVO_UL])
		SELECT [aut12_r12_codice_fiscale]
			,[aut12_r12_auulo_codice_pk]
			,[AUT12_R12_PROV_CCIAA]
			,[AUT12_R12_NUM_IREA]
			,[AUT12_R12_PROGRESSIVO_UL]
			FROM [AUC].[dbo].[TB_AUT12_OSIRIDE_TR12]
		WHERE  [aut12_r12_auulo_codice_pk] is not null
		--ORDER BY	[aut12_r12_codice_fiscale],
		--			[AUT12_R12_PROV_CCIAA],
		--			[AUT12_R12_NUM_IREA],
		--			[AUT12_R12_PROGRESSIVO_UL]		

			
		--select * from [TB_AUT12_OSIRIDE_TR12]
		
END
