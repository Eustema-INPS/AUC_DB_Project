









-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  18/09/2018
-- Description:		inserisce i dati della tabella "tb_audop.." con il report
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_CaricaAUDOPrep]

@codOpe as int,
@descr varchar (200),
@dato as varchar(16),
@numrep as int,
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


insert into  [AUC].[dbo].[TB_AUDOP_DETTAGLIO_OPERAZIONI](
      [AUOPE_CODICE_PK]
      ,[AUDOP_TIPO_DATO]
      ,[AUDOP_DATO]
      ,[AUDOP_AUREP_CODICE]
      ,[AUDOP_DATA_UPLOAD]
      ,[AUDOP_UTENTE])
VALUES(
	rtrim(@codOpe),
	rtrim(@descr),
	rtrim(@dato),
	rtrim(@numrep),
	Getdate(),
	rtrim(@utente))    



END





