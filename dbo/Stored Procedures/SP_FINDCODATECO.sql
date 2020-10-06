-- ===========================================================================================
-- Author:		  Martini
-- Description:	  lettura della tabella tb_auate_cod_ateco_ct qualificando:
--				  auate_cod_ateco_complessivo = codice_ateco 
-- ===========================================================================================
-- Data Modifica: 29 agosto 2012
-- Autore:        Raffaele
-- Descrizione:   Inserita la gestione dell'anno in funzione della lunghezza del codice ateco
-- ===========================================================================================
CREATE PROCEDURE [dbo].[SP_FINDCODATECO] 
	@codice_ateco varchar(15)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @ANNO integer;
	
	IF (LEN(@codice_ateco) = 5) SET @ANNO = 2002
	ELSE                        SET @ANNO = 2007

	SELECT TOP(1) 
	   [auate_codice_pk]
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
      ,[auate_data_modifica]
      ,[auate_descr_utente]
      
    FROM  
    [dbo].[tb_auate_cod_ateco_ct]
  
    WHERE 
    auate_cod_ateco_complessivo = @codice_ateco AND auate_anno_riferimento = @ANNO
  
END
