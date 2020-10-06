


CREATE PROCEDURE [dbo].[SP_BELF_INS_TOTALI]
AS
BEGIN
	SET NOCOUNT ON;


	-- Inserisce le richieste di validazione
	INSERT INTO [dbo].[TB_AUVIN_VERIFICA_INDIRIZZO]
			   ([AUVIN_CHIAVE_AUC]
			   ,[AUVIN_PROVENIENZA]
			   ,[AUVIN_CODICE_FISCALE]
			   ,[AUVIN_I_DENOMINAZIONE]
			   ,[AUVIN_I_COGNOME]
			   ,[AUVIN_I_NOME]
			   ,[AUVIN_I_TOPONIMO]
			   ,[AUVIN_I_INDIRIZZO]
			   ,[AUVIN_I_CIVICO]
			   ,[AUVIN_I_CAP]
			   ,[AUVIN_I_COMUNE]
			   ,[AUVIN_I_PROVINCIA]
			   ,[AUVIN_I_CODICE_COMUNE_BELFIORE])
	SELECT  ausca_codice_pk, 'AUSCA', ausca_codice_fiscale, ausca_denominazione, ausca_cognome, ausca_nome, 
		ausca_toponimo, ausca_indirizzo, ausca_civico, substring(ausca_cap,1,5), ausca_descr_comune, ausca_sigla_provincia, ausca_cod_com_Belfiore
		from tb_ausca_sog_contr_az
	where	ausca_cod_com_Belfiore is null and ausca_codice_pk > 2 and ausca_fonte_validazione_anagrafica is null and ausca_data_validazione_anagrafica is null

	-- Elimina le eventuali richieste di validazione, non ancora soddisfatte, duplicate.
	DELETE T1 FROM
	--SELECT *  FROM
	(
		SELECT
			ROW_NUMBER() OVER
			(
				PARTITION BY	auvin_chiave_auc ,
						auvin_provenienza , auvin_stato_record, [AUVIN_FONTE_VALIDAZIONE]
				ORDER BY auvin_chiave_auc 
			)  As RowNumber
			,auvin_chiave_auc 
			, auvin_provenienza 
			, auvin_stato_record
			,[AUVIN_FONTE_VALIDAZIONE]

		FROM [TB_AUVIN_VERIFICA_INDIRIZZO]
	) AS T1
	WHERE RowNumber > 1 AND auvin_stato_record = 'I' and [AUVIN_FONTE_VALIDAZIONE] is null

	-- Inserimento righe di conteggio delle precedenti eleaborazioni
	INSERT INTO [dbo].[TB_AUQDA_QTA_DATI_AGGIORNABILI]
			   ([AUQDA_TIPO]
			   ,[AUQDA_PROVENIENZA]
			   ,[AUQDA_DATA_RIFERIMENTO]
			   ,[AUQDA_LOTTO]
			   ,[AUQDA_STATO_RECORD]
			   ,[AUQDA_QUANTITA]
			   ,auqda_fonte_validazione
			   ,auqda_motivo_scarto
			   )
	SELECT 1 --attività per codice belfiore
		  ,[AUVIN_PROVENIENZA]
		  ,[AUVIN_DATA_INSERIMENTO]
		  ,auvin_lotto --al momento lotto di default
		  ,[AUVIN_STATO_RECORD]
		  ,count(*)
		  ,auvin_fonte_validazione
		  ,auvin_motivo_scarto
	  FROM [AUC].[dbo].[TB_AUVIN_VERIFICA_INDIRIZZO]
	  group by [AUVIN_PROVENIENZA], [AUVIN_DATA_INSERIMENTO], auvin_lotto, [AUVIN_STATO_RECORD],auvin_fonte_validazione
		  ,auvin_motivo_scarto



END
