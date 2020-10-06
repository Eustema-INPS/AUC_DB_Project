-- =============================================
-- Author:		Maurizio Picone
-- =============================================
CREATE PROCEDURE [dbo].[UT_CancellaUtente]
	@auute_codice_pk int
AS
BEGIN
   UPDATE [tb_auute_ute_sistema]
   SET [auute_aussu_codice_pk] = 3   
   WHERE [auute_codice_pk] = @auute_codice_pk
   
   IF @@ERROR = 0 RETURN 0
   ELSE RETURN 100
END
