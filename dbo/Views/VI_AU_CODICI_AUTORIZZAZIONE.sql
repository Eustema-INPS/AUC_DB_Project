CREATE VIEW [dbo].[VI_AU_CODICI_AUTORIZZAZIONE] AS
SELECT [aucau_codice] As CodiceAutorizzazione
	  ,[aucau_descrizione] As Descrizione
      ,[aucau_data_inizio] As DataInizioValidita
      ,[aucau_data_fine] As DataFineValidita
FROM [AUC].[dbo].[tb_aucau_cod_autor_ct]
