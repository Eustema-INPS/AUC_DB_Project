-- =============================================
-- Author:		Picone
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDCONTROCODICEPC] 
	@aupoc_codice_pk int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [aupoc_contro_codice]
	FROM   [dbo].tb_aupoc_pos_contr
	WHERE  [aupoc_codice_pk] = @aupoc_codice_pk
END
