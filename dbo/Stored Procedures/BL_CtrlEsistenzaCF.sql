
-- ============================================================================
-- Author:		Vannimartini
-- Create date: 20/06/2013
-- Description:	Ricerca Esistenza del Codice Fiscale in Black list e in AUSCA
-- ============================================================================
CREATE PROCEDURE [dbo].[BL_CtrlEsistenzaCF] 
	@CF varchar(16),
	@messaggio AS varchar(500) OUTPUT
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @ctrlBL AS int
	DECLARE @ctrlAUSCA AS int
	DECLARE @denominazione AS varchar(200)
	SET @messaggio = ''

	SELECT	@ctrlBL = COUNT(CF)
	FROM	[dbo].[Import_BlackList_POC]
	WHERE	CF = @CF
	
	SELECT	@ctrlAUSCA = COUNT(ausca_codice_fiscale)
	FROM	[dbo].[tb_ausca_sog_contr_az]
	WHERE	ausca_codice_fiscale = @CF
	
	IF @ctrlBL > 0
		SET @messaggio = 'il Codice Fiscale digitato è già nella Black List'

	IF @ctrlAUSCA > 0
	BEGIN
		SELECT @denominazione = ausca_denominazione
		FROM tb_ausca_sog_contr_az
		WHERE ausca_codice_fiscale = @CF
		
		IF @ctrlBL > 0
			SET @messaggio = @messaggio + ' e fa riferimento al soggetto ' + isnull(@denominazione, '')
		ELSE
			SET @messaggio = 'il Codice Fiscale digitato fa riferimento al soggetto ' + isnull(@denominazione, '')
	END
	
	IF LEN(@messaggio) > 0
		SET @messaggio = @messaggio + ' <br />Si vuole procedere?'
	

	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END


