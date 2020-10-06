
-- =============================================
-- Author:		Maurizio Picone
-- =============================================
-- ==============================================================================
-- Author:		Quirino Vannimartini
-- Modifica date: 01/10/2013
-- Description:	Controllo esistenza per "Modifica del campo Nome Applicazione"
-- ==============================================================================
CREATE PROCEDURE [dbo].[AP_CheckEsistenzaApplicazione]
	@auapp_app_name varchar(50),
	@auapp_codice_pk int
AS
BEGIN
	SET NOCOUNT ON;
	
	--INIZIO modifca Quirino 01/10/2013
	--SELECT auapp_app_name FROM dbo.tb_auapp_appl WHERE auapp_app_name=@auapp_app_name
	IF @auapp_codice_pk = 0
	BEGIN
		SELECT auapp_app_name FROM dbo.tb_auapp_appl WHERE auapp_app_name=@auapp_app_name
	END
	ELSE
	BEGIN
		SELECT auapp_app_name 
		FROM dbo.tb_auapp_appl 
		WHERE 
			auapp_app_name = @auapp_app_name AND
			auapp_codice_pk <> @auapp_codice_pk
	END
	--FINE modifca Quirino 01/10/2013
	
	IF @@ERROR = 0 RETURN 100
END


