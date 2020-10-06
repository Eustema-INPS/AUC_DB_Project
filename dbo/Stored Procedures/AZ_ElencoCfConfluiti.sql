
-- ==================================================================
-- Author:		Quirino Vannimartini
-- Create date: 04/03/2014
-- Description:	Elenco dei Codici Fiscali Confluiti legati all'AUSCA 
-- ==================================================================
CREATE PROCEDURE [dbo].[AZ_ElencoCfConfluiti]
	@ausca_codice_pk int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		aucfc_codice_PK
-- Griglia
		,aucfc_cf
		,aucfc_cf_confluenza
		,aucfc_data_inizio
		,aucfc_data_fine
		,aucfc_stato
-- Dettaglio
		--,aucfc_motivo_cessazione
		--,aucfc_codice_gestione
	FROM tb_aucfc_cfconfluiti INNER JOIN tb_ausca_sog_contr_az ON 
		tb_aucfc_cfconfluiti.aucfc_ausca_codice_PK = tb_ausca_sog_contr_az.ausca_codice_pk
	WHERE aucfc_ausca_codice_PK = @ausca_codice_pk
	
END


