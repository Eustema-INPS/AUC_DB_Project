
/****** Script per comando SelectTopNRows da SSMS  ******/
CREATE VIEW [dbo].[VI_ISTAT_COMUNI] AS

SELECT [Codice Regione]
	  ,[Denominazione regione] As Regione
      --,[Codice dell'Unità territoriale sovracomunale _(valida a fini sta]
      --,[Codice Provincia (Storico)(1)]
      --,[Progressivo del Comune (2)]
	  ,[Codice Catastale del comune] As CodiceBelfiore
      ,[Codice Comune formato alfanumerico] As CodiceComune
      ,[Denominazione (Italiana e straniera)] As Denominazione_Str
      ,[Denominazione in italiano] As Denominazione_Ita
      --,[Denominazione altra lingua]
      --,[Codice Ripartizione Geografica]
      --,[Ripartizione geografica]      
      --,[Denominazione dell'Unità territoriale sovracomunale _(valida a f]
      --,[Flag Comune capoluogo di provincia/città metropolitana/libero co]
      ,[Sigla automobilistica] As SiglaProvincia
      --,[Codice Comune formato numerico]
      --,[Codice Comune numerico con 110 province (dal 2010 al 2016)]
      --,[Codice Comune numerico con 107 province (dal 2006 al 2009)]
      --,[Codice Comune numerico con 103 province (dal 1995 al 2005)]
      
      --,[Popolazione legale 2011 (09/10/2011)]
      --,[NUTS1]
      --,[NUTS2(3) ]
      --,[NUTS3]
  FROM [AUC].[dbo].[ISTAT_CODICI_COMUNI]
--  where [Denominazione in italiano] = 'pomezia'


  
