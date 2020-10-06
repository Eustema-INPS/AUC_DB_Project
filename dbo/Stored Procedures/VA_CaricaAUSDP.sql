


-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  17/09/2019
-- Description:		inserisce i dati della tabella "TB_AUSDP_STORICO_DENOM_POSIZIONE"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_CaricaAUSDP]

@posiz as varchar(50),
@codaupoc as int,
@denomprec varchar (300),
@denom as varchar(300),
@datamodaupoc datetime,
--@datamoddmag datetime,
@utente varchar (50),
@motivo varchar (200)

AS
BEGIN
    SET NOCOUNT ON;


insert into  [AUC].[dbo].[TB_AUSDP_STORICO_DENOM_POSIZIONE](
       [AUSDP_POSIZIONE]
      ,[AUSDP_AUPOC_CODICE_PK]
      ,[AUSDP_DENOM_PRECEDENTE]
      ,[AUSDP_DENOM_ATTUALE]
      ,[AUSDP_DATA_MODIFICA_AUPOC]
      ,[AUSDP_DATA_MODIFICA]
      ,[AUSDP_DESCR_UTENTE] 
      ,[AUSDP_MOTIVO])
VALUES(
    rtrim(@posiz),
    rtrim(@codaupoc),
    rtrim(@denomprec),
    rtrim(@denom),
    rtrim(@datamodaupoc),
    Getdate(),
    rtrim(@utente),
    rtrim(@motivo))    



END





