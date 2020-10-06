







-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  04/05/2018
-- Description:	   Inserisce un nuovo record nella tabella "tb_aulov_accesso_visure"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_InserisciRecAULOV]

@cf varchar(16),
@tp varchar(1),
@desctr varchar(100),
@utente varchar(50)


AS
BEGIN
	SET NOCOUNT ON;


INSERT INTO [dbo].[tb_aulov_accesso_visure](
       [aulov_codfisc_soggetto]
      ,[aulov_tipo_ricerca]
      ,[aulov_descr_tr]
      ,[aulov_data_modifica]
      ,[aulov_descr_utente])
VALUES(
	rtrim(@cf),
	rtrim(@tp),
	rtrim(@desctr),
	Getdate(),
	rtrim(@utente))    

END






