









-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  18/09/2018
-- Description:		inserisce i dati della tabella "tb_auope" con i dettagli del report
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_CaricaAUOPErep]

@descr varchar (200),
@numrec as int,
@numrep as int,
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


insert into  [AUC].[dbo].[TB_AUOPE_OPERAZIONI](
       [AUOPE_DESCRIZIONE]
      ,[AUOPE_NUM_RECORD]
      ,[AUOPE_AUREP_CODICE]
      ,[AUOPE_DATA_UPLOAD]
      ,[AUOPE_UTENTE])
VALUES(
	rtrim(@descr),
	rtrim(@numrec),
	rtrim(@numrep),
	Getdate(),
	rtrim(@utente))    



END





