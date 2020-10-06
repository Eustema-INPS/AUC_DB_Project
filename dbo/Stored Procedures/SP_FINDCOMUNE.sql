-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	lettura della vista Common_vista_comuniitaliani   qualificando:
--	comune = ausca_descr_comune

-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDCOMUNE] 
	-- Add the parameters for the stored procedure here
	@ausca_descr_comune varchar(60)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [CodiceCatastale]
			,[Provincia]
  FROM  [dbo].[Common_vista_comuniitaliani]
  WHERE Comune= @ausca_descr_comune
END
