







-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  14/05/2018
-- Description:		Storicizza i dati della tabella "tb_auate_cod_ateco_ct" nella tabella "tb_auacs_ateco_storico"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_StoricizzaAUATE]

/*@CF varchar (16),*/
@Cod int,
@interv varchar (1),
@motivo varchar (200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


insert into  [AUC].[dbo].[tb_auacs_ateco_storico](
      [auate_codice_pk]
      ,[auate_cod_ateco_complessivo]
      ,[auate_cod_sezione]
      ,[auate_cod_sezione_tit]
      ,[auate_cod_sezione_descr]
      ,[auate_cod_divisione]
      ,[auate_cod_divisione_tit]
      ,[auate_cod_divisione_descr]
      ,[auate_cod_gruppo]
      ,[auate_cod_gruppo_tit]
      ,[auate_cod_gruppo_descr]
      ,[auate_cod_classe]
      ,[auate_cod_classe_tit]
      ,[auate_cod_classe_descr]
      ,[auate_cod_categoria]
      ,[auate_cod_categoria_tit]
      ,[auate_cod_categoria_descr]
      ,[auate_cod_sottocategoria]
      ,[auate_cod_sottocategoria_tit]
      ,[auate_cod_sottocategoria_descr]
      ,[auate_cod_seconda_coppia]
      ,[auate_cod_terza_coppia]
      ,[auate_note]
      ,[auate_anno_riferimento]
      ,[auate_codatt]
      ,[auate_istat_code]
      ,[auate_data_modifica]
      ,[auate_descr_utente]
      ,[auate_codice_pk_db2]
      ,[auacs_data_storicizza]
      ,[auacs_descr_utente]
      ,[auacs_motivo]
      ,[auacs_tipo_intervento])

select * from (

SELECT  [auate_codice_pk]
      ,[auate_cod_ateco_complessivo]
      ,[auate_cod_sezione]
      ,[auate_cod_sezione_tit]
      ,[auate_cod_sezione_descr]
      ,[auate_cod_divisione]
      ,[auate_cod_divisione_tit]
      ,[auate_cod_divisione_descr]
      ,[auate_cod_gruppo]
      ,[auate_cod_gruppo_tit]
      ,[auate_cod_gruppo_descr]
      ,[auate_cod_classe]
      ,[auate_cod_classe_tit]
      ,[auate_cod_classe_descr]
      ,[auate_cod_categoria]
      ,[auate_cod_categoria_tit]
      ,[auate_cod_categoria_descr]
      ,[auate_cod_sottocategoria]
      ,[auate_cod_sottocategoria_tit]
      ,[auate_cod_sottocategoria_descr]
      ,[auate_cod_seconda_coppia]
      ,[auate_cod_terza_coppia]
      ,[auate_note]
      ,[auate_anno_riferimento]
      ,[auate_codatt]
      ,[auate_istat_code]
      ,[auate_data_modifica]
      ,[auate_descr_utente]
      ,[auate_codice_pk_db2]
      ,Getdate() as [auacs_data_storicizza]
      ,rtrim(@utente) as [auacs_descr_utente]
      ,rtrim(@motivo) as [auacs_motivo]
      ,rtrim(@interv) as [auacs_tipo_intervento]
  FROM [AUC].[dbo].[tb_auate_cod_ateco_ct]

where  [auate_codice_pk]= @Cod) as tab


END




