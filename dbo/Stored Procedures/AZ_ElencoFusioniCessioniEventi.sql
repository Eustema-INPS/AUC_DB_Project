-- =============================================
-- Author:		Maurizio Picone - 06/09/2012
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoFusioniCessioniEventi] 
	@aufus_codice_pk int
AS
BEGIN
	SELECT
	    aueve_aufus_codice_pk, 
        aueve_prog_societa,
        aueve_denominazione,
        aueve_comune,
        aueve_codice_fiscale,
        aueve_cciaa,
        aueve_n_rea
    FROM 
	    [dbo].tb_aueve_eventi
	    
    WHERE 
       aueve_aufus_codice_pk = @aufus_codice_pk
END
