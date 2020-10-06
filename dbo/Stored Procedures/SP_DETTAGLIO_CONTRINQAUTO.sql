

-- =============================================
-- Author: Almaviva
-- Create date: 
-- Description:	AI 2063
-- Moddificata da: 
-- Data: 24 settembre 2015
-- Descrizione: La stored ritorna i dati di dettaglio sulle verifiche automatiche degli inquadramenti automatizzati
--              di una singola posizione contributiva
-- =============================================
CREATE PROCEDURE [dbo].[SP_DETTAGLIO_CONTRINQAUTO] 
	-- parameters for the stored procedure 
	@aupoc_posizione varchar(50)

	AS
BEGIN

	SET NOCOUNT ON;

SELECT 
       CASE [AUPOC_INQ_ESITO_CONTROL] when 1 then 'OK' when 2 then 'KO' else '' END as ESITO
      ,[AUPOC_INQ_DATA_PRIMO_CONTROL] as "PRIMO CONTROLLO"
      ,[AUPOC_INQ_DATA_ULTIMO_CONTROL] as "ULTIMO CONTROLLO"
      ,[AUPOC_INQ_COD_ERRORE_CONTROL] as "CODICE ERRORE"
      ,[AUPOC_INQ_DESCR_ERRORE] as "DESCRIZIONE ERRORE"
      ,CASE [AUPOC_INQ_ESITO_VERIFICA_OPER] when 1 then 'OK' when 2 then 'KO' when 3 then 'DA RICONTROLLARE' else '' END as "ESITO OPERATORE"
      ,[AUPOC_INQ_DATA_ESITO_VERIFICA_OPER] as "DATA ESITO OPERATORE"
      ,[AUPOC_INQ_COD_OPER] as "MATRICOLA OPERATORE"
      ,[AUPOC_INQ_NOTE] as "NOTE OPERATORE"
  FROM [dbo].[tb_aupoc_pos_contr]

  WHERE 
  AUPOC_POSIZIONE = @aupoc_posizione
  AND [aupoc_aurea_codice_pk] = 1
  

END


