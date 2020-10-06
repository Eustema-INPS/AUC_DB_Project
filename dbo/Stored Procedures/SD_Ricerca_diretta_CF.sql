-- ======================================================================
-- Author:		Raffaele
-- Create date: Marzo 2012
-- Description:	Stored per la ricerca dei Soggetti Delegati tramite codice fiscale
--              Utilizzata in ambito web services
-- ======================================================================
CREATE PROCEDURE [dbo].[SD_Ricerca_diretta_CF]
	@CF varchar(16)
AS
BEGIN	
	SET NOCOUNT ON;
	
	SELECT  TOP(1)
		audel_codice_pk				AS DB_CodiceSoggetto,
		audel_denominazione 		AS DB_Denominazione,
		audel_cognome				AS DB_Cognome,
		audel_nome					AS DB_Nome,
		audel_codice_fiscale		AS DB_CodiceFiscale,
		audel_note					AS DB_Note
	FROM
		tb_audel_del 
	WHERE 
		audel_codice_fiscale = @CF 

END
