-- =============================================
-- Author:		Picone
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDCONTROCODICE] 
	@ausca_codice_pk int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [ausca_contro_codice]
	FROM   [dbo].[tb_ausca_sog_contr_az]
	WHERE [ausca_codice_pk] = @ausca_codice_pk
END
