-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	lettura della vista Common_vista_provincie   qualificando:
--				code_sigla = sigla provincia

-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDREGIONE] 
	-- Add the parameters for the stored procedure here
	@sigla_provincia varchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [provincia]
      ,[regione]
  FROM  [dbo].[Common_vista_province]
  WHERE	code_sigla = @sigla_provincia
END
