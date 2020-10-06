-- =============================================
-- Author:		Maurizio Picone
-- =============================================
-- Author:		Letizia Bellantoni
-- Data:		2014.08.28
-- Descrizione: Aggiunto campo auapp_aurea_codice_pk
-- =============================================
CREATE PROCEDURE [dbo].[AP_InserisciApplicazione] 
	@auapp_app_name as varchar(50),
	@auapp_descr as varchar(50),
	@auapp_data_inizio_operativita datetime,
	@auapp_data_fine_operativita datetime,
	@auapp_flag_abilitato varchar(1),
	@auapp_flag_internet int,
	@auapp_note varchar(200),
	@utente varchar(50),
	@auapp_aurea_codice_pk int
AS
BEGIN
   SET NOCOUNT ON;
   
   INSERT INTO [dbo].[tb_auapp_appl]
           ([auapp_descr],
            [auapp_aussu_codice_pk]
           ,[auapp_data_inizio_operativita]
           ,[auapp_data_fine_operativita]
           ,[auapp_flag_abilitato]
           ,[auapp_note]
           ,[auapp_data_modifica]
           ,[auapp_descr_utente]
           ,[auapp_app_name]
           ,[auapp_flag_internet]
		   ,[auapp_aurea_codice_pk])
     VALUES 
           (
            @auapp_descr
           ,1
           ,@auapp_data_inizio_operativita
           ,@auapp_data_fine_operativita
           ,@auapp_flag_abilitato
           ,@auapp_note
           ,getdate()
           ,@utente
           ,@auapp_app_name
           ,@auapp_flag_internet
           ,@auapp_aurea_codice_pk)
           
     IF @@ERROR > 0 
        RETURN 100      
     ELSE
        RETURN 0   
END

