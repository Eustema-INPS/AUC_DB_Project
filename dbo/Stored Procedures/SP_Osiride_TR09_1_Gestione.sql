CREATE PROCEDURE [dbo].[SP_Osiride_TR09_1_Gestione] 
AS
BEGIN
	SET NOCOUNT ON;

	TRUNCATE TABLE TB_AUT09_OSIRIDE_TR09
	TRUNCATE TABLE TB_AUT99_OSIRIDE_LISTA_CARICHE
	
	IF OBJECT_ID('tempdb..#group_auvis') IS NOT NULL	
		DROP TABLE #group_auvis;

	CREATE TABLE #group_auvis(
	group_auvis_cf char(16),
	group_auvis_data date);
	
	INSERT INTO #group_auvis(group_auvis_cf, group_auvis_data)
		SELECT dbo.tb_auvis_visure.auvis_CF, MAX(CONVERT(date, dbo.tb_auvis_visure.auvis_DataEstrazione, 103)) AS MaxData
		FROM dbo.tb_auvis_visure 
		INNER JOIN  dbo.tb_ausca_sog_contr_az ON dbo.tb_auvis_visure.auvis_CF = dbo.tb_ausca_sog_contr_az.ausca_codice_fiscale
		WHERE dbo.tb_auvis_visure.auvis_elaborato <> 9
		AND dbo.tb_ausca_sog_contr_az.ausca_soggetto_certificato = 'S'
		AND (dbo.tb_ausca_sog_contr_az.ausca_cert_auten_cod_pk = 2 AND dbo.tb_ausca_sog_contr_az.ausca_cert_cod_entita_rif=1)
		AND dbo.tb_auvis_visure.auvis_flag03 = 1
		GROUP BY dbo.tb_auvis_visure.auvis_CF, dbo.tb_ausca_sog_contr_az.ausca_soggetto_certificato, dbo.tb_ausca_sog_contr_az.ausca_cert_auten_cod_pk, dbo.tb_ausca_sog_contr_az.ausca_cert_cod_entita_rif


	-- SELECT * FROM #group_auvis

	INSERT INTO TB_AUT99_OSIRIDE_LISTA_CARICHE
		( [AUT09_R9_CODICE_FISCALE], [AUT09_R9_COD_FISC], [AUT09_R9_PROG_CARICA_01], [AUT09_R9_COD_CARICA_01], 
		  [AUT09_R9_DATA_INIZ_CAR_01], [AUT09_R9_DATA_FINE_CAR_01], [AUT09_R9_COD_DURA_CAR_01], [AUT09_R9_ANNI_ESE_CAR_01], [AUT09_R9_DATA_PRES_CAR_01]
		)
	SELECT ausca_codice_fiscale as [AUT09_R9_CODICE_FISCALE],
		   ausco_codice_fiscale as [AUT09_R9_COD_FISC],
		   '0001' as [AUT09_R9_PROG_CARICA],
		   aurss_codice_carica as [AUT09_R9_COD_CARICA],
		   CONVERT(varchar(8),aurss_data_inizio_validita,112) As [AUT09_R9_DATA_INIZ_CAR],
		   CONVERT(varchar(8),aurss_data_di_fine_validita,112) As [AUT09_R9_DATA_FINE_CAR],
		   aurss_cod_durata_carica as [AUT09_R9_COD_DURA_CAR],
		   aurss_anni_ese_carica as [AUT09_R9_ANNI_ESE_CAR],
		   CONVERT(varchar(8),[aurss_data_pres_carica],112) as [AUT09_R9_DATA_PRES_CAR]
	FROM #group_auvis WITH (READUNCOMMITTED) INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON		
		 ausca_codice_fiscale = group_auvis_cf INNER JOIN tb_aurss_rel_sog_sog WITH (READUNCOMMITTED) ON 
		 aurss_ausca_codice_pk = ausca_codice_pk INNER JOIN tb_ausco_sog_contr_col WITH (READUNCOMMITTED) ON 
		 aurss_ausco_codice_pk = ausco_codice_pk
	WHERE aurss_relazione_certificata = 'S' AND ausco_tipo_persona = 'F'  
	AND CONVERT(date, aurss_data_inizio_validita) <= CONVERT(date,getdate()) 
	AND CONVERT(date, aurss_data_di_fine_validita) >= CONVERT(date,getdate())

	--SELECT * FROM TB_AUT99_OSIRIDE_LISTA_CARICHE ORDER BY [AUT09_R9_CODICE_FISCALE], [AUT09_R9_COD_FISC]

	-- Popolamento della TB_AUT09_OSIRIDE_TR09 al netto delle CARICHE

	INSERT INTO [dbo].[TB_AUT09_OSIRIDE_TR09]
			   ([AUT09_R9_TIPO]
			   ,[AUT09_R9_PROV_CCIAA]
			   ,[AUT09_R9_NUM_IREA]
			   ,[AUT09_R9_CODICE_FISCALE]
			   ,[AUT09_R9_PROG_PERS]
			   ,[AUT09_R9_COGN_PERS]
			   ,[AUT09_R9_NOME_PERS]
			   ,[AUT09_R9_COD_STATO_NASC]
			   ,[AUT09_R9_PROV_NASC]
			   ,[AUT09_R9_ISTAT_COM_NASC]
			   ,[AUT09_R9_COMUNE_NASC]
			   ,[AUT09_R9_DATA_NASC]
			   ,[AUT09_R9_SESSO]
			   ,[AUT09_R9_COD_FISC]
			   ,[AUT09_R9_PROV_RES]
			   ,[AUT09_R9_ISTAT_COM_RES]
			   ,[AUT09_R9_COMUNE_RES]
			   ,[AUT09_R9_CAP_RES]
			   ,[AUT09_R9_COD_STATO_RES]
			   ,[AUT09_R9_FRAZ_RES]
			   ,[AUT09_R9_TOPONIMO_RES]
			   ,[AUT09_R9_IND_RES]
			   ,[AUT09_R9_NUM_CIV_RES]
			   ,[AUT09_R9_ALTRE_IND_RES]
			   ,[AUT09_R9_COD_STATO_CITTAD]
			   ,[AUT09_R9_COD_LIMIT_AGIRE]
			   ,[AUT09_R9_FLAG_SE_ELETTORE]
			   ,[AUT09_R9_POTERE_FIRMA]
			   ,[AUT09_R9_QUOTE_PARTEC]
			   ,[AUT09_R9_PERCE_PARTEC]
			   ,[AUT09_R9_QUOTE_PARTEC_E]
			   ,[AUT09_R9_QUOTA_C_VALUTA]
			   ,[AUT09_R9_CAR_OMISSIS]
			   ,[AUT09_R9_PROG_FALL_01]
			   ,[AUT09_R9_PR_TRIB_FALL_01]
			   ,[AUT09_R9_DESC_TRIB_FALL_01]
			   ,[AUT09_R9_NUM_FALL_01]
			   ,[AUT09_R9_DATA_FALL_01]
			   ,[AUT09_R9_NUM_SEN_FALL_01]
			   ,[AUT09_R9_DATA_SEN_FALL_01]
			   ,[AUT09_R9_ORG_GIUDI_01]
			   ,[AUT09_R9_CUR_FALL_01]
			   ,[AUT09_R9_DATA_CHIU_FALL_01]
			   ,[AUT09_R9_COGN_DEN_CAUSA_FALL_01]
			   ,[AUT09_R9_NOME_DEN_CAUSA_FALL_01]
			   ,[AUT09_R9_DATA_NAS_FALL_01]
			   ,[AUT09_R9_FALL_OMISSIS_FALL]		
			   )
	SELECT  
		'09' as AUT09_R9_TIPO,
		ausca_cciaa as AUT09_R9_PROV_CCIAA,
		right('000000000'+ausca_n_rea,9) As AUT09_R9_NUM_IREA,
		ausca_codice_fiscale as [AUT09_R9_CODICE_FISCALE],				
		CASE Isnull(aurss_prog_pers,'----') WHEN '----' THEN '0000' ELSE right('0000' + ltrim(rtrim(aurss_prog_pers)),4) END  AS [AUT09_R9_PROG_PERS],
		substring(ausco_cognome,1,25) as [AUT09_R9_COGN_PERS],
		substring(ausco_nome,1,25) as [AUT09_R9_NOME_PERS],
		substring(ausco_stato_estero_nascita,1,3) as [AUT09_R9_COD_STATO_NASC],
		ausco_prov_nascita as [AUT09_R9_PROV_NASC],
		-- commento -- ausco_codice_comune_nasc as [AUT09_R9_ISTAT_COM_NASC],
		Space(5) as [AUT09_R9_ISTAT_COM_NASC],
		substring(ausco_comune_nascita,1,30) as [AUT09_R9_COMUNE_NASC],
		convert(varchar(8),[ausco_data_nascita],112) as [AUT09_R9_DATA_NASC],
		ausco_sesso as [AUT09_R9_SESSO],
		ausco_codice_fiscale as [AUT09_R9_COD_FISC],
		ausco_provincia as [AUT09_R9_PROV_RES],
		ausco_residenza_codice_comune as [AUT09_R9_ISTAT_COM_RES],
		left(ausco_localita,30) as [AUT09_R9_COMUNE_RES],
		ausco_cap as [AUT09_R9_CAP_RES], 
		ausco_residenza_codice_stato as [AUT09_R9_COD_STATO_RES],
		ausco_residenza_frazione as [AUT09_R9_FRAZ_RES],
		ausco_codice_toponimo as [AUT09_R9_TOPONIMO_RES],
		substring(ausco_indirizzo,1,30) as [AUT09_R9_IND_RES],
		substring(ausco_civico,1,8) as [AUT09_R9_NUM_CIV_RES],
		ausco_residenza_altre_indic as [AUT09_R9_ALTRE_IND_RES],
		substring([ausco_cittadinanza],1,3) as [AUT09_R9_COD_STATO_CITTAD],
		aurss_cap_agire as [AUT09_R9_COD_LIMIT_AGIRE],
		
		CASE isnull(aurss_flag_se_elettore,'-') WHEN '-' THEN '0' ELSE right('0'+aurss_flag_se_elettore,1) END AS [AUT09_R9_FLAG_SE_ELETTORE], 
		CASE isnull(aurss_potere_firma,'-')     WHEN '-' THEN '0' ELSE right('0'+aurss_potere_firma,1) END AS [AUT09_R9_POTERE_FIRMA], 
		CASE isnull(aurss_quote_partec,'000000000000000')     WHEN '000000000000000' THEN '000000000000000' ELSE right('000000000000000'+aurss_quote_partec,15) END AS [AUT09_R9_QUOTE_PARTEC] ,

		CASE isnull(aurss_perce_partec,'----')     WHEN '----' THEN '0000' ELSE right('0000'+aurss_perce_partec,4) END AS [AUT09_R9_PERCE_PARTEC] ,
		CASE isnull(aurss_quote_partec_e,'00000000000000000')   WHEN '00000000000000000' THEN '00000000000000000' ELSE right('00000000000000000'+aurss_quote_partec_e,17) END AS [AUT09_R9_QUOTE_PARTEC_E] ,
		CASE isnull(aurss_quota_c_valuta,'---')   WHEN '---' THEN '000' ELSE right('000'+aurss_quota_c_valuta,3) END AS [AUT09_R9_QUOTA_C_VALUTA], 	 
		'0' as [AUT09_R9_CAR_OMISSIS],
		CASE isnull([aufal_p_fallimento],'----')     WHEN '----' THEN '    ' ELSE right('0000'+[aufal_p_fallimento],4) END AS [AUT09_R9_PROG_FALLI_01], 
		[aufal_prov_tribunale] as [AUT09_R9_PR_TRIB_FALL_01],
		[aufal_tribunale] as [AUT09_R9_DESC_TRIB_FALL_01],
		[aufal_n_fallimento] as [AUT09_R9_NUM_FALL_01],
		convert(varchar(8),[aufal_dt_fallimento],112) as [AUT09_R9_DATA_FALL_01],
		[aufal_n_sentenza] as [AUT09_R9_NUM_SEN_FALL_01],
		convert(varchar(8),[aufal_dt_sentenza],112) as [AUT09_R9_DATA_SEN_FALL_01],
		[aufal_c_organo_giud] as [AUT09_R9_ORG_GIUDI_01],
		[aufal_curatore] as [AUT09_R9_CUR_FALL_01],
		NULL as [AUT09_R9_DATA_CHIU_FALL_01],
		[aufal_cognome] as [AUT09_R9_COGN_DEN_CAUSA_FALL_01],
		[aufal_nome] as [AUT09_R9_NOME_DEN_CAUSA_FALL_01],
		convert(varchar(8),[aufal_dt_nascita],112) as [AUT09_R9_DATA_NAS_FALL_01],
		'0' as [AUT09_R9_FALL_OMISSIS_FALL]
		
	FROM #group_auvis WITH (READUNCOMMITTED) INNER JOIN  tb_ausca_sog_contr_az WITH (READUNCOMMITTED) on 
		ausca_codice_fiscale = group_auvis_cf INNER  JOIN tb_aurss_rel_sog_sog WITH (READUNCOMMITTED) ON 
		aurss_ausca_codice_pk = ausca_codice_pk INNER JOIN  tb_ausco_sog_contr_col WITH (READUNCOMMITTED) ON 
		aurss_ausco_codice_pk = ausco_codice_pk LEFT OUTER JOIN tb_aufal_fallimento WITH (READUNCOMMITTED) ON 
		ausco_codice_pk = aufal_ausco_codice_pk
	WHERE aurss_relazione_certificata = 'S' 
	AND ausco_tipo_persona = 'F'
	AND Isnull(ltrim(rtrim(aurss_prog_pers)),'0000') <> '0000'	
	AND CONVERT(date, aurss_data_inizio_validita) <= CONVERT(date,getdate()) 
	AND CONVERT(date, aurss_data_di_fine_validita) >= CONVERT(date,getdate())


	-- RIMOZIONE DEI DUPLICATI --
	DELETE T1 FROM
	(
		SELECT
			ROW_NUMBER() OVER(PARTITION BY AUT09_R9_CODICE_FISCALE, AUT09_R9_COD_FISC ORDER BY AUT09_R9_CODICE_FISCALE, AUT09_R9_COD_FISC ) AS [RowNumber]
		  , AUT09_R9_CODICE_FISCALE
		  , AUT09_R9_COD_FISC
		FROM [TB_AUT09_OSIRIDE_TR09]
	) AS T1
	WHERE RowNumber > 1

	--SELECT * FROM [dbo].[TB_AUT09_OSIRIDE_TR09] order by AUT09_R9_CODICE_FISCALE , AUT09_R9_COD_FISC

	-- Gestione della Trasposizione in orizzontale delle Cariche Azienda/Soggetto
	Declare @CF_Azienda  As Varchar(16);
	Declare @CF_Soggetto As Varchar(16);
	DECLARE	@Return_Value int;
 
	Declare @SoggettoCaricheCursor as CURSOR;
 
	SET @SoggettoCaricheCursor = CURSOR FOR
		SELECT 
			ausca_codice_fiscale As [AUT09_R9_CODICE_FISCALE],
			ausco_codice_fiscale As [AUT09_R9_COD_FISC]	 
		FROM #group_auvis WITH (READUNCOMMITTED)
		INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON ausca_codice_fiscale = group_auvis_cf
		INNER JOIN tb_aurss_rel_sog_sog WITH (READUNCOMMITTED) ON aurss_ausca_codice_pk = ausca_codice_pk
		INNER JOIN tb_ausco_sog_contr_col WITH (READUNCOMMITTED) ON aurss_ausco_codice_pk = ausco_codice_pk
		--LEFT OUTER JOIN tb_aufal_fallimento WITH (READUNCOMMITTED) ON ausco_codice_pk = aufal_ausco_codice_pk
		WHERE aurss_relazione_certificata = 'S' 
		AND ausco_tipo_persona = 'F' 
		AND CONVERT(date, aurss_data_inizio_validita) <= CONVERT(date,getdate()) 
		AND CONVERT(date, aurss_data_di_fine_validita) >= CONVERT(date,getdate())
		GROUP BY ausca_codice_fiscale,ausco_codice_fiscale
		ORDER BY ausca_codice_fiscale,ausco_codice_fiscale;
 
	OPEN @SoggettoCaricheCursor;
	FETCH NEXT FROM @SoggettoCaricheCursor INTO @CF_Azienda, @CF_Soggetto;
 
	WHILE @@FETCH_STATUS = 0
		BEGIN
			--PRINT 'TR09_2_TrasponiCariche - ' + @CF_Azienda + '-' + @CF_Soggetto;			--
			EXEC @Return_Value = [dbo].[SP_Osiride_TR09_2_TrasponiCariche]
				 @Azienda = @CF_Azienda  ,
				 @Soggetto= @CF_Soggetto 
			--
		FETCH NEXT FROM @SoggettoCaricheCursor INTO @CF_Azienda, @CF_Soggetto;
	END
 
	CLOSE @SoggettoCaricheCursor;
	DEALLOCATE @SoggettoCaricheCursor;

	DROP TABLE #group_auvis ;
		
	-- 2018 12 02 Tolgo i tappi alle date --
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_INIZ_CAR_01 = SPACE(8) WHERE AUT09_R9_DATA_INIZ_CAR_01 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_FINE_CAR_01 = SPACE(8) WHERE AUT09_R9_DATA_FINE_CAR_01 = '29991231';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_01 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_01 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_01 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_01 = '29991231';

	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_INIZ_CAR_02 = SPACE(8) WHERE AUT09_R9_DATA_INIZ_CAR_02 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_FINE_CAR_02 = SPACE(8) WHERE AUT09_R9_DATA_FINE_CAR_02 = '29991231';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_02 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_02 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_02 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_02 = '29991231';

	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_INIZ_CAR_03 = SPACE(8) WHERE AUT09_R9_DATA_INIZ_CAR_03 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_FINE_CAR_03 = SPACE(8) WHERE AUT09_R9_DATA_FINE_CAR_03 = '29991231';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_03 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_03 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_03 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_03 = '29991231';

	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_INIZ_CAR_04 = SPACE(8) WHERE AUT09_R9_DATA_INIZ_CAR_04 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_FINE_CAR_04 = SPACE(8) WHERE AUT09_R9_DATA_FINE_CAR_04 = '29991231';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_04 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_04 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_04 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_04 = '29991231';

	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_INIZ_CAR_05 = SPACE(8) WHERE AUT09_R9_DATA_INIZ_CAR_05 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_FINE_CAR_05 = SPACE(8) WHERE AUT09_R9_DATA_FINE_CAR_05 = '29991231';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_05 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_05 = '19000101';
	UPDATE TB_AUT09_OSIRIDE_TR09 SET AUT09_R9_DATA_PRES_CAR_05 = SPACE(8) WHERE AUT09_R9_DATA_PRES_CAR_05 = '29991231';
		
END
