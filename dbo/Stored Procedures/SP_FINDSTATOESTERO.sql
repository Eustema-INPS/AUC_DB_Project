-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	lettura della vista Common_stati_esteri   qualificando:
--				stato_estero = stato_estero

-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDSTATOESTERO] 
	-- Add the parameters for the stored procedure here
	@stato_estero varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [CodiceCatastale]
  FROM  [dbo].[Common_stati_esteri]
  WHERE Stato_estero = @stato_estero
END
