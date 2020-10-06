-- =========================================================================================================
-- Author:		Vannimartini
-- Create date: 08/05/2013
-- Description:	Controllo esistenza del CF di Destinazione e BlackList del CF di origine, per determinare
--				il Tipo di Azione da eseguire secomdo il seguente schema:
--
--					|TipoAzione	|	Ambito						|	Azione
--					---------------------------------------------------------------------------------------
--					|	A1		|CF di destinazione già presente|	SPOSTAMENTO POSIZIONE
--					|	A2		|CF di origine IN BlackList		|	CREAZIONE NUOVA AZIENDA
--					|	A3		|CF di origine NON IN BlackList	|	CREAZIONE NUOVA AZIENDA o VARIAZIONE CF
-- =========================================================================================================
CREATE PROCEDURE [dbo].[AZ_CtrlTipoAzione] 
	@CF_orig varchar(16),	--CF di Partenza
	@CF_new varchar(16)		--CF di Destinazione

AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @contaDest AS int
	DECLARE @ctrlBlackList AS int

	SELECT	@contaDest = COUNT(ausco_codice_fiscale)
	FROM	tb_ausco_sog_contr_col
	WHERE	ausco_codice_fiscale = @CF_new

	SELECT	@ctrlBlackList = COUNT(CF)
	FROM	Import_BlackList_POC
	WHERE	CF = @CF_orig
	
	
	IF @@ERROR = 0
		IF @contaDest > 0
			RETURN 200	-- A1 - Spostamento puntuale della singola posizione
		ELSE
			--RETURN 300	-- A2/A3 - Creazione nuova azienda o Variazione del CF
			IF @ctrlBlackList > 0
				RETURN 300	-- A2 - Creazione nuova azienda
			ELSE
				RETURN 400	-- A3 - Creazione nuova azienda o Variazione del CF
	ELSE
		RETURN 100

END
