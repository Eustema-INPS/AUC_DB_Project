
CREATE VIEW [dbo].[VI_AU_LISTA_AUTD2]
AS
SELECT TOP 1000 [autd2_codice] as Codice
      ,[autd2_descrizione] as DescrizioneBreve
      ,[autd2_descrizione_lunga] as DescrizioneEstesa
  FROM [AUC].[dbo].[tb_autd2_tipoditta2_ct]
order by convert(int,[autd2_codice])

