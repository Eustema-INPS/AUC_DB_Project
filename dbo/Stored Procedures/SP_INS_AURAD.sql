-- =============================================
-- Author:		Raffaele
-- Create date: 
-- Description:	La stored effettua l’inserimento di un record su AURAD.
-- =============================================
CREATE PROCEDURE [dbo].[SP_INS_AURAD] 
	-- Add the parameters for the stored procedure here
	@aurad_aupoc_codice_pk int ,      --codice posizione contributiva
	@aurad_audel_codice_pk int ,      --codice soggetto delegato
	@aurad_descr_utente varchar(50),  -- utente che effettua l’operazione
	@audel_codice_fiscale varchar(16),
	@audel_denominazione varchar(405),
	@audel_cognome varchar(255),
	@audel_nome varchar(150),
	@aurad_aussu_codice_pk int ,      		
	@aurad_autid_codice_pk int,
	@audel_tipo_persona varchar(1)       		
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [dbo].[tb_aurad_rel_az_del]
           ([aurad_aupoc_codice_pk]
           ,[aurad_audel_codice_pk]
           ,[aurad_autid_codice_pk]
           ,[aurad_aussu_codice_pk]
           ,[aurad_data_inizio_validita]
           ,[aurad_data_fine_validita]
           ,[aurad_note]
           ,[aurad_data_modifica]
           ,[aurad_descr_utente])
VALUES
(          @aurad_aupoc_codice_pk
           ,@aurad_audel_codice_pk
           ,@aurad_autid_codice_pk
           ,@aurad_aussu_codice_pk
           ,getdate()		--[aurad_data_inizio_validita]
           ,'29991231'      --[aurad_data_fine_validita]
           ,null		    --[aurad_note]
           ,getdate()		--[aurad_data_modifica]
           ,@aurad_descr_utente

)
    -- Insert statements for procedure here

	DECLARE @codice_pk integer,
			@id integer;
			SELECT SCOPE_IDENTITY() AS id;
			set @codice_pk = @id;
	
	
END
