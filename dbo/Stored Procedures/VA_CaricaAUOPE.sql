








-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  14/05/2018
-- Description:		inserisce i dati della tabella "tb_auope"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_CaricaAUOPE]

@descr varchar (200),
@numrec as int,
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


insert into  [AUC].[dbo].[TB_AUOPE_OPERAZIONI](
       [AUOPE_DESCRIZIONE]
      ,[AUOPE_NUM_RECORD]
      ,[AUOPE_DATA_UPLOAD]
      ,[AUOPE_UTENTE])
VALUES(
	rtrim(@descr),
	rtrim(@numrec),
	Getdate(),
	rtrim(@utente))    



END




