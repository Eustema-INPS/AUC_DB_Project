-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_LEGGIERRORE] 
	-- Add the parameters for the stored procedure here
	@codice_di_errore_applicativo int = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [aucme_tipo_occorrenza]
      ,[aucme_descr_breve]
      ,[aucme_descr_lunga]
      ,[aucme_data_modifica]
      ,[aucme_descr_utente]
  FROM  [dbo].[tb_aucme_codici_mes_err]
  where aucme_codice_pk = @codice_di_errore_applicativo
END
