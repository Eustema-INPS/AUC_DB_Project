



-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  18/09/2019
-- Description:		inserisce i dati della tabella "TB_AUSIP_STORICO_INDIRIZZO_POSIZIONE"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_CaricaAUSIP]

@posiz as varchar(50),
@codaupoc as int,
@top as varchar(50),
@ind as varchar(255),
@civico as varchar(50),
@cap as varchar(5), 
@comune as varchar(50),
@provincia as varchar(2),
--@belfiore as varchar(4),
@topold as varchar(50),
@indold as varchar(255),
@civicoold as varchar(50),
@capold as varchar(5),
@comuneold as varchar(50),
@provinciaold as varchar(2),
--@belfioreold as varchar(4),
@utente varchar (50),
@motivo varchar (200)

AS
BEGIN
    SET NOCOUNT ON;


insert into  [AUC].[dbo].[TB_AUSIP_STORICO_INDIRIZZO_POSIZIONE](
      [AUSIP_aupoc_codice_pk]
      ,[AUSIP_POSIZIONE]
      ,[AUSIP_TOPONIMO]
      ,[AUSIP_INDIRIZZO]
      ,[AUSIP_CIVICO]
      ,[AUSIP_CAP]
      ,[AUSIP_COMUNE]
      ,[AUSIP_PROVINCIA]
      --,[AUSIP_CODICE_COMUNE_BELFIORE]
      ,[AUSIP_TOPONIMO_OLD]
      ,[AUSIP_INDIRIZZO_OLD]
      ,[AUSIP_CIVICO_OLD]
      ,[AUSIP_CAP_OLD]
      ,[AUSIP_COMUNE_OLD]
      ,[AUSIP_PROVINCIA_OLD]
      --,[AUSIP_CODICE_COMUNE_BELFIORE_OLD]
      ,[AUSIP_MOTIVO]
      ,[AUSIP_DATA_MODIFICA]
      ,[AUSIP_DESCR_UTENTE])
VALUES(
    rtrim(@codaupoc),
    rtrim(@posiz),
    rtrim(@top),
    rtrim(@ind),
	rtrim(@civico),
    rtrim(@cap),    
	rtrim(@comune),
    rtrim(@provincia),
	--rtrim(@belfiore),
	 rtrim(@topold),
    rtrim(@indold),
	rtrim(@civicoold),
    rtrim(@capold),    
	rtrim(@comuneold),
    rtrim(@provinciaold),
	--rtrim(@belfioreold),
    rtrim(@motivo),
    Getdate(),
    rtrim(@utente)
)    



END






