-- ===================================================================
-- Author:		Maurizio Picone
-- Create date: 24/02/2012
-- Description:	Torna il numero di RELEASE dell'applicativo AUC
-- ===================================================================
CREATE PROCEDURE [dbo].[AP_Release]

@RELEASE Varchar(10) OUTPUT

AS
BEGIN
	SET NOCOUNT ON;
		
    SET @RELEASE = (select ausys_valore from tb_ausys_sistema
	where ausys_parametro = 'ReleaseWebApp')   
	
    RETURN 0
END
