




-- ================================================================================
-- Author:		Peter
-- Create date: 22 Settembre 2014
-- Action Item: AI 2050
-- Description:	
-- Legge l'indirizzo della posizione contributiva per codice PK e gestore indirizzo
-- ================================================================================
CREATE PROCEDURE [dbo].[SP_SEL_AUIND]
	@auind_tabella_codice_pk int, 
	@auind_tabella varchar(5),
	@auind_aurea_codice_pk int 
AS
BEGIN
	    SET NOCOUNT ON;
	    
		SELECT *
		FROM  dbo.tb_auind_indirizzi
		WHERE     
		(
			auind_aurea_codice_pk = @auind_aurea_codice_pk 
			AND (auind_tabella_codice_pk = @auind_tabella_codice_pk) 
			AND (auind_tabella = @auind_tabella)
		)
END



