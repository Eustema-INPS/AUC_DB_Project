-- =============================================
-- Author:		Raffaele
-- Create date: 
-- Description:	La stored effettua l’inserimento di un record su AUDEL e su AURAD.
-- =============================================
CREATE PROCEDURE [dbo].[SP_INS_AUDEL_E_AURAD] 
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


INSERT INTO [dbo].[tb_audel_del]
           ([audel_codice_fiscale]
	       ,[audel_denominazione]
           ,[audel_cognome]
           ,[audel_nome]
           ,[audel_note]
           ,[audel_tipo_persona]
           ,[audel_toponimo]
           ,[audel_indirizzo]
           ,[audel_civico]
           ,[audel_cap]
           ,[audel_descr_comune]
           ,[audel_provincia]
           ,[audel_sesso]
           ,[audel_data_nascita]
           ,[audel_comune_nascita]
           ,[audel_prov_nascita]
           ,[audel_telefono1]
           ,[audel_telefono2]
           ,[audel_fax]
           ,[audel_data_modifica]
           ,[audel_descr_utente])
VALUES(
	       @audel_codice_fiscale, 	--[audel_codice_fiscale]
           @audel_denominazione,	--,[audel_denominazione]
           @audel_cognome,		--,[audel_cognome]
           @audel_nome	,		--,[audel_nome]
           Null,			--,[audel_note]
           @audel_tipo_persona,	--,[audel_tipo_persona]
           Null,			--,[audel_toponimo]
           Null,			--,[audel_indirizzo]
           Null,			--,[audel_civico]
           Null,			--,[audel_cap]
           Null,			--,[audel_descr_comune]
           Null,			--,[audel_provincia]
           Null,			--,[audel_sesso]
           Null,			--,[audel_data_nascita]
           Null,			--,[audel_comune_nascita]
           Null,			--,[audel_prov_nascita]
           Null,			--,[audel_telefono1]
           Null,			--,[audel_telefono2]
           Null,			--,[audel_fax]
           Getdate(),			--,[audel_data_modifica]
           @aurad_descr_utente	--,[audel_descr_utente])
)

	DECLARE 
			@id1 integer;
			SELECT @id1=SCOPE_IDENTITY();

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
(          
           @aurad_aupoc_codice_pk,
           @id1
           ,@aurad_autid_codice_pk
           ,@aurad_aussu_codice_pk
           ,getdate()		--[aurad_data_inizio_validita]
           ,'29991231'      --[aurad_data_fine_validita]
           ,null		    --[aurad_note]
           ,getdate()		--[aurad_data_modifica]
           ,@aurad_descr_utente

)
    -- Insert statements for procedure here

--	DECLARE @codice1_pk integer,
--			@id1 integer;
			SELECT isnull(SCOPE_IDENTITY(),0) AS id;
--			set @codice1_pk = @id1;
	
	
END
