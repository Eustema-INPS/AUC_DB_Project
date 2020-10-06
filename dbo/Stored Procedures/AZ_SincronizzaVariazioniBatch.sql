

-- ===================================================================================
-- Author:		Maurizio Picone
-- Create date: 18 Novembre 2011
-- Description:	Stored per tracciare tutte le variazioni dell'anagrafica delle aziende
-- ===================================================================================
CREATE PROCEDURE [dbo].[AZ_SincronizzaVariazioniBatch]
    @id_inizio int,
    @id_fine int,
	@auvar_auten_codice_pk int,
	@auvar_codice_entita_rif int
AS
BEGIN
	SET NOCOUNT ON;

    -- =======================================
    -- Reperimento dell'elenco codici azienda
    -- =======================================
	DECLARE CURSORE_CAMPI_0 Cursor
	FOR
    SELECT [ausca_codice_pk] FROM dbo.tb_ausca_sog_contr_az 
    where ausca_codice_pk >= @id_inizio and ausca_codice_pk <= @id_fine and ausca_soggetto_certificato = 'S'
            
--=======================================================================
-- Ciclo sull'elenco dei codici ed esecuzione Stored AZ_SincronizzaVariazioni
-- ======================================================================
    OPEN CURSORE_CAMPI_0   
    DECLARE @CodiceAzienda int
    FETCH NEXT FROM CURSORE_CAMPI_0 INTO @CodiceAzienda
    
	WHILE (@@FETCH_STATUS = 0) 
	BEGIN
		PRINT @CodiceAzienda
		--EXEC AZ_SincronizzaVariazioni @CodiceAzienda, @auvar_auten_codice_pk, @auvar_codice_entita_rif
		EXEC AZ_1_Sincronizza @CodiceAzienda, @auvar_auten_codice_pk, @auvar_codice_entita_rif
		FETCH NEXT FROM CURSORE_CAMPI_0 INTO @CodiceAzienda
	END
	
	CLOSE CURSORE_CAMPI_0
	DEALLOCATE CURSORE_CAMPI_0
END

