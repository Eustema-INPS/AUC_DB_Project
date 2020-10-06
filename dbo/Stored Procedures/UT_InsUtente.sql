-- =============================================
-- Author:		Natale Saviano
-- Create date: 27 giugno 2011
-- Description:	Inserimento di un record in tabella Utente
-- =============================================
CREATE PROCEDURE [dbo].[UT_InsUtente]
	-- Add the parameters for the stored procedure here
    @ute_cognome varchar(50),
    @ute_nome varchar(50),
    @ute_aussu_codice_pk int,
    @ute_data_inizio_validita datetime,
    @ute_data_fine_validita datetime,
    @ute_note varchar(200),
    @ute_utenza varchar(50),
    @ute_descr_utente varchar(50),
    @ute_flag_abilitato varchar(1), 
    @auute_auruo_codice_pk int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO  [dbo].[tb_auute_ute_sistema]
           ([auute_cognome]
           ,[auute_nome]
           ,[auute_aussu_codice_pk]
           ,[auute_data_inizio_validita]
           ,[auute_data_fine_validita]
           ,[auute_note]
           ,[auute_utenza]
           ,[auute_data_modifica]
           ,[auute_descr_utente]
           ,[auute_flag_abilitato]
           ,[auute_auruo_codice_pk])
     VALUES
           (@ute_cognome,
            @ute_nome,
            @ute_aussu_codice_pk,
            @ute_data_inizio_validita,
            @ute_data_fine_validita,
            @ute_note,
            @ute_utenza,
            GETDATE(),
            @ute_descr_utente,
            @ute_flag_abilitato, 
            @auute_auruo_codice_pk
            )
END
