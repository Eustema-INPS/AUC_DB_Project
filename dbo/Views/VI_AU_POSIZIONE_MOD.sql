
CREATE VIEW [dbo].[VI_AU_POSIZIONE_MOD]
AS
SELECT 
[aupoc_posizione]
      ,[aupoc_data_modifica]
FROM [dbo].[tb_aupoc_pos_contr]
where aupoc_aurea_codice_pk = 1 
