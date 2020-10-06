
-- ================================================================================
-- Author:		Quirino Vannimartini
-- Create date: 04/03/2014
-- Description:	Dettaglio dell'Attività, legata all'AUSCA, selezionata dall'Elenco
-- ================================================================================
CREATE PROCEDURE [dbo].[AZ_DettaglioAttivita]
	@aulat_codice_pk int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		aulat_codice_gestione 
		,aulat_cf
		,aulat_data_inizio_attivita
		,aulat_data_inserimento
		,aulat_categoria
		,aulat_note
		,aulat_data_cf
		,aulat_provenienza
		,aulat_protocollo
	FROM tb_aulat_lista_attivita 
	WHERE aulat_codice_pk = @aulat_codice_pk
	
	
END


