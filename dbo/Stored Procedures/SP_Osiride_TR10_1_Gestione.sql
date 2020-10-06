CREATE PROCEDURE [dbo].[SP_Osiride_TR10_1_Gestione] 
As
BEGIN
	SET NOCOUNT ON;

	TRUNCATE TABLE TB_AUT10_OSIRIDE_TR10
	TRUNCATE TABLE TB_AUT99_OSIRIDE_LISTA_CARICHE
	
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
		GROUP BY dbo.tb_auvis_visure.auvis_CF, dbo.tb_ausca_sog_contr_az.ausca_soggetto_certificato, dbo.tb_ausca_sog_contr_az.ausca_cert_auten_cod_pk, dbo.tb_ausca_sog_contr_az.ausca_cert_cod_entita_rif

	-- SELECT * FROM #group_auvis
	
	-- Caricamento della TB_AUT99_OSIRIDE_LISTA_CARICHE
	INSERT INTO TB_AUT99_OSIRIDE_LISTA_CARICHE
		(  [AUT09_R9_CODICE_FISCALE]
		  ,[AUT09_R9_COD_FISC]
		  ,[AUT09_R9_PROG_CARICA_01]
		  ,[AUT09_R9_COD_CARICA_01]
		  ,[AUT09_R9_DATA_INIZ_CAR_01]
		  ,[AUT09_R9_DATA_FINE_CAR_01]
		  ,[AUT09_R9_COD_DURA_CAR_01]
		  ,[AUT09_R9_ANNI_ESE_CAR_01]
		  ,[AUT09_R9_DATA_PRES_CAR_01]
		)
		SELECT ausca_codice_fiscale as [AUT09_R9_CODICE_FISCALE],
				ausco_codice_fiscale as [AUT09_R9_COD_FISC],
				1 as [AUT09_R9_PROG_CARICA],
				aurss_codice_carica as [AUT09_R9_COD_CARICA],
				CONVERT(varchar(8),aurss_data_inizio_validita,112) as [AUT09_R9_DATA_INIZ_CAR],
				CONVERT(varchar(8),aurss_data_di_fine_validita,112) as [AUT09_R9_DATA_FINE_CAR],
				[aurss_cod_durata_carica] as [AUT09_R9_COD_DURA_CAR],
				[aurss_anni_ese_carica] as [AUT09_R9_ANNI_ESE_CAR],
				CONVERT(varchar(8),[aurss_data_pres_carica],112) as [AUT09_R9_DATA_PRES_CAR]
		FROM #group_auvis WITH (READUNCOMMITTED) INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON		
			ausca_codice_fiscale = group_auvis_cf INNER JOIN tb_aurss_rel_sog_sog WITH (READUNCOMMITTED) ON 
			aurss_ausca_codice_pk = ausca_codice_pk INNER JOIN tb_ausco_sog_contr_col WITH (READUNCOMMITTED) ON 
			aurss_ausco_codice_pk = ausco_codice_pk
		WHERE aurss_relazione_certificata = 'S' AND ausco_tipo_persona = 'G'  
		AND CONVERT(date, aurss_data_inizio_validita) <= CONVERT(date,getdate()) 
		AND CONVERT(date, aurss_data_di_fine_validita) >= CONVERT(date,getdate())
		order by ausco_codice_fiscale

	--SELECT * FROM TB_AUT99_OSIRIDE_LISTA_CARICHE ORDER BY [AUT09_R9_CODICE_FISCALE], [AUT09_R9_COD_FISC]

	-- Popolamento della TB_AUT10_OSIRIDE_TR10 al netto delle CARICHE	
	INSERT INTO [dbo].[TB_AUT10_OSIRIDE_TR10]
           ([AUT10_R10_TIPO]
           ,[AUT10_R10_PROV_CCIAA]
           ,[AUT10_R10_NUM_IREA]
           ,[AUT10_R10_CODICE_FISCALE]
           ,[AUT10_R10_PROG_PERS]
           ,[AUT10_R10_PROV_CCIAA_PG]
           ,[AUT10_R10_NUM_IREA_PG]
           ,[AUT10_R10_NUM_RIMP_PERS]
           ,[AUT10_R10_DENOM_PERS]
           ,[AUT10_R10_DATA_COSTITUZIONE]
           ,[AUT10_R10_COD_FISC]
           ,[AUT10_R10_ISTAT_COM_SEDE]
		   ,[AUT10_R10_ISTAT_COM_SEDE2]
           ,[AUT10_R10_COMUNE_SEDE]
           ,[AUT10_R10_PROV_SEDE]
           ,[AUT10_R10_TOPONIMO_SEDE]
           ,[AUT10_R10_IND_SEDE]
           ,[AUT10_R10_NUM_CIV_SEDE]
           ,[AUT10_R10_CAP_SEDE]
           ,[AUT10_R10_COD_STATO_SEDE]
           ,[AUT10_R10_FRAZ_SEDE]
           ,[AUT10_R10_ALTRE_IND_SEDE]
           ,[AUT10_R10_QUOTE_PARTEC]
           ,[AUT10_R10_PERCE_PARTEC]
           ,[AUT10_R10_QUOTE_PARTEC_E]
           ,[AUT10_R10_QUOTA_C_VALUTA]
           ,[AUT10_R10_CAR_OMISSIS]
           ,[AUT10_R10_PROG_FALLI_01]
           ,[AUT10_R10_PR_TRIB_FALL_01]
           ,[AUT10_R10_DESC_TRIB_FALL_01]
           ,[AUT10_R10_NUM_FALL_01]
           ,[AUT10_R10_DATA_FALL_01]
           ,[AUT10_R10_NUM_SEN_FALL_01]
           ,[AUT10_R10_DATA_SEN_FALL_01]
           ,[AUT10_R10_ORG_GIUDI_01]
           ,[AUT10_R10_CUR_FALL_01]
           ,[AUT10_R10_DATA_CHIU_FALL_01]
           ,[AUT10_R10_COGN_DEN_CAUSA_FALL_01]
           ,[AUT10_R10_NOME_DEN_CAUSA_FALL_01]
           ,[AUT10_R10_DATA_NAS_FALL_01]
           ,[AUT10_R10_FALL_OMISSIS]
           ,[AUT10_R10_FILLER])
	SELECT  
		'10' As AUT10_10_TIPO,
		ausca.ausca_cciaa As AUT10_R10_PROV_CCIAA,
		right('000000000'+ ausca.ausca_n_rea,9) As AUT10_R10_NUM_IREA,
		ausca.ausca_codice_fiscale As [AUT10_R10_CODICE_FISCALE],
		CASE isnull(aurss_prog_pers,'----')   WHEN '----' THEN '0000' ELSE right('0000'+aurss_prog_pers,4) END AS [AUT10_R10_PROG_PERS], 		
		ausca_ausco.ausca_cciaa As [AUT10_R10_PROV_CCIAA_PG],
		RIGHT('000000000'+ SUBSTRING(ausca_ausco.ausca_n_rea,1,9),9) As [AUT10_R10_NUM_IREA_PG],				
		SPACE(21) As [AUT10_R10_NUM_RIMP_PERS],
		SUBSTRING(ausca_ausco.ausca_denominazione,1,305) As [AUT10_R10_DENOM_PERS], 
		CONVERT(VARCHAR(8),ausca_ausco.ausca_data_inizio_attivita,112) As [AUT10_R10_DATA_COSTITUZIONE], -- da verificare!!!!
		ausco_codice_fiscale As [AUT10_R10_COD_FISC],
		ausca_ausco.ausca_codice_comune As [AUT10_R10_ISTAT_COM_SEDE],
		ausca_ausco.ausca_codice_comune As [AUT10_R10_ISTAT_COM_SEDE2],
		ausca_ausco.ausca_descr_comune As [AUT10_R10_COMUNE_SEDE],
		ausca_ausco.ausca_sigla_provincia As [AUT10_R10_PROV_SEDE],
		ausca_ausco.ausca_codice_toponimo As [AUT10_R10_TOPONIMO_SEDE],
		SUBSTRING(ausca_ausco.ausca_indirizzo, 1, 30) As [AUT10_R10_IND_SEDE],
		SUBSTRING(ausca_ausco.ausca_civico,1,8) As [AUT10_R10_NUM_CIV_SEDE],
		ausca_ausco.ausca_cap As [AUT10_R10_CAP_SEDE],
		ausca_ausco.ausca_codice_stato_estero As [AUT10_R10_COD_STATO_SEDE],
		SUBSTRING(ausca_ausco.ausca_frazione,1,25) As [AUT10_R10_FRAZ_SEDE],
		NULL As [AUT10_R10_ALTRE_IND_SEDE],			----- da inserire su AUSCA!!!!
		CASE isnull(aurss_quote_partec,'000000000000000') WHEN '000000000000000' THEN '000000000000000' ELSE right('000000000000000'+aurss_quote_partec,15) END AS [AUT10_R10_QUOTE_PARTEC], 
		CASE isnull(aurss_perce_partec,'----')     WHEN '----' THEN '0000' ELSE right('0000'+aurss_perce_partec,4) END AS [AUT10_R10_PERCE_PARTEC], 
		CASE isnull(aurss_quote_partec_e,'00000000000000000')   WHEN '00000000000000000' THEN '00000000000000000' ELSE right('00000000000000000'+aurss_quote_partec_e,17) END AS [AUT10_R10_QUOTE_PARTEC_E], 	
		CASE isnull(aurss_quota_c_valuta,'---')   WHEN '---' THEN '000' ELSE right('000'+aurss_quota_c_valuta,3) END AS [AUT10_R10_QUOTA_C_VALUTA], 	 
		'0' As [AUT10_R10_CAR_OMISSIS],		
		CASE isnull(aufal_p_fallimento,'----')   WHEN '----' THEN '    ' ELSE right('0000'+aurss_prog_pers,4) END AS [AUT10_R10_PROG_FALLI_01], 		
		[aufal_prov_tribunale] As [AUT10_R10_PR_TRIB_FALL_01],
		[aufal_tribunale] As [AUT10_R10_DESC_TRIB_FALL_01],
		[aufal_n_fallimento] As [AUT10_R10_NUM_FALL_01],
		CONVERT(VARCHAR(8),[aufal_dt_fallimento],112) As [AUT10_R10_DATA_FALL_01],
		[aufal_n_sentenza] As [AUT10_R10_NUM_SEN_FALL_01],
		CONVERT(VARCHAR(8),[aufal_dt_sentenza],112) As [AUT10_R10_DATA_SEN_FALL_01],
		[aufal_c_organo_giud] As [AUT10_R10_ORG_GIUDI_01],
		[aufal_curatore] As [AUT10_R10_CUR_FALL_01],
		NULL As [AUT10_R10_DATA_CHIU_FALL_01],
		[aufal_cognome] As [AUT10_R10_COGN_DEN_CAUSA_FALL_01],
		[aufal_nome] As [AUT10_R10_NOME_DEN_CAUSA_FALL_01],
		CONVERT(VARCHAR(8),[aufal_dt_nAscita],112) As [AUT10_R10_DATA_NAs_FALL_01],
		'0' As [AUT10_R10_FALL_OMISSIS_PER_01],
		NULL As [AUT10_R10_FILLER]
	FROM #group_auvis WITH (READUNCOMMITTED) INNER JOIN tb_ausca_sog_contr_az As ausca WITH (READUNCOMMITTED) on 
		 ausca_codice_fiscale = group_auvis_cf INNER JOIN tb_aurss_rel_sog_sog WITH (READUNCOMMITTED) ON 
		 aurss_ausca_codice_pk = ausca_codice_pk INNER JOIN tb_ausco_sog_contr_col WITH (READUNCOMMITTED) ON 
		 aurss_ausco_codice_pk = ausco_codice_pk LEFT OUTER JOIN tb_aufal_fallimento WITH (READUNCOMMITTED) ON 
		 ausco_codice_pk = aufal_ausco_codice_pk LEFT OUTER JOIN tb_ausca_sog_contr_az As ausca_ausco WITH (READUNCOMMITTED) ON 
	     tb_ausco_sog_contr_col.ausco_codice_fiscale = ausca_ausco.ausca_codice_fiscale
	WHERE aurss_relazione_certificata = 'S' 
	AND ausco_tipo_persona = 'G' 
	AND isnull(aurss_prog_pers,'0000') <> '0000'	
	AND CONVERT(date, aurss_data_inizio_validita) <= CONVERT(date,getdate()) 
	AND CONVERT(date, aurss_data_di_fine_validita) >= CONVERT(date,getdate());

