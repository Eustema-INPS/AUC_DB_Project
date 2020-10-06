
-- ===============================================================================================
-- Author:		Quirino Vannimartini
-- Create date: 04/03/2014
-- Description:	Dettaglio del Codice Fiscale Confluito, legato all'AUSCA, selezionato dall'Elenco
-- ===============================================================================================
CREATE PROCEDURE [dbo].[AZ_DettaglioCfConfluiti]
	@aucfc_codice_PK int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		aucfc_cf
		,aucfc_cf_confluenza
		,aucfc_data_inizio
		,aucfc_data_fine
		,aucfc_stato
		,aucfc_motivo_cessazione
		,aucfc_codice_gestione
	FROM tb_aucfc_cfconfluiti 
	WHERE aucfc_codice_PK = @aucfc_codice_PK
	
	
END


