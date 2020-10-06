



-- =============================================
-- Author:		Palmieri-Paletta
-- Create date: 
-- Data:		2019.09.23
-- Descrizione:	report Codici di Autorizzazione
-- =============================================
CREATE PROCEDURE [dbo].[SP_Rep_CA]

AS
BEGIN
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
      [aucau_codice] as Codice
      ,convert(date,[aucau_data_inizio],103) as DataInizio
      ,convert(date,[aucau_data_fine],103) as DataFIne
      ,[aucau_descrizione] as descrizione
  FROM [AUC].[dbo].[tb_aucau_cod_autor_ct]
  order by Codice asc
  END
  
