





-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  04/05/2018
-- Description:	   Inserisce un nuovo record nella tabella "b_aufun_funz_sistema"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_InserisciRecAUFUN]

/*@Cod int,*/
@funz varchar(50),
@raggr varchar(50),
@descr varchar(200),
@abil varchar(200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;

INSERT INTO [dbo].[tb_aufun_funz_sistema](
       [aufun_funzione]
      ,[aufun_raggruppamento]
      ,[aufun_tipo_funzione]
	  ,[aufun_descr]
	  ,[aufun_flag_abilitato]
      ,[aufun_data_modifica]
      ,[aufun_descr_utente])
VALUES(
	rtrim(@funz),
	rtrim(@raggr),
	'W',
    rtrim(@descr),
    rtrim(@abil),
    Getdate(),
	rtrim(@utente))    

END




