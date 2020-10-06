






create VIEW [dbo].[VI_AU_VSTATO]
AS
SELECT     
	convert(varchar(2),dbo.[tb_auspc_stato_pos_contr_ct].auspc_codice) AS Codice,
	dbo.[tb_auspc_stato_pos_contr_ct].auspc_descr as Descrizione
FROM  [dbo].[tb_auspc_stato_pos_contr_ct]




