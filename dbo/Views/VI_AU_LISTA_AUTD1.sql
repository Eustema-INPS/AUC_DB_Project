CREATE VIEW [dbo].[VI_AU_LISTA_AUTD1]
AS
SELECT TOP 1000 
	   [autdt_codice] as Codice
      ,[autdt_descrizione] as DescrizioneBreve
      ,[autdt_descrizione_lunga] as DescrizioneEstesa
  FROM [AUC].[dbo].[tb_autdt_tipoditta_ct]
order by convert(int,[autdt_codice])