UPDATE TB_AUT10_OSIRIDE_TR10
SET
		    [AUT10_R10_DENOM_PERS] = SUBSTRING(ausco_denominazione,1,305)
		   ,[AUT10_R10_ISTAT_COM_SEDE]=substring(ausco_codice_comune_istat,4,3)
		   ,[AUT10_R10_ISTAT_COM_SEDE2]=substring(ausco_codice_comune_istat,4,3)
           ,[AUT10_R10_COMUNE_SEDE]=substring(ausco_localita,1,30)
           ,[AUT10_R10_PROV_SEDE]=ausco_provincia
           ,[AUT10_R10_TOPONIMO_SEDE]=ausco_codice_toponimo
           ,[AUT10_R10_IND_SEDE]=SUBSTRING(ausco_indirizzo, 1, 30)
           ,[AUT10_R10_NUM_CIV_SEDE]=SUBSTRING(ausco_civico,1,8)
           ,[AUT10_R10_CAP_SEDE]=ausco_cap
           ,[AUT10_R10_COD_STATO_SEDE]=ausco_codice_stato_estero
           ,[AUT10_R10_FRAZ_SEDE]=SUBSTRING(ausco_frazione,1,25)
FROM TB_AUT10_OSIRIDE_TR10 
INNER JOIN tb_ausco_sog_contr_col on [AUT10_R10_COD_FISC]= ausco_codice_fiscale
WHERE [AUT10_R10_DENOM_PERS] IS NULL


	--SELECT * FROM [dbo].[TB_AUT10_OSIRIDE_TR10]

