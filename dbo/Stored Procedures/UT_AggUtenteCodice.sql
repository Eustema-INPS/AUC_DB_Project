-- =============================================
-- Author:		Natale Saviano
-- Create date: 05 luglio 2011
-- Description:	Aggiornamento degll' utente ricercato per codice
-- =============================================
CREATE PROCEDURE [dbo].[UT_AggUtenteCodice]
	-- Add the parameters for the stored procedure here
	@auute_codice int,
	@auute_cognome varchar(50),
	@auute_nome varchar(50),
    @auute_aussu_codice_pk int,
    @auute_data_inizio_validita datetime,
    @auute_data_fine_validita datetime,
    @auute_note varchar(200),
    @auute_utenza varchar(50),
    @auute_descr_utente varchar(50),
    @auute_flag_abilitato varchar(1), 
    @auute_auruo_codice_pk int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
UPDATE  [dbo].[tb_auute_ute_sistema]
SET   auute_cognome = @auute_cognome, 
      auute_nome = @auute_nome, 
      auute_aussu_codice_pk = @auute_aussu_codice_pk,
      auute_data_inizio_validita = @auute_data_inizio_validita, 
      auute_data_fine_validita = @auute_data_fine_validita, 
      auute_note = @auute_note, 
      auute_utenza = @auute_utenza,
      auute_data_modifica = GETDATE(), 
      auute_descr_utente = @auute_descr_utente, 
      auute_flag_abilitato = @auute_flag_abilitato, 
      auute_auruo_codice_pk = @auute_auruo_codice_pk
      
WHERE auute_codice_pk = @auute_codice 
END
