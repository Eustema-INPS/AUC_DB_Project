-- =========================================================================
-- Author:		Picone / Bellantoni
-- Create date: 22 Novembre 2012
-- Description:	
-- Cerca l'indirizzo della posizione contributiva *agricola* per codice PK
-- =========================================================================
CREATE PROCEDURE [dbo].[SP_RICERCA_INDIRIZZO_AGR]
	@auind_tabella_codice_pk int 
AS
BEGIN
	    SET NOCOUNT ON;
	    
		SELECT auind_tabella_codice_pk, auind_gestore_indirizzo, auind_tabella
		FROM  dbo.tb_auind_indirizzi
		WHERE     
		(
			(auind_gestore_indirizzo = 'AGRICOLI')
			AND (auind_tabella_codice_pk = @auind_tabella_codice_pk) 
			AND (auind_tabella = 'AUPOC')
		)
END
