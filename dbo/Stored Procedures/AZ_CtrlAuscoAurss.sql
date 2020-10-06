-- =====================================================================================================
-- Author:		Vannimartini
-- Create date: 29/04/2013
-- Description:	Controllo esistenza e relazioni dei CF di Partenza e Destinazione secomdo il seguente
--				ENUNCIATO:
--					A. -> CF di Partenza su AUSCO e legato con AURSS (@contaPart > 0)
--					B. -> CF di Destinazione presente su AUSCO e legato con AURSS (@contaDest > 0)
--
--					|	A	|	B	|	Azione
--					----------------------------------------------------------------------------------
--					|vero	|vero	|	NESSUN AGGIORNAMENTO
--					|vero	|falso	|	AGGIORNAMENTO del CF di AUSCA e AUSCO
--					|falso	|vero	|	AGGIORNAMENTO del CF di AUSCA
--					|falso	|falso	|	AGGIORNAMENTO del CF di AUSCA
-- =====================================================================================================
CREATE PROCEDURE [dbo].[AZ_CtrlAuscoAurss] 
	@CF_orig varchar(16),	--CF di Partenza
	@CF_new varchar(16)		--CF di Destinazione
	--,@msgReturn varchar(100) output
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @contaPart AS int	-- CF di Partenza su AUSCO e legato con AURSS
	DECLARE @contaDest AS int	-- CF di Destinazione presente su AUSCO e legato con AURSS
	--SET @msgReturn = ''

	SELECT	@contaPart = COUNT(ausco_codice_fiscale)
	FROM	tb_ausco_sog_contr_col INNER JOIN
			tb_aurss_rel_sog_sog ON 
				tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk INNER JOIN
			tb_ausca_sog_contr_az ON 
				tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
	WHERE	ausco_codice_fiscale = @CF_orig
	
	SELECT	@contaDest = COUNT(ausco_codice_fiscale)
	FROM	tb_ausco_sog_contr_col INNER JOIN
			tb_aurss_rel_sog_sog ON 
				tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk INNER JOIN
			tb_ausca_sog_contr_az ON 
				tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk AND
				ausca_codice_fiscale = @CF_orig
	WHERE	ausco_codice_fiscale = @CF_new

	
	IF @@ERROR = 0
		IF @contaPart > 0
			IF @contaDest > 0
				RETURN 200	-- Operazione non consentita
			ELSE
				RETURN 300	-- Aggiornare AUSCA e AUSCO con il nuovo CF (@CF_new)
		ELSE
			RETURN 400		-- Aggiornare AUSCA con il nuovo CF (@CF_new)
	ELSE
		RETURN 100

END
