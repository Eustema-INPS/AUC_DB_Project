-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_ESISTEAPPLICAZIONE] 
	-- Add the parameters for the stored procedure here
	@AppName varchar(50) 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   SELECT [auapp_codice_pk]
      ,[auapp_descr]
      ,[auapp_aussu_codice_pk]
      ,[auapp_data_inizio_operativita]
      ,[auapp_data_fine_operativita]
      ,[auapp_flag_abilitato]
      ,[auapp_note]
      ,[auapp_data_modifica]
      ,[auapp_descr_utente]
      ,[auapp_app_name]
      ,[auapp_flag_internet]
  FROM  [dbo].[tb_auapp_appl]
  where auapp_app_name = @AppName
END
