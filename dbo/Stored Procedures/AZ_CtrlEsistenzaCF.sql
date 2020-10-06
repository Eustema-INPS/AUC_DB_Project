-- =============================================
-- Author:		Vannimartini
-- Create date: 
-- Description:	Ricerca Esistenza del Codice Fiscale o in Black list
-- =============================================
CREATE PROCEDURE [dbo].[AZ_CtrlEsistenzaCF] 
	-- Add the parameters for the stored procedure here
	@CF varchar(16)
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @ctrl AS int

	SELECT	@ctrl = COUNT(CF)
	FROM	[dbo].[Import_BlackList_POC]
	WHERE	CF = @CF
	
	IF @ctrl > 0
		RETURN 300	-- il CF è nella Black List
	ELSE
	BEGIN
		SELECT	@ctrl = COUNT(ausca_codice_fiscale)
		FROM	[dbo].[tb_ausca_sog_contr_az]
		WHERE	ausca_codice_fiscale = @CF
	END
	
	IF @ctrl > 0
		RETURN 200	-- il CF esiste già nella Base Dati
	ELSE
		IF @@ERROR = 0
			RETURN 0
		ELSE
			RETURN 100
END
