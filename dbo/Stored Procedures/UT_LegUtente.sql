-- =============================================
-- Author:		Natale Saviano
-- Create date: 27 giugno 2011
-- Description:	Elenco completo di tutti gli utenti
-- =============================================
CREATE PROCEDURE [dbo].[UT_LegUtente]
	-- Add the parameters for the stored procedure here
		@tipoRicerca int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
  
	if @tipoRicerca = 1 --tutti gli utenti NON cancellati
	BEGIN
		SELECT 
		auute_codice_pk as DB_codice,
        auute_cognome as DB_cognome,
        auute_nome as DB_nome,
        aussu_descr as DB_aussu_codice,
	    auute_data_inizio_validita as DB_data_inizio_validita,
        auute_data_fine_validita as DB_data_fine_validita,
        auute_note as DB_note,
        auute_utenza as DB_utenza,
        auute_data_modifica as DB_data_modifica,
        auute_descr_utente as DB_descr_utente,
        auute_flag_abilitato as DB_flag_abilitato
	FROM tb_auute_ute_sistema INNER JOIN tb_aussu_stato_sog_utente_ct
	ON auute_aussu_codice_pk = aussu_codice_pk
	WHERE auute_aussu_codice_pk <> 3
	ORDER BY auute_cognome ASC
	END
	
	if @tipoRicerca = 0 --tutti gli utenti cancellati
	BEGIN
		SELECT 
		auute_codice_pk as DB_codice,
        auute_cognome as DB_cognome,
        auute_nome as DB_nome,
        aussu_descr as DB_aussu_codice,
	    auute_data_inizio_validita as DB_data_inizio_validita,
        auute_data_fine_validita as DB_data_fine_validita,
        auute_note as DB_note,
        auute_utenza as DB_utenza,
        auute_data_modifica as DB_data_modifica,
        auute_descr_utente as DB_descr_utente,
        auute_flag_abilitato as DB_flag_abilitato
	FROM tb_auute_ute_sistema INNER JOIN tb_aussu_stato_sog_utente_ct
	ON auute_aussu_codice_pk = aussu_codice_pk
	WHERE auute_aussu_codice_pk = 3
	ORDER BY auute_cognome ASC
	END

END
