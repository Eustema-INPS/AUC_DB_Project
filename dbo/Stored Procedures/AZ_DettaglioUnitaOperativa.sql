-- =========================================================================================
-- Author:		Quirino Vannimartini
-- Create date: 18/11/2011
-- Description:	Stored Procedure per l'estrazione del Dettaglio Unità Operativa selezionata
-- =========================================================================================

-- ======================================================================
-- Modificata da:  Quirino Vannimartini
-- Data modifica:  03/04/2012
-- Description:	Utilizzo dei nuovi campi della tabella aggiornata
-- ======================================================================

-- ===========================================================================
-- Modificata da:  Stefano
-- Data modifica:  19/07/2017
-- Description: Recuperate informazioni unità operativa e unità produttiva
-- ===========================================================================

CREATE PROCEDURE [dbo].[AZ_DettaglioUnitaOperativa]
	@codicePosizione int,
	@codiceUnita int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		auuop_codice_pk				AS DB_CodiceUnita,
		auuop_identificativo		AS DB_IdUnita,
		auuop_denominazione			AS DB_DenominazioneSede,
		auind_toponimo				AS DB_PrefissoStradale,
		auind_indirizzo				AS DB_Indirizzo,
		auind_civico				AS DB_NumeroCivico,
		auind_descr_comune			AS DB_Comune,
		auind_sigla_provincia		AS DB_Provincia,
		auind_cap					AS DB_Cap,
		auind_telefono1				AS DB_TelfonoPrinc,
		auind_telefono2				AS DB_TelefonoAlt,
		auind_fax					AS DB_Fax,
		auind_email					AS DB_Email,
		auuop_numero_dipendenti		AS DB_NumeroDipendenti,
		CONVERT(VARCHAR(10), auuop_data_inizio_accentr, 103)
									AS DB_DataInizio,
		CONVERT(VARCHAR(10), auuop_data_fine_accentr, 103)
									AS DB_DataFine,
		CASE auuop_unita_operativa
			WHEN 'N' THEN 'NO'
			ELSE 'SI'
		END as DB_UnitaOperativa,
		CASE auuop_unita_produttiva
			WHEN 'N' THEN 'NO'
			ELSE 'SI'
		END as DB_UnitaProduttiva
	FROM tb_auuop_unita_operativa
	LEFT OUTER JOIN tb_auind_indirizzi ON
		--UPPER(auind_tabella) = 'AUUOP' AND auind_tabella_codice_pk = @codicePosizione
		UPPER(auind_tabella) = 'AUUOP' AND auind_tabella_codice_pk = @codiceUnita
	WHERE 
		auuop_aupoc_codice_pk = @codicePosizione AND
		auuop_codice_pk = @codiceUnita
	
END
