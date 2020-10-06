-- =============================================
-- Author:		Maurizio Picone
-- =============================================
CREATE PROCEDURE [dbo].[AP_Aggiorna_Associazioni]
	@auref_codice_pk int,
	@associata int, 
	@auref_data_inizio_validita datetime = NULL,
	@auref_data_fine_validita datetime = NULL,
	@utente varchar(20)
AS
BEGIN
	IF @associata = 1
		BEGIN
		    /* AGGIORNAMENTO ASSOCIAZIONE CON NUOVE DATE */
			UPDATE [dbo].[tb_auref_rel_entita_funz]
				SET 
				   [auref_data_inizio_validita] = @auref_data_inizio_validita
				  ,[auref_data_fine_validita] = @auref_data_fine_validita
				  ,[auref_data_modifica] = getdate()
				  ,[auref_descr_utente] = @utente
				WHERE [dbo].[tb_auref_rel_entita_funz].auref_codice_pk = @auref_codice_pk
		END
	ELSE
	    /* CANCELLAZIONE ASSOCIAZIONE */
		BEGIN 
             DELETE FROM [dbo].[tb_auref_rel_entita_funz] WHERE auref_codice_pk = @auref_codice_pk
		END
	
END
