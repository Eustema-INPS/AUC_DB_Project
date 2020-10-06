
/****** Script per comando SelectTopNRows da SSMS  ******/

CREATE VIEW [dbo].[VI_ISTAT_DENOM_PRECEDENTI] AS

SELECT [Codice Provincia] As CodiceProvincia
      ,[Codice di denominazione] As Codice_Denom_Precedente
      ,[Denominazione precedente] As Denom_Precedente
      ,[Comune cui è associata la denominazione precedente] As Denom_Attuale
      ,[Codice provincia1]
      ,[Codice comune]
  FROM [AUC].[dbo].[ISTAT_DENOMINAZIONI_PRECEDENTI]
