-- =============================================
-- Author:		Picone
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDCODICETIPO] 
	@autis_descr varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [autis_codice_pk]
	FROM   [dbo].[tb_autis_tipo_sog_col_ct]
	WHERE autis_descr = @autis_descr
END
