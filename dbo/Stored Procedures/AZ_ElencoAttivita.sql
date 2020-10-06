
-- ===================================================
-- Author:		Quirino Vannimartini
-- Create date: 04/03/2014
-- Description:	Lista delle Attività legate all'AUSCA 
-- ===================================================
CREATE PROCEDURE [dbo].[AZ_ElencoAttivita]
	@ausca_codice_pk int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		aulat_codice_pk
-- Griglia
		,aulat_codice_gestione 
		,aulat_cf
		,aulat_data_inizio_attivita
		,aulat_data_inserimento
-- Dettaglio
		--,aulat_categoria
		--,aulat_note
		--,aulat_data_cf
		--,aulat_provenienza
		--,aulat_protocollo
	FROM tb_aulat_lista_attivita INNER JOIN tb_ausca_sog_contr_az ON 
      tb_aulat_lista_attivita.aulat_ausca_codice_PK = tb_ausca_sog_contr_az.ausca_codice_pk
	WHERE aulat_ausca_codice_PK = @ausca_codice_pk
	
	
END


