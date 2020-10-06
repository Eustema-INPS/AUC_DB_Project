-- =============================================
-- Author:		Natale Saviano
-- Create date: 05 luglio 2011
-- Description:	Elenco degli utenti ricercati per codice
-- =============================================
CREATE PROCEDURE [dbo].[UT_LegUtenteCodice]
	-- Add the parameters for the stored procedure here
	@auute_codice int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		auute_codice_pk as DB_codice,
        auute_cognome as DB_cognome,
        auute_nome as DB_nome,
        auute_aussu_codice_pk as DB_aussu_codice,
        auute_data_inizio_validita as DB_data_inizio_validita,
        auute_data_fine_validita as DB_data_fine_validita,
        auute_note as DB_note,
        auute_utenza as DB_utenza,
        auute_data_modifica as DB_data_modifica,
        auute_descr_utente as DB_descr_utente,
        auute_flag_abilitato as DB_flag_abilitato,
        auute_auruo_codice_pk as DB_ruolo
        
	FROM tb_auute_ute_sistema
	WHERE auute_codice_pk = @auute_codice 
	AND auute_aussu_codice_pk <>3
END
