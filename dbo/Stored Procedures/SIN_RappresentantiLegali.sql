
CREATE PROCEDURE [dbo].[SIN_RappresentantiLegali] AS
BEGIN
	BEGIN TRY

		DECLARE @ausco_storico TABLE (
			ausco_codice_pk INT NULL,
			ausco_codice_fiscale VARCHAR(16) NULL,
			ausco_denominazione VARCHAR(405) NULL,
			ausco_cognome VARCHAR(255) NULL,
			ausco_nome VARCHAR(150) NULL,
			ausco_sesso VARCHAR(1) NULL,
			ausco_cittadinanza VARCHAR(4) NULL,
			ausco_comune_nascita VARCHAR(50) NULL,
			ausco_data_nascita DATETIME NULL,
			ausco_prov_nascita VARCHAR(2) NULL,
			ausco_stato_estero_nascita VARCHAR(4) NULL,
			ausco_tipo_persona VARCHAR(1) NULL,
			ausco_codice_qualita_ind VARCHAR(1) NULL,
			ausco_codice_toponimo VARCHAR(3) NULL,
			ausco_toponimo VARCHAR(100) NULL,
			ausco_frazione VARCHAR(100) NULL,
			ausco_localita VARCHAR(50) NULL,
			ausco_indirizzo VARCHAR(100) NULL,
			ausco_civico VARCHAR(50) NULL,
			ausco_cap VARCHAR(5) NULL,
			ausco_codice_comune_istat VARCHAR(6) NULL,
			ausco_codice_comune VARCHAR(4) NULL,
			ausco_provincia VARCHAR(2) NULL,
			ausco_sigla_nazione VARCHAR(10) NULL,
			ausco_codice_stato_estero VARCHAR(4) NULL,
			ausco_telefono VARCHAR(20) NULL,
			ausco_telefono2 VARCHAR(20) NULL,
			ausco_fax VARCHAR(20) NULL,
			ausco_email VARCHAR(162) NULL,
			ausco_pec VARCHAR(162) NULL,
			ausco_legalmail VARCHAR(162) NULL,
			ausco_note VARCHAR(200) NULL,
			ausco_data_modifica DATETIME NULL,
			ausco_descr_utente VARCHAR(50) NULL,
			ausco_codice_pk_db2 INT NULL,
			ausco_cert_auten_cod_pk INT NULL,
			ausco_cert_cod_entita_rif INT NULL,
			ausco_cert_data_modifica DATETIME NULL,
			ausco_codice_comune_nasc VARCHAR(4) NULL,
			ausco_descr_cittadinanza VARCHAR(50) NULL,
			ausco_descr_stato_nascita VARCHAR(100) NULL,
			ausco_certificato_arca CHAR(1) NULL,
			ausco_data_agg_arca DATETIME NULL,
			ausco_data_morte DATETIME NULL,
			ausco_ind_qualita_indir INT NULL,
			ausco_aurea_codice_pk INT NULL,
			ausco_data_inizio_AC DATETIME NULL,
			ausco_data_fine_AC DATETIME NULL,
			ausco_rec_del VARCHAR(1) NULL,
			ausco_data_del DATETIME NULL,
			ausco_residenza_frazione VARCHAR(25) NULL,
			ausco_residenza_altre_indic VARCHAR(30) NULL,
			ausco_codice_comune_nascita VARCHAR(5) NULL,
			ausco_residenza_codice_comune VARCHAR(5) NULL,
			ausco_residenza_codice_stato VARCHAR(3) NULL,
			ausco_cf_arca VARCHAR(16) NULL,
			ausco_chiave_arca INT NULL,
			ausco_cod_comune_belf VARCHAR(4) NULL,
			ausco_codice_stato_estero_nasc VARCHAR(4) NULL,
			ausco_certificato_AT CHAR(1) NULL,
			ausco_data_agg_AT DATETIME NULL,
			ausco_richiesta_verifica_arca CHAR(1) NULL,
			ausco_data_richiesta_arca DATETIME NULL,
			ausco_utente_richiesta_arca VARCHAR(50) NULL,
			ausco_stato_lavorazione_arca VARCHAR(10) NULL,
			ausco_data_lavorazione_arca DATETIME NULL,
			Ausco_CfCcc1_Ev0_ARCA VARCHAR(3) NULL,
			Ausco_Progr_Ev0_ARCA INT NULL,
			ausco_esito_lavorazione_arca VARCHAR(10) NULL
		);

		BEGIN TRAN;

			-- Popolamento ausco
			MERGE dbo.tb_ausco_sog_contr_col AS target
			USING (
				SELECT 
					T.BDRL_CODFISC_PF								AS ausco_codice_fiscale,
					BDRA_COGNOME									AS ausco_cognome,
					BDRA_NOME										AS ausco_nome,
					BDRA_SESSO										AS ausco_sesso,
					BDRA_DATA_NASCITA								AS ausco_data_nascita,
					SUBSTRING(BDRA_COMUNE_NASCITA, 1, 50)			AS ausco_comune_nascita,
					SUBSTRING(BDRA_PROVINCIA_NASCITA, 1, 2)			AS ausco_prov_nascita,
					BDRA_STATO_NASCITA								AS ausco_descr_stato_nascita,
					BDRA_CITTADINANZA								AS ausco_descr_cittadinanza,
					BDRA_STATO_CIVILE,								-- ?
					BDRA_NAZIONALITA								AS ausco_cittadinanza,
					BDRA_RESIDENZA,									-- ?
					SUBSTRING(BDRA_COMUNE_RESIDENZA, 1, 5)			AS ausco_residenza_codice_comune,
					SUBSTRING(BDRA_PROVINCIA_RESIDENZA, 1, 2)		AS ausco_provincia,
					SUBSTRING(BDRA_FRAZIONE_RESIDENZA, 1, 25)		AS ausco_residenza_frazione,
					SUBSTRING(BDRA_CAP_RESIDENZA, 1, 5)				AS ausco_cap,
					SUBSTRING(BDRA_INDIRIZZO_RESIDENZA, 1, 100)		AS ausco_indirizzo,
					BDRA_NUMERO_CIVICO_RESIDENZA					AS ausco_civico,
					BDRA_EMAIL_CEC_PAC,								-- ?
					SUBSTRING(BDRA_EMAIL_PEC, 1, 162)				AS ausco_pec,
					SUBSTRING(BDRA_EMAIL, 1, 162)					AS ausco_email,
					SUBSTRING(BDRA_TELEFONO_FISSO, 1, 20)			AS ausco_telefono,
					SUBSTRING(BDRA_TELEFONO_MOBILE, 1, 20)			AS ausco_telefono2,
					SUBSTRING(BDRA_TELEFONO_FAX, 1, 20)				AS ausco_fax,
					BDRA_ESITO_ARCA,
					'F'												AS ausco_tipo_persona,
					SUBSTRING(BDRA_COMUNE_RESIDENZA,1,50)			AS ausco_localita,
					'Proveniente da SIN'							AS ausco_note,
					BDRA_MODREC										AS ausco_data_modifica,
					3												AS ausco_cert_auten_cod_pk,
					1												AS ausco_cert_cod_entita_rif,	-- 6 as Applicazione_LD
					3												AS ausco_aurea_codice_pk		-- ?
				FROM (
					SELECT R.BDRL_CODFISC_PF, A.*, ROW_NUMBER() OVER (PARTITION BY R.BDRL_CODFISC_PF ORDER BY A.BDRA_MODREC DESC) AS riga
					FROM dbo.BDRA_RAPANAG_CL A
					JOIN dbo.BDRL_RAPLEG_CL R
						ON R.BDRL_BDRA_ID_VA = A.BDRA_ID_VA
					JOIN (
						SELECT BDSO_CODFISC_VB, BDSO_BDTS_APP_VR 
						FROM dbo.BDSO_SOCIETA_CL 
						WHERE CAST(GETDATE() AS DATE) BETWEEN BDSO_DATAINI_VB AND ISNULL(BDSO_DATAFIN_VB, '2099-12-31')
						GROUP BY BDSO_CODFISC_VB, BDSO_BDTS_APP_VR
					) SOC
						ON SOC.BDSO_CODFISC_VB = R.BDRL_CODFISC_PG
					JOIN dbo.BDTS_TIPOSOC_CT TS
						ON TS.BDTS_ID_VA = SOC.BDSO_BDTS_APP_VR
					WHERE TS.BDTS_CODICE_VB IN ('010', '014', '016', 'ESS', 'EPN', 'ISS', 'AFA', 'ERI', 'EAI', 'UNI')
					) T
				WHERE T.riga = 1
			) AS source
				ON source.ausco_codice_fiscale = target.ausco_codice_fiscale
			WHEN NOT MATCHED THEN 
				INSERT (
					ausco_codice_fiscale,
					ausco_cognome,
					ausco_nome,
					ausco_sesso,
					ausco_data_nascita,
					ausco_comune_nascita,
					ausco_prov_nascita,
					ausco_descr_stato_nascita,
					ausco_descr_cittadinanza,
					ausco_cittadinanza,
					ausco_residenza_codice_comune,
					ausco_provincia,
					ausco_residenza_frazione,
					ausco_cap,
					ausco_indirizzo,
					ausco_civico,
					ausco_pec,
					ausco_email,
					ausco_telefono,
					ausco_telefono2,
					ausco_fax,
					ausco_tipo_persona,
					ausco_localita,
					ausco_note,
					ausco_data_modifica,
					ausco_cert_auten_cod_pk,
					ausco_cert_cod_entita_rif,
					ausco_aurea_codice_pk
				)
				VALUES (
					source.ausco_codice_fiscale,
					source.ausco_cognome,
					source.ausco_nome,
					source.ausco_sesso,
					source.ausco_data_nascita,
					source.ausco_comune_nascita,
					source.ausco_prov_nascita,
					source.ausco_descr_stato_nascita,
					source.ausco_descr_cittadinanza,
					source.ausco_cittadinanza,
					source.ausco_residenza_codice_comune,
					source.ausco_provincia,
					source.ausco_residenza_frazione,
					source.ausco_cap,
					source.ausco_indirizzo,
					source.ausco_civico,
					source.ausco_pec,
					source.ausco_email,
					source.ausco_telefono,
					source.ausco_telefono2,
					source.ausco_fax,
					source.ausco_tipo_persona,
					source.ausco_localita,
					source.ausco_note,
					source.ausco_data_modifica,
					source.ausco_cert_auten_cod_pk,
					source.ausco_cert_cod_entita_rif,
					source.ausco_aurea_codice_pk
				)
			WHEN MATCHED AND source.ausco_data_modifica > target.ausco_data_modifica THEN
				UPDATE SET
					target.ausco_cognome					= source.ausco_cognome,
					target.ausco_nome						= source.ausco_nome,
					target.ausco_sesso						= ISNULL(source.ausco_sesso, target.ausco_sesso),
					target.ausco_data_nascita				= ISNULL(source.ausco_data_nascita, target.ausco_data_nascita),
					target.ausco_comune_nascita				= ISNULL(source.ausco_comune_nascita, target.ausco_comune_nascita),
					target.ausco_prov_nascita				= ISNULL(source.ausco_prov_nascita, target.ausco_prov_nascita),
					target.ausco_descr_stato_nascita		= ISNULL(source.ausco_descr_stato_nascita, target.ausco_descr_stato_nascita),
					target.ausco_descr_cittadinanza			= ISNULL(source.ausco_descr_cittadinanza, target.ausco_descr_cittadinanza),
					target.ausco_cittadinanza				= ISNULL(source.ausco_cittadinanza, target.ausco_cittadinanza),
					target.ausco_residenza_codice_comune	= ISNULL(source.ausco_residenza_codice_comune, target.ausco_residenza_codice_comune),
					target.ausco_provincia					= ISNULL(source.ausco_provincia, target.ausco_provincia),
					target.ausco_residenza_frazione			= ISNULL(source.ausco_residenza_frazione, target.ausco_residenza_frazione),
					target.ausco_cap						= ISNULL(source.ausco_cap, target.ausco_cap),
					target.ausco_indirizzo					= ISNULL(source.ausco_indirizzo, target.ausco_indirizzo),
					target.ausco_civico						= ISNULL(source.ausco_civico, target.ausco_civico),
					target.ausco_pec						= ISNULL(source.ausco_pec, target.ausco_pec),
					target.ausco_email						= ISNULL(source.ausco_email, target.ausco_email),
					target.ausco_telefono					= ISNULL(source.ausco_telefono, target.ausco_telefono),
					target.ausco_telefono2					= ISNULL(source.ausco_telefono2, target.ausco_telefono2),
					target.ausco_fax						= ISNULL(source.ausco_fax, target.ausco_fax),
					target.ausco_tipo_persona				= source.ausco_tipo_persona,
					target.ausco_localita					= ISNULL(source.ausco_localita, target.ausco_localita),
					target.ausco_note						= source.ausco_note,
					target.ausco_data_modifica				= source.ausco_data_modifica,
					target.ausco_cert_auten_cod_pk			= source.ausco_cert_auten_cod_pk,
					target.ausco_cert_cod_entita_rif		= source.ausco_cert_cod_entita_rif,
					target.ausco_aurea_codice_pk			= source.ausco_aurea_codice_pk
			OUTPUT Deleted.* INTO @ausco_storico
			;

			-- Popola storico ausco con le sole update
			INSERT INTO dbo.tb_ausco_sog_contr_col_storico
			SELECT * FROM @ausco_storico WHERE ausco_codice_pk IS NOT NULL;

			-- Popolamento aurss
			MERGE dbo.tb_aurss_rel_sog_sog AS target
			USING (
				SELECT 
					A.ausca_codice_pk,
					O.ausco_codice_pk,
					1														AS StatoSoggetto,
					T.autis_codice_pk										AS TipoSoggetto,
					R.BDRL_DATA_INIZIO										AS DataInizio,
					ISNULL(R.BDRL_DATA_FINE, '2999-12-31')					AS DataFine,
					'Proveniente da SIN (IPA)'								AS Note,
					'S'														AS RappLegale,
					R.BDRL_MODREC											AS DataModifica,
					'SSIS-SIN'												AS DescrUtente,
					3														AS tipoEntita,
					1														AS Applicazione_LD,
					T.autis_codice_carica									AS CodiceCarica,
					'SIN'													AS provenienza
				FROM
				(
					SELECT *
					FROM
					(
						SELECT RA.BDRL_CODFISC_PG,
							   RA.BDRL_CODFISC_PF,
							   RA.BDRL_DATA_INIZIO,
							   RA.BDRL_DATA_FINE,
							   RA.BDRL_TIPOLOGIA,
							   RA.BDRL_MODREC,
							   ROW_NUMBER() OVER (PARTITION BY RA.BDRL_CODFISC_PG,
															   RA.BDRL_CODFISC_PF,
															   RA.BDRL_TIPOLOGIA
												  ORDER BY RA.BDRL_MODREC DESC
												 ) AS riga
						FROM dbo.BDRL_RAPLEG_CL RA
						JOIN (
							SELECT BDSO_CODFISC_VB, BDSO_BDTS_APP_VR 
							FROM dbo.BDSO_SOCIETA_CL 
							WHERE CAST(GETDATE() AS DATE) BETWEEN BDSO_DATAINI_VB AND ISNULL(BDSO_DATAFIN_VB, '2099-12-31')
							GROUP BY BDSO_CODFISC_VB, BDSO_BDTS_APP_VR
						) SOC
							ON SOC.BDSO_CODFISC_VB = RA.BDRL_CODFISC_PG
						JOIN dbo.BDTS_TIPOSOC_CT TS
							ON TS.BDTS_ID_VA = SOC.BDSO_BDTS_APP_VR
						WHERE TS.BDTS_CODICE_VB IN ('010', '014', '016', 'ESS', 'EPN', 'ISS', 'AFA', 'ERI', 'EAI', 'UNI')
					) T
					WHERE T.riga = 1
				)	R
					JOIN dbo.tb_ausca_sog_contr_az  A
						ON R.BDRL_CODFISC_PG = A.ausca_codice_fiscale
					JOIN dbo.tb_ausco_sog_contr_col O
						ON R.BDRL_CODFISC_PF = O.ausco_codice_fiscale
					JOIN dbo.tb_autis_tipo_sog_col_ct T
						ON T.autis_descr = (CASE WHEN R.BDRL_TIPOLOGIA = 'RAPPRESENTANTE LEGALE' THEN 'LEGALE RAPPRESENTANTE' ELSE R.BDRL_TIPOLOGIA END)
			) AS source
				ON 
					source.ausca_codice_pk	= target.aurss_ausca_codice_pk
				AND source.ausco_codice_pk	= target.aurss_ausco_codice_pk
				AND source.tipoEntita		= target.aurss_auten_codice_pk
				AND source.Applicazione_LD	= target.aurss_codice_entita_rif
				AND source.TipoSoggetto		= target.aurss_autis_codice_pk
			WHEN NOT MATCHED THEN 
				INSERT (
				   aurss_ausca_codice_pk
				  ,aurss_ausco_codice_pk
				  ,aurss_aussu_codice_pk
				  ,aurss_autis_codice_pk
				  ,aurss_data_inizio_validita
				  ,aurss_data_di_fine_validita
				  ,aurss_note
				  ,aurss_rappresentante_legale
				  ,aurss_data_modifica
				  ,aurss_descr_utente
				  ,aurss_auten_codice_pk
				  ,aurss_codice_entita_rif
				  ,aurss_codice_carica
				  ,aurss_provenienza 
				)
				 VALUES ( 
					source.ausca_codice_pk,
					source.ausco_codice_pk,
					source.StatoSoggetto,
					source.TipoSoggetto,
					source.DataInizio,
					source.DataFine,
					source.Note,
					source.RappLegale,
					source.DataModifica,
					source.DescrUtente,
					source.tipoEntita,
					source.Applicazione_LD,
					source.CodiceCarica,
					source.provenienza
				)
			WHEN MATCHED AND source.DataModifica > target.aurss_data_modifica THEN 
				UPDATE SET 
					target.aurss_data_inizio_validita	= source.DataInizio,
					target.aurss_data_di_fine_validita	= source.DataFine,
					target.aurss_note					= source.Note,
					target.aurss_rappresentante_legale	= source.RappLegale,
					target.aurss_data_modifica			= source.DataModifica,
					target.aurss_descr_utente			= source.DescrUtente,
					target.aurss_codice_carica			= source.CodiceCarica,
					target.aurss_provenienza 			= source.provenienza;

			INSERT INTO tb_aulog_log (aulog_tipo_contesto, aulog_nome_attore, aulog_data_log, aulog_descr_breve, aulog_descr_lunga)
			VALUES ('B', 'SIN_RappresentantiLegali', GETDATE(), 'SP - SIN - Rappresentanti Legali', 'SP - SIN - Rappresentanti Legali - Terminata correttamente.');

		COMMIT;

	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0	ROLLBACK TRAN;

		DECLARE	@Message VARCHAR(MAX);
		SELECT	@Message = ERROR_MESSAGE();

		INSERT INTO tb_aulog_log (aulog_tipo_contesto, aulog_nome_attore, aulog_data_log, aulog_descr_breve, aulog_descr_lunga, AULOG_DESCRMAX)
		VALUES ('B', 'SIN_RappresentantiLegali', GETDATE(), 'SP - SIN - Rappresentanti Legali', SUBSTRING(@Message, 1, 200), SUBSTRING(@Message, 1, 800));

	END CATCH
END
