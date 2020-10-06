-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDSOGGDELEGATO] 
	-- Add the parameters for the stored procedure here
	@codice_fiscale_di_input varchar(16)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [audel_codice_pk]
	  ,[audel_codice_fiscale]
      ,[audel_cognome]
      ,[audel_nome]
      ,[audel_note]
      ,[audel_data_modifica]
      ,[audel_descr_utente]
      ,[audel_denominazione] -- rel. 2
  FROM  [dbo].[tb_audel_del]
  where audel_codice_fiscale = @codice_fiscale_di_input
END
