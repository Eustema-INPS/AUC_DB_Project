CREATE PROCEDURE [dbo].[SP_Osiride_TR14_1_Popola_per_0000] 
AS
BEGIN

	SET NOCOUNT ON;

	TRUNCATE TABLE TB_AUT14_OSIRIDE_TR14
	
	IF OBJECT_ID('tempdb..#group_auvis') IS NOT NULL	
		DROP TABLE #group_auvis;

	CREATE TABLE #group_auvis(	group_auvis_cf char(16),	group_auvis_data date	);
	
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
	
	INSERT INTO [dbo].[TB_AUT14_OSIRIDE_TR14]
			([AUT14_R14_TIPO]
			,[AUT14_R14_PROV_CCIAA]
			,[AUT14_R14_NUM_IREA]
			,[AUT14_R14_CODICE_FISCALE]
			,[AUT14_R14_PROGRESSIVO_UL]
			,[AUT14_R14_TIPO_RUOLO]
			,[AUT14_R14_FORMA_RUOLO]
			,[AUT14_R14_NUM_RUOLO]
			,[AUT14_R14_DATA_DOM_ISCRIZ]
			,[AUT14_R14_DATA_DELIBERA_ISCRIZ]
			,[AUT14_R14_DATA_INIZ_ATT]
			,[AUT14_R14_DATA_DOM_CESS]
			,[AUT14_R14_DATA_DELIBERA_CESS]
			,[AUT14_R14_DATA_EFF_CESS]
			,[AUT14_R14_COD_CAUSALE_CESS])
	SELECT
		'14' AS AUT14_R14_TIPO,
		ausca_cciaa AS AUT14_R14_PROV_CCIAA,
		right('000000000'+ausca_n_rea,9) As AUT14_R14_NUM_IREA,
		ausca_codice_fiscale AS AUT14_R14_CODICE_FISCALE,
		'0000' AS AUT14_R14_PROGRESSIVO_UL,
		'' AS [AUT14_R14_TIPO_RUOLO],
		'' AS [AUT14_R14_FORMA_RUOLO],
		SUBSTRING([ausca_art_num_iscrizione_ruolo],1,7) as [AUT14_R14_NUM_RUOLO],
		CASE WHEN (ausca_art_data_accertamento IS NOT NULL AND ausca_art_data_accertamento <> '2999-12-31') THEN CONVERT(VARCHAR(8),ausca_art_data_accertamento,112) 
			 WHEN (ausca_art_data_domanda IS NOT NULL AND ausca_art_data_domanda <> '2999-12-31') THEN CONVERT(VARCHAR(8),ausca_art_data_domanda,112)
			 WHEN (ausca_art_data_accertamento IS NULL OR ausca_art_data_accertamento = '2999-12-31') AND
				  (ausca_art_data_domanda IS NULL OR ausca_art_data_domanda = '2999-12-31') AND 
				  (ausca_art_data_domanda_accertamento IS NOT NULL AND ausca_art_data_domanda_accertamento <> '2999-12-31') THEN CONVERT(VARCHAR(8),ausca_art_data_domanda_accertamento,112)
			 ELSE '' END AS [AUT14_R14_DATA_DOM_ISCRIZ],
		CASE WHEN ([ausca_art_data_iscrizione] is not null and [ausca_art_data_iscrizione] <> '2999-12-31') then convert(varchar(8),[ausca_art_data_iscrizione],112)
			 WHEN ([ausca_art_data_delibera] is not null and [ausca_art_data_delibera] <> '2999-12-31') then convert(varchar(8),[ausca_art_data_delibera],112)
			 ELSE '' END AS [AUT14_R14_DATA_DELIBERA_ISCRIZ],
		CONVERT(VARCHAR(8),[ausca_art_data_iscrizione_inizio],112) as [AUT14_R14_DATA_INIZ_ATT], 
		CONVERT(VARCHAR(8),[ausca_art_data_domanda_accert_cess],112) as [AUT14_R14_DATA_DOM_CESS],
		CONVERT(VARCHAR(8),[ausca_art_data_delibera_cess],112) as [AUT14_R14_DATA_DELIBERA_CESS],
		CONVERT(VARCHAR(8),[ausca_art_data_cessazione],112)	as [AUT14_R14_DATA_EFF_CESS],
		[ausca_art_causale_cess] as [AUT14_R14_COD_CAUSALE_CESS]
	FROM #group_auvis WITH (READUNCOMMITTED) INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON 
		 ausca_codice_fiscale = group_auvis_cf;
		 
		 
	UPDATE TB_AUT14_OSIRIDE_TR14 
	SET AUT14_R14_TIPO_RUOLO  = auara_c_tipo,
		AUT14_R14_FORMA_RUOLO = CASE IsNull(tb_auara_arl_ausca.auara_c_forma,'XXX') WHEN 'XXX' THEN ' ' ELSE right(tb_auara_arl_ausca.auara_c_forma,1) END
	FROM TB_AUT14_OSIRIDE_TR14 
	INNER JOIN tb_ausca_sog_contr_az ON TB_AUT14_OSIRIDE_TR14.AUT14_R14_codice_fiscale = tb_ausca_sog_contr_az.ausca_codice_fiscale 
	INNER JOIN tb_auara_arl_ausca ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_auara_arl_ausca.auara_ausca_codice_pk ;	 
			 
END	
