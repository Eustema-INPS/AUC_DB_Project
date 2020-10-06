
CREATE VIEW [dbo].[VI_AU_LISTA_AUCAU]
AS
SELECT  TOP 1000
      [aucau_codice] AS CA
      ,[aucau_descrizione] AS Descrizione
      ,CONVERT(DATE,[aucau_data_inizio]) AS DataInizio
      ,CONVERT(DATE,[aucau_data_fine]) AS DataFine
FROM     tb_aucau_cod_autor_ct 
ORDER BY [aucau_codice]

