-- =============================================
-- Author:		Natale Saviano
-- Create date: 01 luglio 2011
-- Description:	Inserimento nella tabella relazione utente-funzioni
-- =============================================
CREATE PROCEDURE [dbo].[UT_InsUtFunzioni]
	-- Add the parameters for the stored procedure here
    @auref_aufun_codice_pk int,
    @auref_auten_codice_pk int,
    @auref_codice_entita_rif int,
    @auref_data_inizio_validita datetime,
    @auref_data_fine_validita datetime,
    @auref_descr_utente varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO  [dbo].[tb_auref_rel_entita_funz]
           ([auref_aufun_codice_pk]
           ,[auref_auten_codice_pk]
           ,[auref_codice_entita_rif]
           ,[auref_data_inizio_validita]
           ,[auref_data_fine_validita]
           ,[auref_data_modifica]
           ,[auref_descr_utente])
     VALUES
           (@auref_aufun_codice_pk,
            @auref_auten_codice_pk,
            @auref_codice_entita_rif,
            @auref_data_inizio_validita,
            @auref_data_fine_validita,
            GETDATE(),
            @auref_descr_utente)
END