-- RIMOZIONE DEI DUPLICATI --
DELETE T1 FROM
(
	SELECT
		ROW_NUMBER() OVER(PARTITION BY AUT10_R10_CODICE_FISCALE, AUT10_R10_COD_FISC ORDER BY AUT10_R10_CODICE_FISCALE ) As [RowNumber]
		, AUT10_R10_CODICE_FISCALE
		, AUT10_R10_COD_FISC
	FROM [TB_AUT10_OSIRIDE_TR10]
) As T1
WHERE RowNumber > 1

	-- Gestione della Trasposizione in orizzontale delle Cariche Azienda/Soggetto
	DECLARE @CF_Azienda  As VARCHAR(16);
	DECLARE @CF_Soggetto As VARCHAR(16);
	DECLARE	@Return_Value int;
 
	DECLARE @SoggettoCaricheCursor As CURSOR;
 
	SET @SoggettoCaricheCursor = CURSOR FOR
		SELECT 
			LTRIM(RTRIM(ausca_codice_fiscale)) As [AUT10_R10_CODICE_FISCALE],
			LTRIM(RTRIM(ausco_codice_fiscale)) As [AUT10_R10_COD_FISC]	 
		FROM #group_auvis WITH (READUNCOMMITTED)
		INNER JOIN tb_ausca_sog_contr_az  WITH (READUNCOMMITTED) ON ausca_codice_fiscale = group_auvis_cf
		INNER JOIN tb_aurss_rel_sog_sog   WITH (READUNCOMMITTED) ON aurss_ausca_codice_pk = ausca_codice_pk
		INNER JOIN tb_ausco_sog_contr_col WITH (READUNCOMMITTED) ON aurss_ausco_codice_pk = ausco_codice_pk
		--LEFT OUTER JOIN tb_aufal_fallimento WITH (READUNCOMMITTED) ON ausco_codice_pk = aufal_ausco_codice_pk
		WHERE aurss_relazione_certificata = 'S' 
		AND ausco_tipo_persona = 'G' 
		GROUP BY ausca_codice_fiscale,ausco_codice_fiscale
		ORDER BY ausca_codice_fiscale,ausco_codice_fiscale;
 
	OPEN @SoggettoCaricheCursor;
	FETCH NEXT FROM @SoggettoCaricheCursor INTO @CF_Azienda, @CF_Soggetto;
 
	WHILE @@FETCH_STATUS = 0
		BEGIN
			--PRINT @CF_Azienda + '-' + @CF_Soggetto;
			--
			EXEC @Return_Value = [dbo].[SP_Osiride_TR10_2_TrasponiCariche]
				 @Azienda = @CF_Azienda  ,
				 @Soggetto= @CF_Soggetto 
			--
		FETCH NEXT FROM @SoggettoCaricheCursor INTO @CF_Azienda, @CF_Soggetto;
	END
 
	CLOSE @SoggettoCaricheCursor;
	DEALLOCATE @SoggettoCaricheCursor;

	DROP TABLE #group_auvis ;

	-- 2018 12 02 Tolgo i tappi alle date --
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_INIZ_CAR_01 = SPACE(8) WHERE AUT10_R10_DATA_INIZ_CAR_01 = '19000101';
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_FINE_CAR_01 = SPACE(8) WHERE AUT10_R10_DATA_FINE_CAR_01 = '29991231';
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_INIZ_CAR_02 = SPACE(8) WHERE AUT10_R10_DATA_INIZ_CAR_02 = '19000101';
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_FINE_CAR_02 = SPACE(8) WHERE AUT10_R10_DATA_FINE_CAR_02 = '29991231';	
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_INIZ_CAR_03 = SPACE(8) WHERE AUT10_R10_DATA_INIZ_CAR_03 = '19000101';
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_FINE_CAR_03 = SPACE(8) WHERE AUT10_R10_DATA_FINE_CAR_03 = '29991231';
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_INIZ_CAR_04 = SPACE(8) WHERE AUT10_R10_DATA_INIZ_CAR_04 = '19000101';
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_FINE_CAR_04 = SPACE(8) WHERE AUT10_R10_DATA_FINE_CAR_04 = '29991231';
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_INIZ_CAR_05 = SPACE(8) WHERE AUT10_R10_DATA_INIZ_CAR_05 = '19000101';
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_FINE_CAR_05 = SPACE(8) WHERE AUT10_R10_DATA_FINE_CAR_05 = '29991231';

	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_COSTITUZIONE = SPACE(8) WHERE AUT10_R10_DATA_COSTITUZIONE = '19000101';
	UPDATE TB_AUT10_OSIRIDE_TR10 SET AUT10_R10_DATA_COSTITUZIONE = SPACE(8) WHERE AUT10_R10_DATA_COSTITUZIONE = '29991231';


		
END
