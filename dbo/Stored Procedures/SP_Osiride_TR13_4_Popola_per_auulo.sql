CREATE PROCEDURE [dbo].[SP_Osiride_TR13_4_Popola_per_auulo] 
AS
BEGIN
	SET NOCOUNT ON;
	
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

	-- SELECT * FROM #group_auvis	
	INSERT INTO [dbo].[TB_AUT13_OSIRIDE_TR13]
			([AUT13_R13_TIPO]
			,[AUT13_R13_PROV_CCIAA]
			,[AUT13_R13_NUM_IREA]
			,[AUT13_R13_CODICE_FISCALE]
			,[AUT13_R13_PROGRESSIVO_UL]
			,[AUT13_R13_TIPO_RUOLO]
			,[AUT13_R13_FORMA_RUOLO]
			,[AUT13_R13_N_RUOLO]
			,[AUT13_R13_PROVINCIA_RUOLO]
			,[AUT13_R13_COD_ENTE_ALBO]
			,[AUT13_R13_DATA_DOM_ISCR]
			,[AUT13_R13_DATA_DOM_CESS]
			,[AUT13_R13_DATA_DEL_CESS]
			,[AUT13_R13_DATA_EFF_CESS]
			,[AUT13_R13_COD_CAU_CESS]
			,[AUT13_R13_auulo_codice_pk])
	SELECT
			'13' AS AUT13_R13_TIPO,
			ausca_cciaa AS AUT13_R13_PROV_CCIAA,
			right('000000000'+ausca_n_rea,9) AS AUT13_R13_NUM_IREA,
			ausca_codice_fiscale AS AUT13_R13_CODICE_FISCALE,
			auulo_progressivo_localizz AS AUT13_R13_PROGRESSIVO_UL,
			[auaru_c_tipo] AS [AUT13_R13_TIPO_RUOLO],
			substring(auaru_c_forma,1,1) AS [AUT13_R13_FORMA_RUOLO],
			[auaru_n_ruolo] AS [AUT13_R13_N_RUOLO],
			[auaru_ruolo_provincia] AS [AUT13_R13_PROVINCIA_RUOLO],
			[auaru_c_ente_rilascio] AS [AUT13_R13_COD_ENTE_ALBO],

			--convert(varchar(8),[auaru_dt_iscrizione],112) AS [AUT13_R13_DATA_DOM_ISCR],
			--convert(varchar(8),[auaru_dt_domanda],112) AS [AUT13_R13_DATA_DOM_CESS],			
			--convert(varchar(8),[auaru_dt_delibera],112) AS [AUT13_R13_DATA_DEL_CESS],			
			--convert(varchar(8),[auaru_dt_cessazione],112) AS [AUT13_R13_DATA_EFF_CESS],

			CASE convert(varchar(8),[auaru_dt_iscrizione],112) WHEN '19000101' THEN null ELSE CASE convert(varchar(8),[auaru_dt_iscrizione],112) WHEN '29991231' THEN null ELSE convert(varchar(8),[auaru_dt_iscrizione],112) END END AS [AUT13_R13_DATA_DOM_ISCR],
			CASE convert(varchar(8),[auaru_dt_domanda],112) WHEN '19000101' THEN null ELSE CASE convert(varchar(8),[auaru_dt_domanda],112) WHEN '29991231' THEN null ELSE convert(varchar(8),[auaru_dt_domanda],112) END END AS [AUT13_R13_DATA_DOM_CESS],
			CASE convert(varchar(8),[auaru_dt_delibera],112) WHEN '19000101' THEN null ELSE CASE convert(varchar(8),[auaru_dt_delibera],112) WHEN '29991231' THEN null ELSE convert(varchar(8),[auaru_dt_delibera],112) END END AS [AUT13_R13_DATA_DEL_CESS],
			CASE convert(varchar(8),[auaru_dt_cessazione],112) WHEN '19000101' THEN null ELSE CASE convert(varchar(8),[auaru_dt_cessazione],112) WHEN '29991231' THEN null ELSE convert(varchar(8),[auaru_dt_cessazione],112) END END AS [AUT13_R13_DATA_EFF_CESS] ,
			
			[auaru_c_causale] AS [AUT13_R13_COD_CAU_CESS],
			[auaru_auulo_codice_pk]
	FROM #group_auvis WITH (READUNCOMMITTED)
	INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON ausca_codice_fiscale = group_auvis_cf
	INNER JOIN tb_auaru_arl_auulo WITH (READUNCOMMITTED) ON auaru_ausca_codice_pk = ausca_codice_pk
	INNER JOIN tb_auulo_unita_locale WITH (READUNCOMMITTED) ON auaru_auulo_codice_pk = auulo_codice_pk
	
END
