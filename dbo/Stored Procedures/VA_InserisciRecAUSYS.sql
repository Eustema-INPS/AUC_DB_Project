




-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  13/04/2018
-- Description:	   Inserisce un nuovo record nella tabella "tb_ausys_sistema"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_InserisciRecAUSYS]

/*@Cod int,*/
@param varchar(50),
@descrB varchar(50),
@descrL varchar(200),
@valore varchar(200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[tb_ausys_sistema](
       [ausys_parametro]
      ,[ausys_descr_breve]
      ,[ausys_descr_lunga]
      ,[ausys_data_modifica]
      ,[ausys_descr_utente]
      ,[ausys_valore])

VALUES(
	rtrim(@param),
	rtrim(@descrB),
    rtrim(@descrL),
    Getdate(),
	rtrim(@utente),
    rtrim(@valore))    

END



