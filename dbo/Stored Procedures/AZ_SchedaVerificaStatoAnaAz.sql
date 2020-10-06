

-- ===============================================================================================
-- Author: Emanuela
-- Data:		2018.07.11
-- Descrizione:	AI3117 - Visualizza i campi della tabella tb_auvin
-- ===============================================================================================
CREATE PROCEDURE [dbo].[AZ_SchedaVerificaStatoAnaAz] 
	
	@codFisc varchar(16)
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT  [AUVIN_CODICE_PK]
      ,[AUVIN_CHIAVE_AUC]
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
      ,[AUVIN_I_CODICE_COMUNE_BELFIORE]
      ,[AUVIN_V_DENOMINAZIONE]
      ,[AUVIN_V_COGNOME]
      ,[AUVIN_V_NOME]
      ,[AUVIN_V_TOPONIMO]
      ,[AUVIN_V_INDIRIZZO]
      ,[AUVIN_V_CIVICO]
      ,[AUVIN_V_CAP]
      ,[AUVIN_V_COMUNE]
      ,[AUVIN_V_PROVINCIA]
      ,[AUVIN_V_CODICE_COMUNE_BELFIORE]
      ,[AUVIN_STATO_RECORD]
      ,CASE AUVIN_FONTE_VALIDAZIONE 
			WHEN   '01' THEN '01 - ANAGRAFE TRIBUTARIA' 
			WHEN   '02' THEN '02 - NORMALIZZATORE' 
			WHEN   '03' THEN '03 - ARCA' 
			WHEN   '04' THEN '04 - AGENDA SEDI' 
			WHEN   '05' THEN '05 - NORMALIZZATORE AUC' 
		END AS AUVIN_FONTE_VALIDAZIONE
      ,CASE AUVIN_MOTIVO_SCARTO 
			WHEN   '01' THEN '01 - COD. FISC. NON TROVATO' 
			WHEN   '02' THEN '02 - DATI INSUFFICIENTI' 
			WHEN   '03' THEN '03 - ERRORE NORMALIZZATORE' 
			WHEN   '04' THEN '04 - ERRORE DI SISTEMA' 
			WHEN   '05' THEN '05 - COMUNE NON TROVATO' 
			WHEN   '06' THEN '06 - COD. FISC. NON VALIDO' 
			WHEN   '07' THEN '07 - COD. BELFIORE NON TROVATO' 
		END AS AUVIN_MOTIVO_SCARTO
      ,[AUVIN_DATA_INSERIMENTO]
      ,[AUVIN_DATA_LAVORAZIONE]
      ,[AUVIN_LOTTO]
      /*,[AUVIN_STATO_AGGIORNAMENTO]
      ,[AUVIN_M_COGNOME]
      ,[AUVIN_M_NOME]
      ,[AUVIN_M_TOPONIMO]
      ,[AUVIN_M_INDIRIZZO]
      ,[AUVIN_M_CIVICO]
      ,[AUVIN_M_CAP]
      ,[AUVIN_M_COMUNE]
      ,[AUVIN_M_PROVINCIA]
      ,[AUVIN_M_CODICE_COMUNE_BELFIORE]
      ,[auvin_M_denominazione]
      ,[auvin_M_data_aggiornamento]*/
      ,[AUVIN_LAVORAZIONE_AUC]
      ,[AUVIN_DATA_LAVORAZIONE_AUC]
      ,[AUVIN_RICHIEDENTE]
  FROM [AUC].[dbo].[TB_AUVIN_VERIFICA_INDIRIZZO]
	WHERE 
		[AUVIN_CODICE_FISCALE]= @codfisc
END



