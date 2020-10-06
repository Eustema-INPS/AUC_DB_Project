-- ======================================================================
-- Author:		Vincenzo Pinto
-- Create date: 08 Marzo 2013
-- Description:	inserisce un CF in black list
--=======================================================================
CREATE PROCEDURE [dbo].[BL_InserisciCF] 
	@cf nvarchar(255),
	@utente varchar (50)
AS
BEGIN
  INSERT INTO [AUC].[dbo].[Import_BlackList_POC]
           ([CF]
           ,[Occorrenze]
           ,[Descr_utente]
           ,[Data_modifica])
     VALUES
           (@CF
           ,0
           ,@utente
           ,GETDATE())
END
