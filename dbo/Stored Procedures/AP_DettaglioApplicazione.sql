-- =============================================
-- Author:		Maurizio Picone
-- =============================================
CREATE PROCEDURE [dbo].[AP_DettaglioApplicazione]
	@ID int
AS
BEGIN
	SELECT 
       [auapp_descr] as DB_descr_app
      ,Convert(Varchar(10), auapp_data_inizio_operativita, 103) as DB_data_inizio_val
      ,Convert(Varchar(10), auapp_data_fine_operativita, 103) as DB_data_fine_val
      ,[auapp_flag_abilitato] as DB_flag_abilitato
      ,[auapp_note] as DB_note_app
      ,[auapp_app_name] as DB_nome_app
      ,[auapp_flag_internet] as DB_flag_internet
	  ,[auapp_aurea_codice_pk] as DB_aurea_codice
      
    FROM [dbo].[tb_auapp_appl] 
    WHERE [dbo].[tb_auapp_appl].[auapp_codice_pk] = @ID
END

