







-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  10/09/2018
-- Description:	   Inserisce un nuovo record nella tabella "tb_aucme_codici_mes_err"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_InserisciRecAUCME]


@coderr int,
@tipoo varchar(1),
@descrb varchar(200),
@descrl varchar(200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;



INSERT INTO [dbo].[tb_aucme_codici_mes_err](
      [aucme_codice_pk]
	  ,[aucme_tipo_occorrenza]
      ,[aucme_descr_breve]
      ,[aucme_descr_lunga]
      ,[aucme_data_modifica]
      ,[aucme_descr_utente])
VALUES(
	rtrim(@coderr),
	rtrim(@tipoo),
	rtrim(@descrb),
	rtrim(@descrl),
        Getdate(),
	rtrim(@utente))    

END





