CREATE PROCEDURE [dbo].[SP_Osiride_TR08_1_Gestione]
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
		
	TRUNCATE TABLE TB_AUT08_OSIRIDE_TR08;
	
	INSERT INTO [dbo].[TB_AUT08_OSIRIDE_TR08]
           ([AUT08_R8_TIPO]
           ,[AUT08_R8_PROV_CCIAA]
           ,[AUT08_R8_NUM_IREA]
           ,[AUT08_R8_CODICE_FISCALE]
           ,[AUT08_R8_COD_LIQUI]
           ,[AUT08_R8_DATA_LIQ_APER]
           ,[AUT08_R8_DATA_LIQ_FINE]
           ,[AUT08_R8_DATA_LIQ_REVO]
           ,[AUT08_R8_DATA_LIQ_CHIU]
           ,[AUT08_R8_COD_ATTO]
           ,[AUT08_R8IND_ESEC_ATTO]
           ,[AUT08_R8_DESCR_NOTAIO]
           ,[AUT08_R8_DESCR_TRIBUNALE]
           ,[AUT08_R8_DESCR_ALTERNATIVA]
           ,[AUT08_R8_NUM_REGIST_ATTO]
           ,[AUT08_R8_DATA_REGIST_ATTO]
           ,[AUT08_R8_LOC_REGIST_ATTO]
           ,[AUT08_R8_PR_REGIST_ATTO]
           ,[AUT08_R8_DATA_ESECU_CON_PREV]
           ,[AUT08_R8_FILLER])
	SELECT  
		'08' as AUT08_R8_TIPO,
		ausca_cciaa as AUT08_R8_PROV_CCIAA,
		Right('000000000'+ausca_n_rea,9) As AUT08_R8_NUM_IREA,
		ausca_codice_fiscale as [AUT08_R8_CODICE_FISCALE],
		aucon_codice_liquidazione as AUT08_R8_COD_LIQUI,
		convert(varchar(8),[aucon_data_iscrizione_procedura],112) as [AUT08_R8_DATA_LIQ_APER],
		convert(varchar(8),[aucon_data_termine],112) as [AUT08_R8_DATA_LIQ_FINE],
		convert(varchar(8),[aucon_data_revoca],112) as [AUT08_R8_DATA_LIQ_REVO],
		convert(varchar(8),[aucon_data_chiusura],112) as [AUT08_R8_DATA_LIQ_CHIU],
		substring(aucon_codice_atto,1,2) as [AUT08_R8_COD_ATTO],
		case  when ((aucon_notaio is not null) and (rtrim(ltrim(aucon_notaio)) <> '')) then 'N'
		else 
			(case when ((aucon_tribunale is not null) and (rtrim(ltrim(aucon_tribunale)) <> ''))  then 'T' 
			else '' end)
		end as [AUT08_R8IND_ESEC_ATTO],
		substring(aucon_notaio, 1, 40) as [AUT08_R8_DESCR_NOTAIO],
		substring(aucon_tribunale, 1, 40) as [AUT08_R8_DESCR_TRIBUNALE],
		aucon_altre_indicazioni as [AUT08_R8_DESCR_ALTERNATIVA],
		substring(aucon_num_registrazione,1,15) as [AUT08_R8_NUM_REGIST_ATTO],
		convert(varchar(8),[aucon_data_registrazione],112) as [AUT08_R8_DATA_REGIST_ATTO],
		substring(aucon_localita_uff_registro,1,30) as [AUT08_R8_LOC_REGIST_ATTO],
		aucon_prov_uff_registro as [AUT08_R8_PR_REGIST_ATTO],
		convert(varchar(8),[aucon_data_esecuzione],112) as [AUT08_R8_DATA_ESECU_CON_PREV],
		Space(1268) As [AUT08_R8_FILLER]		
		FROM #group_auvis WITH (READUNCOMMITTED) INNER JOIN tb_ausca_sog_contr_az WITH (READUNCOMMITTED) ON 
			 ausca_codice_fiscale = group_auvis_cf INNER JOIN tb_aucon_concorsuale WITH (READUNCOMMITTED) ON 
			 aucon_ausca_codice_pk = ausca_codice_pk
		--where aucon_codice_liquidazione is not null and rtrim(ltrim(aucon_codice_liquidazione)) <> '' ----VERIFICARE
END

