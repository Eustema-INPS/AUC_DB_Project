
-- ===============================================================================================
-- Author:		Raffaele Palmieri
-- Create date: 10/06/2019
-- La Stored legge dalla Tabella [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO] i record che sono stati verificati su ARCA ed aggiorna Ausco.
-- ===============================================================================================
CREATE PROCEDURE [dbo].[SP_GESTIONE_RITORNO_ARCA_PER_AUSCO] 
	AS
BEGIN

	SET NOCOUNT ON;


-- Identifica i record da gestire relativi alle prime validazioni
	UPDATE [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO]
	SET AUIAS_LAVORAZIONE_AUC = '1' 
--select *
	FROM [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO]  INNER JOIN
						  tb_ausco_sog_contr_col ON [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO].AUIAS_CHIAVE_AUC = ausco_codice_pk
	WHERE    ( (AUIAS_STATO_RECORD = 'V') and AUIAS_provenienza = 'AUSCO' and AUIAS_LAVORAZIONE_AUC is null and ausco_stato_lavorazione_arca = 'IN') -- considera le prime validazioni


-- Identifica i record da gestire relativi agli aggiornamenti
		UPDATE top(1000000) [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO]
		SET AUIAS_LAVORAZIONE_AUC = '2' 
		FROM [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO]  INNER JOIN
							  tb_ausco_sog_contr_col ON [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO].AUIAS_CHIAVE_AUC = ausco_codice_pk
		WHERE                 
		( 
		(AUIAS_STATO_RECORD = 'V') and (AUIAS_STATO_AGGIORNAMENTO = '0') and AUIAS_provenienza = 'AUSCO' and AUIAS_LAVORAZIONE_AUC is not null and AUIAS_LAVORAZIONE_AUC = 'S' and ausco_stato_lavorazione_arca = 'IN'  
		) 
		 and ((AUIAS_DATA_AGGIORNAMENTO > ausco_data_lavorazione_arca) or ausco_data_lavorazione_arca is null)     -- considera gli aggiornamenti


		-- Storicizza i dati che saranno modificati prelevandoli dai dati inseriti su AUIAS perchè riferiti alla prima richiesta
		INSERT INTO [dbo].[TB_AUSSA_STORICO_SOGGETTO_ARCA]
				   ([AUSSA_CHIAVE_AUC]
				   ,[AUSSA_PROVENIENZA]
				   ,[AUSSA_CODICE_FISCALE]
		--           ,[AUSSA_CHIAVE_ARCA]
				   ,[AUSSA_DENOMINAZIONE]
				   ,[AUSSA_COGNOME]
				   ,[AUSSA_NOME]
				   ,[AUSSA_SESSO]
				   ,[AUSSA_FRAZIONE]
				   ,[AUSSA_TOPONIMO]
				   ,[AUSSA_INDIRIZZO]
				   ,[AUSSA_CIVICO]
				   ,[AUSSA_CAP]
				   ,[AUSSA_COMUNE]
				   ,[AUSSA_PROVINCIA]
				   ,[AUSSA_COD_COMUNE_BELF]
				   ,[AUSSA_DATA_NASCITA]
				   ,[AUSSA_DATA_MORTE]
				   ,[AUSSA_COMUNE_NASCITA]
				   ,[AUSSA_PROVINCIA_NASCITA]
				   ,[AUSSA_COD_COMUNE_BELF_NASCITA]
				   ,[AUSSA_COD_NAZIONE_BELF_NASCITA]
				   ,[AUSSA_SIGLA_NAZIONE_NASCITA]
				   ,[AUSSA_DESCR_NAZIONE_NASCITA]
				   ,[AUSSA_NAZIONALITA]
				   ,[AUSSA_TELEFONO]
				   ,[AUSSA_EMAIL]
				   ,[AUSSA_PEC]
				   ,[AUSSA_DESCR_UTENTE]
				   ,[AUSSA_DATA_MODIFICA]
				   ,[AUSSA_FONTE_VALIDAZIONE]
				   ,[AUSSA_MOTIVO_SCARTO]
				   ,[AUSSA_DATA_INSERIMENTO]
				   ,[AUSSA_DATA_LAVORAZIONE]
				   ,[AUSSA_LOTTO]
				   ,[AUSSA_DATA_LAVORAZIONE_AUC]
				   ,[AUSSA_RICHIEDENTE]
				   ,[AUSSA_LAVORAZIONE_AUC]
				   ,[AUSSA_AUIAS_CODICE_PK]
										  ,AUSSA_CfCcc1_Ev0_ARCA
										  ,AUSSA_Progr_Ev0_ARCA)

		SELECT
			   [AUIAS_CHIAVE_AUC]
			  ,[AUIAS_PROVENIENZA]
			  ,[AUIAS_CODICE_FISCALE]
			  ,[AUIAS_I_DENOMINAZIONE]
			  ,[AUIAS_I_COGNOME]
			  ,[AUIAS_I_NOME]
			  ,[AUIAS_I_SESSO]
			  ,[AUIAS_I_FRAZIONE]
			  ,[AUIAS_I_TOPONIMO]
			  ,[AUIAS_I_INDIRIZZO]
			  ,[AUIAS_I_CIVICO]
			  ,[AUIAS_I_CAP]
			  ,[AUIAS_I_COMUNE]
			  ,[AUIAS_I_PROVINCIA]
			  ,[AUIAS_I_COD_COMUNE_BELF]
			  ,[AUIAS_I_DATA_NASCITA]
			  ,[AUIAS_I_DATA_MORTE]
			  ,[AUIAS_I_COMUNE_NASCITA]
			  ,[AUIAS_I_PROVINCIA_NASCITA]
			  ,[AUIAS_I_COD_COMUNE_BELF_NASCITA]
			  ,[AUIAS_I_COD_NAZIONE_BELF_NASCITA]
			  ,[AUIAS_I_SIGLA_NAZIONE_NASCITA]
			  ,[AUIAS_I_DESCR_NAZIONE_NASCITA]
			  ,[AUIAS_I_NAZIONALITA]
			  ,[AUIAS_I_TELEFONO]
			  ,[AUIAS_I_EMAIL]
			  ,[AUIAS_I_PEC]
			  ,'AUIAS'
			  ,getdate()
			  ,[AUIAS_FONTE_VALIDAZIONE]
			  ,[AUIAS_MOTIVO_SCARTO]
			  ,[AUIAS_DATA_INSERIMENTO]
			  ,[AUIAS_DATA_LAVORAZIONE]
			  ,[AUIAS_LOTTO]
			  ,[AUIAS_DATA_LAVORAZIONE_AUC]
			  ,[AUIAS_RICHIEDENTE]
			  ,[AUIAS_LAVORAZIONE_AUC]
			  ,AUIAS_CODICE_PK
						  ,AUIAS_V_CfCcc1_Ev0_ARCA
						  ,AUIAS_V_Progr_Ev0_ARCA
		FROM [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO] 
		WHERE AUIAS_LAVORAZIONE_AUC = '1'

		-- Storicizza i dati che saranno modificati prelevandoli dai dati inseriti su AUSCO perchè riferiti alla prima richiesta (i dati forse sono stati modificati)
		-- oppure ad un aggiornamento

		INSERT INTO [dbo].[TB_AUSSA_STORICO_SOGGETTO_ARCA]
				   ([AUSSA_CHIAVE_AUC]
				   ,[AUSSA_PROVENIENZA]
				   ,[AUSSA_CODICE_FISCALE]
				   ,[AUSSA_CHIAVE_ARCA]
				   ,[AUSSA_DENOMINAZIONE]
				   ,[AUSSA_COGNOME]
				   ,[AUSSA_NOME]
				   ,[AUSSA_SESSO]
				   ,[AUSSA_FRAZIONE]
				   ,[AUSSA_TOPONIMO]
				   ,[AUSSA_INDIRIZZO]
				   ,[AUSSA_CIVICO]
				   ,[AUSSA_CAP]
				   ,[AUSSA_COMUNE]
				   ,[AUSSA_PROVINCIA]
				   ,[AUSSA_COD_COMUNE_BELF]
				   ,[AUSSA_DATA_NASCITA]
				   ,[AUSSA_DATA_MORTE]
				   ,[AUSSA_COMUNE_NASCITA]
				   ,[AUSSA_PROVINCIA_NASCITA]
				   ,[AUSSA_COD_COMUNE_BELF_NASCITA]
				   ,[AUSSA_COD_NAZIONE_BELF_NASCITA]
				   ,[AUSSA_SIGLA_NAZIONE_NASCITA]
				   ,[AUSSA_DESCR_NAZIONE_NASCITA]
				   ,[AUSSA_NAZIONALITA]
				   ,[AUSSA_TELEFONO]
				   ,[AUSSA_EMAIL]
				   ,[AUSSA_PEC]
				   ,[AUSSA_DESCR_UTENTE]
				   ,[AUSSA_DATA_MODIFICA]
				   ,[AUSSA_FONTE_VALIDAZIONE]
				   ,[AUSSA_MOTIVO_SCARTO]
				   ,[AUSSA_DATA_INSERIMENTO]
				   ,[AUSSA_DATA_LAVORAZIONE]
				   ,[AUSSA_LOTTO]
				   ,[AUSSA_DATA_LAVORAZIONE_AUC]
				   ,[AUSSA_RICHIEDENTE]
				   ,[AUSSA_LAVORAZIONE_AUC]
				   ,[AUSSA_AUIAS_CODICE_PK]
				  ,AUSSA_CfCcc1_Ev0_ARCA
				  ,AUSSA_Progr_Ev0_ARCA)
		SELECT
		[ausco_codice_pk]
		,'AUSCO'
		,[ausco_codice_fiscale]
		,ausco_chiave_arca 
		,[ausco_denominazione]
		,[ausco_cognome]
		,[ausco_nome]
		,[ausco_sesso]
		,[ausco_frazione]
		,[ausco_toponimo]
		,[ausco_indirizzo]
		,[ausco_civico]
		,[ausco_cap]
		,[ausco_localita]
		,[ausco_provincia]
		,ausco_cod_comune_belf 
		,[ausco_data_nascita]
		,[ausco_data_morte]
		,[ausco_comune_nascita]
		,[ausco_prov_nascita]
		,[ausco_codice_comune_nasc]
		,[ausco_codice_stato_estero]
		, substring( [ausco_sigla_nazione],1,3)
		,[ausco_descr_stato_nascita]
		,[ausco_cittadinanza]
		,[ausco_telefono]
		,[ausco_email]
		,[ausco_pec]
		,ausco_descr_utente
		,ausco_data_modifica
		,null
		,null
		,null
		,null
		,null
		,null
		,ausco_utente_richiesta_arca 
		,null
		,null
		,AUSCO_CfCcc1_Ev0_ARCA
		,AUSCo_Progr_Ev0_ARCA
		FROM [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO] 
		inner join tb_ausco_sog_contr_col ON [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO].AUIAS_CHIAVE_AUC = ausco_codice_pk
		WHERE AUIAS_LAVORAZIONE_AUC IN ('1','2')

		--Aggiorna i dati su AUSCo
		update tb_ausco_sog_contr_col
		set 
                    [ausco_denominazione] = ISNULL([AUIAS_V_DENOMINAZIONE],[ausco_denominazione]),
                    [ausco_cognome] = ISNULL([AUIAS_V_COGNOME],[ausco_cognome]),
                    [ausco_nome] = ISNULL([AUIAS_V_NOME],[ausco_nome]),
                    [ausco_sesso] = case when AUIAS_V_SESSO = '1' then 'M'
										 when AUIAS_V_SESSO = '2' then 'F'
										 else ISNULL([AUIAS_V_SESSO],[ausco_sesso]) end,
                    [ausco_frazione] = ISNULL([AUIAS_V_FRAZIONE],[ausco_frazione]),
                    [ausco_toponimo] = ISNULL([AUIAS_V_TOPONIMO],[ausco_toponimo]),
                    [ausco_indirizzo] = ISNULL([AUIAS_V_INDIRIZZO],[ausco_indirizzo]),
                    [ausco_civico] = ISNULL([AUIAS_V_CIVICO],[ausco_civico]),
                    [ausco_cap] = SUBSTRING(ISNULL([AUIAS_V_CAP],[ausco_cap]),1,5),
                    [ausco_localita] = ISNULL([AUIAS_V_COMUNE],[ausco_localita]),
                    [ausco_provincia] = SUBSTRING(ISNULL([AUIAS_V_PROVINCIA],[ausco_provincia]),1,2),
                    ausco_cod_comune_belf  = ISNULL([AUIAS_V_COD_COMUNE_BELF],ausco_cod_comune_belf ),
                    [ausco_data_nascita] = ISNULL([AUIAS_V_DATA_NASCITA],[ausco_data_nascita]),
                    [ausco_data_morte] = ISNULL([AUIAS_V_DATA_MORTE],[ausco_data_morte]),
                    [ausco_comune_nascita] = ISNULL([AUIAS_V_COMUNE_NASCITA],[ausco_comune_nascita]),
                    [ausco_prov_nascita] = SUBSTRING(ISNULL([AUIAS_V_PROVINCIA_NASCITA],[ausco_prov_nascita]),1,2),
                    [ausco_codice_comune_nasc] = ISNULL([AUIAS_V_COD_COMUNE_BELF_NASCITA],[ausco_codice_comune_nasc]),
                    [ausco_codice_stato_estero] = ISNULL([AUIAS_V_COD_NAZIONE_BELF_NASCITA],[ausco_codice_stato_estero]),
                    [ausco_sigla_nazione] = substring(ISNULL([AUIAS_V_SIGLA_NAZIONE_NASCITA],[ausco_sigla_nazione]),1,3),
                    [ausco_descr_stato_nascita] = ISNULL([AUIAS_V_DESCR_NAZIONE_NASCITA],[ausco_descr_stato_nascita]),
                    [ausco_cittadinanza] = ISNULL([AUIAS_V_NAZIONALITA],[ausco_cittadinanza]),
                    [ausco_telefono] = ISNULL([AUIAS_V_TELEFONO],[ausco_telefono]),
                    [ausco_email] = ISNULL([AUIAS_V_EMAIL],[ausco_email]),
                    [ausco_pec] = ISNULL([AUIAS_V_PEC],[ausco_pec]),
                    ausco_descr_utente = 'Agg. da ARCA',
                    ausco_data_modifica = getdate(),
                    ausco_certificato_AT  = case when AUIAS_FONTE_VALIDAZIONE = '01' then 'S' end,
                    ausco_data_agg_AT = case when AUIAS_FONTE_VALIDAZIONE = '01' then AUIAS_DATA_LAVORAZIONE end,
                    [ausco_certificato_arca] = case when AUIAS_FONTE_VALIDAZIONE = '03' then 'S' end,
                    [ausco_data_lavorazione_arca] = case when AUIAS_FONTE_VALIDAZIONE = '03' then AUIAS_DATA_LAVORAZIONE end,
                    ausco_utente_richiesta_arca  = ISNULL([AUIAS_RICHIEDENTE],ausco_utente_richiesta_arca ),
                    ausco_esito_lavorazione_arca = case when AUIAS_FONTE_VALIDAZIONE = '01' then 'Cert AT'
                                                        when AUIAS_FONTE_VALIDAZIONE = '03' then 'Cert ARCA'
                                                        when AUIAS_MOTIVO_SCARTO = '01' then 'Scart AT'
                                                        when AUIAS_MOTIVO_SCARTO = '06' then 'Scart ARCA' end,
                    AUSCO_CfCcc1_Ev0_ARCA = ISNULL(AUIAS_V_CfCcc1_Ev0_ARCA, AUSCO_CfCcc1_Ev0_ARCA),
                    AUSCo_Progr_Ev0_ARCA = ISNULL(AUIAS_V_Progr_Ev0_ARCA, AUSCo_Progr_Ev0_ARCA)

		from tb_ausco_sog_contr_col inner join [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO] on ausco_codice_pk = auias_chiave_AUC
		where (AUIAS_LAVORAZIONE_AUC = '1' or AUIAS_LAVORAZIONE_AUC = '2')  and auias_provenienza = 'AUSCO'

		-- Chiude la lavorazione
		update [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO]
		set AUIAS_STATO_AGGIORNAMENTO = '1'
		where (AUIAS_LAVORAZIONE_AUC = '2') and AUIAS_PROVENIENZA = 'AUSCO'

		update [TB_AUIAS_INTERFACCIA_ARCA_SOGGETTO]
		set AUIAS_LAVORAZIONE_AUC = 'S',
						AUIAS_DATA_LAVORAZIONE_AUC = getdate()
		where (AUIAS_LAVORAZIONE_AUC = '1' OR AUIAS_LAVORAZIONE_AUC = '2')  and AUIAS_PROVENIENZA = 'AUSCO'


	IF @@ERROR = 0 	RETURN 0 ELSE RETURN 100

END

