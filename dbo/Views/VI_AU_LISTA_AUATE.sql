CREATE VIEW [dbo].[VI_AU_LISTA_AUATE]
AS
SELECT  top(10000)
      auate_cod_ateco_complessivo as CodiceAteco
      ,auate_cod_sottocategoria_tit as Descrizione
      ,auate_anno_riferimento as AnnoRiferimento
FROM     tb_auate_cod_ateco_ct
order by AnnoRiferimento asc, codiceateco asc
