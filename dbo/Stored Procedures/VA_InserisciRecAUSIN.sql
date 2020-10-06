






-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  18/05/2018
-- Description:	   Inserisce un nuovo record nella tabella "tb_ausin_sedi_inps_ct"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_InserisciRecAUSIN]

/*@Cod int,*/
@csede varchar(50),
@descr varchar(200),
@creg varchar(50),
@descreg varchar(200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[tb_ausin_sedi_inps_ct](
       [ausin_codice_sede]
      ,[ausin_descr]
      ,[ausin_codice_regione]
	  ,[ausin_descrizione_regione]
      ,[ausin_data_modifica]
      ,[ausin_descr_utente])
VALUES(
	rtrim(@csede),
	rtrim(@descr),
	rtrim(@creg),
	rtrim(@descreg),
        Getdate(),
	rtrim(@utente))    

END





