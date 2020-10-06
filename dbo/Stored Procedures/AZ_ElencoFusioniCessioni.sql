-- =============================================
-- Author:		Maurizio Picone
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoFusioniCessioni] 
	@aufus_ausca_codice_pk int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT 
		aufus_codice_pk,
        aufus_prog_fusione,
        aufus_c_tipo,
        aufus_approvazione,
        aufus_evento,
        aufus_data_iscrizione,
        aufus_data_mod_evento,
        aufus_data_delibera,
        aufus_data_atto_esecuzione,
        aufus_data_atto,aufus_c_evento
        
    FROM 
	    [dbo].tb_aufus_fusioni_scissioni
	    
    WHERE 
       aufus_ausca_codice_pk = @aufus_ausca_codice_pk
END
