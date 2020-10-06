






-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/07/2018
-- Description:		Elenco dati Tabella   TB_AUSSI_STORICO_INDIRIZZO
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_StoricoIndirizzi]
@prov varchar(16),
@cod  varchar(20) --as int


AS
BEGIN


	SET NOCOUNT ON;                       

	select AUSSI_CODICE_PK, AUSSI_CHIAVE_AUC, AUSSI_PROVENIENZA, AUSSI_CODICE_FISCALE, AUSSI_DENOMINAZIONE, AUSSI_COGNOME, AUSSI_NOME, AUSSI_TOPONIMO, AUSSI_INDIRIZZO, AUSSI_CIVICO, AUSSI_CAP, AUSSI_COMUNE, AUSSI_PROVINCIA, 
		CASE AUSSI_FONTE_VALIDAZIONE 
			WHEN   '01' THEN '01 - ANAGRAFE TRIBUTARIA' 
			WHEN   '02' THEN '02 - NORMALIZZATORE' 
			WHEN   '03' THEN '03 - ARCA' 
			WHEN   '04' THEN '04 - AGENDA SEDI' 
			WHEN   '05' THEN '05 - NORMALIZZATORE AUC' 
		END AS AUSSI_FONTE_VALIDAZIONE, 
		CASE AUSSI_MOTIVO_SCARTO 
			WHEN   '01' THEN '01 - COD. FISC. NON TROVATO' 
			WHEN   '02' THEN '02 - DATI INSUFFICIENTI' 
			WHEN   '03' THEN '03 - ERRORE NORMALIZZATORE' 
			WHEN   '04' THEN '04 - ERRORE DI SISTEMA' 
			WHEN   '05' THEN '05 - COMUNE NON TROVATO' 
			WHEN   '06' THEN '06 - COD. FISC. NON VALIDO' 
			WHEN   '07' THEN '07 - COD. BELFIORE NON TROVATO' 
		END AS AUSSI_MOTIVO_SCARTO, 
		AUSSI_DATA_INSERIMENTO,AUSSI_DATA_LAVORAZIONE, AUSSI_LOTTO, AUSSI_DATA_LAVORAZIONE_AUC, AUSSI_RICHIEDENTE, AUSSI_LAVORAZIONE_AUC, AUSSI_AUVIN_CODICE_PK

	
	from    TB_AUSSI_STORICO_INDIRIZZO
	where AUSSI_PROVENIENZA = @prov and AUSSI_CODICE_FISCALE=@cod

 



END







