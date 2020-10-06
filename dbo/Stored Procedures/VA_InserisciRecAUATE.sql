






-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  04/05/2018
-- Description:	   Inserisce un nuovo record nella tabella "tb_auate_cod_ateco_ct"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_InserisciRecAUATE]

@catecompl varchar(15),
@csez varchar(1),
@csezt varchar(200),
@cdiv varchar(2),
@cdivt varchar(200),
@cstct varchar(200),
@annorif int,
@cistat varchar(15),
@utente varchar (50)


AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[tb_auate_cod_ateco_ct](
       [auate_cod_ateco_complessivo]
      ,[auate_cod_sezione]
      ,[auate_cod_sezione_tit]
      ,[auate_cod_divisione]
      ,[auate_cod_divisione_tit]
      ,[auate_cod_sottocategoria_tit]
      ,[auate_anno_riferimento]
      ,[auate_istat_code]
      ,[auate_data_modifica]
      ,[auate_descr_utente])
VALUES(
	rtrim(@catecompl),
	rtrim(@csez),
	rtrim(@csezt),	
	rtrim(@cdiv),	
	rtrim(@cdivt),	
	rtrim(@cstct),	
	rtrim(@annorif),	
	rtrim(@cistat),
	Getdate(),
	rtrim(@utente))    

END





