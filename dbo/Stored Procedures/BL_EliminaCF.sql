-- ======================================================================
-- Author:		Vincenzo Pinto
-- Create date: 08 Marzo 2013
-- Description:	Elimina un CF dalla black list
--=======================================================================
CREATE PROCEDURE [dbo].[BL_EliminaCF] 
	@cf nvarchar(255)
AS
BEGIN
   DELETE FROM [AUC].[dbo].[Import_BlackList_POC]
      WHERE CF=@cf
END
