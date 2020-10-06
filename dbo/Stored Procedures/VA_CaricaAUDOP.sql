








-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  14/05/2018
-- Description:		inserisce i dati della tabella "tb_audop.."
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_CaricaAUDOP]

@codOpe as int,
@descr varchar (200),
@dato as varchar(16),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


insert into  [AUC].[dbo].[TB_AUDOP_DETTAGLIO_OPERAZIONI](
      [AUOPE_CODICE_PK]
      ,[AUDOP_TIPO_DATO]
      ,[AUDOP_DATO]
      ,[AUDOP_DATA_UPLOAD]
      ,[AUDOP_UTENTE])
VALUES(
	rtrim(@codOpe),
	rtrim(@descr),
	rtrim(@dato),
	Getdate(),
	rtrim(@utente))    



END




