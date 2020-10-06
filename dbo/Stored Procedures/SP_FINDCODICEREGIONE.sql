-- =============================================
-- Author:		Maurizio Picone
-- Create date: 18/5/2012
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDCODICEREGIONE]
	@ausin_codice_sede varchar(4)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT [Ausin_codice_regione]
	FROM   [dbo].[tb_ausin_sedi_inps_ct]
	WHERE  [ausin_codice_sede] = @ausin_codice_sede
END
