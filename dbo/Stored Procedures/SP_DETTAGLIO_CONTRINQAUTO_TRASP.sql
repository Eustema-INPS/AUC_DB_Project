






-- =============================================
-- Author: Almaviva
-- Create date: 
-- Description:	AI 2063
-- Moddificata da: 
-- Data: 24 settembre 2015
-- Descrizione: La stored ritorna i dati di dettaglio sulle verifiche automatiche degli inquadramenti automatizzati
--              di una singola posizione contributiva CON TRASPOSIZIONE DELLE RIGHE E COLONNE
-- =============================================
CREATE PROCEDURE [dbo].[SP_DETTAGLIO_CONTRINQAUTO_TRASP] 
	-- parameters for the stored procedure 
	@aupoc_posizione varchar(50) = null

	AS
BEGIN

	SET NOCOUNT ON;

Declare @Temp_Contrinqauto TABLE
(
	[AUPOC_INQ_ESITO_CONTROL] [int] NULL,
	[AUPOC_INQ_COD_ERRORE_CONTROL] [int] NULL,
	[AUPOC_INQ_DESCR_ERRORE] [varchar](100) NULL,
	[AUPOC_INQ_DATA_PRIMO_CONTROL] [datetime] NULL,
	[AUPOC_INQ_DATA_ULTIMO_CONTROL] [datetime] NULL,
	[AUPOC_INQ_ESITO_VERIFICA_OPER] [int] NULL,
	[AUPOC_INQ_DATA_ESITO_VERIFICA_OPER] [datetime] NULL,
	[AUPOC_INQ_COD_OPER] [varchar](20) NULL,
	[AUPOC_INQ_NOTE] [varchar](200) NULL
)

INSERT INTO @Temp_Contrinqauto
(
[AUPOC_INQ_ESITO_CONTROL]                       ,
[AUPOC_INQ_COD_ERRORE_CONTROL]                  ,
[AUPOC_INQ_DESCR_ERRORE]                        ,
[AUPOC_INQ_DATA_PRIMO_CONTROL]                  ,
[AUPOC_INQ_DATA_ULTIMO_CONTROL]                 ,
[AUPOC_INQ_ESITO_VERIFICA_OPER]                 ,
[AUPOC_INQ_DATA_ESITO_VERIFICA_OPER]            ,
[AUPOC_INQ_COD_OPER]                            ,
[AUPOC_INQ_NOTE]                                
)
SELECT TOP 1 
[AUPOC_INQ_ESITO_CONTROL]                       ,
[AUPOC_INQ_COD_ERRORE_CONTROL]                  ,
[AUPOC_INQ_DESCR_ERRORE]                        ,
[AUPOC_INQ_DATA_PRIMO_CONTROL]                  ,
[AUPOC_INQ_DATA_ULTIMO_CONTROL]                 ,
[AUPOC_INQ_ESITO_VERIFICA_OPER]                 ,
[AUPOC_INQ_DATA_ESITO_VERIFICA_OPER]            ,
[AUPOC_INQ_COD_OPER]                            ,
[AUPOC_INQ_NOTE]                                

  FROM [dbo].[tb_aupoc_pos_contr]

  WHERE 
  AUPOC_POSIZIONE = @aupoc_posizione
  AND [aupoc_aurea_codice_pk] = 1

END

--SELECT * FROM @Temp_Contrinqauto

SELECT * FROM
 (
       SELECT 01 as ind, 'ESITO' as nome, 'ESITO' as descrizione, CONVERT(VARCHAR,CASE [AUPOC_INQ_ESITO_CONTROL] when 1 then 'OK' when 2 then 'KO' else '' END) as valore from @Temp_Contrinqauto   
 union SELECT 02 as ind, 'DATA_PRIMO_CONTROLLO' as nome, 'PRIMO CONTROLLO' as descrizione, CONVERT(VARCHAR, [AUPOC_INQ_DATA_PRIMO_CONTROL], 103) as valore from @Temp_Contrinqauto   
 union SELECT 03 as ind, 'DATA_ULTIMO_CONTROLLO' as nome, 'ULTIMO CONTROLLO' as descrizione, CONVERT(VARCHAR,[AUPOC_INQ_DATA_ULTIMO_CONTROL], 103) as valore from @Temp_Contrinqauto   
 union SELECT 04 as ind, 'CODICE_ERRORE' as nome, 'CODICE ERRORE' as descrizione, CONVERT(VARCHAR,[AUPOC_INQ_COD_ERRORE_CONTROL]  ) as valore from @Temp_Contrinqauto   
 union SELECT 05 as ind, 'DESCRIZIONE_ERRORE' as nome, 'DESCRIZIONE ERRORE' as descrizione, [AUPOC_INQ_DESCR_ERRORE] as valore from @Temp_Contrinqauto   
 --union SELECT 06 as ind, 'COD_ESITO_OPERATORE' as nome, 'CODICE ESITO OPERATORE' as descrizione, CONVERT(VARCHAR,[AUPOC_INQ_ESITO_VERIFICA_OPER])  as valore from @Temp_Contrinqauto   
 union SELECT 07 as ind, 'ESITO_OPERATORE' as nome, 'ESITO OPERATORE' as descrizione, CONVERT(VARCHAR,CASE [AUPOC_INQ_ESITO_VERIFICA_OPER] when 1 then 'OK' when 2 then 'KO' when 3 then 'Da ricontrollare' else '' END) as valore from @Temp_Contrinqauto   
 union SELECT 08 as ind, 'DATA_ESITO_OPERATORE' as nome, 'DATA ESITO OPERATORE' as descrizione, CONVERT(VARCHAR,[AUPOC_INQ_DATA_ESITO_VERIFICA_OPER], 103) as valore from @Temp_Contrinqauto   
 union SELECT 09 as ind, 'MATRICOLA_OPERATORE' as nome, 'MATRICOLA OPERATORE' as descrizione, [AUPOC_INQ_COD_OPER] as valore from @Temp_Contrinqauto   
 union SELECT 10 as ind, 'NOTE_OPERATORE' as nome, 'NOTE OPERATORE' as descrizione, [AUPOC_INQ_NOTE] as valore from @Temp_Contrinqauto
 ) A
order by ind

