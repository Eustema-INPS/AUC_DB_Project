

/****** Script per comando SelectTopNRows da SSMS  ******/
CREATE VIEW [dbo].[VI_ISTAT_COMUNI_SOPPRESSI] AS

SELECT [Codice Provincia/città metropolitana] As CodiceProv
      ,[Codice Istat del Comune] As CodIstatComune
      ,[Denominazione]
      ,[Sigla Automobilistica] As SiglaProvincia
  FROM [AUC].[dbo].[ISTAT_COMUNI_SOPPRESSI]
