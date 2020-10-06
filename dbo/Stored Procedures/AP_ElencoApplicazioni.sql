-- =============================================
-- Author:		Maurizio Picone
-- Modificata il 20140526 Letizia , errore nella differenza tra date
-- =============================================
CREATE PROCEDURE [dbo].[AP_ElencoApplicazioni]
AS
BEGIN
SELECT [auapp_codice_pk] as DB_codice_app,	 
	   CASE WHEN 
			-- Se la data odierna è maggiore della data di scadenza...
	        --Convert(Varchar(10), GETDATE(), 103) > Convert(Varchar(10), auapp_data_fine_operativita, 103)
			DateDiff(day,getdate(),auapp_data_fine_operativita)<0
	        THEN 'OUT'
			ELSE 'IN'
	   END AS DB_validita
	  ,[auapp_aussu_codice_pk] as DB_stato_app
      ,[auapp_descr]  as DB_descr_app
      ,[auapp_data_inizio_operativita] as DB_data_inizio_val
      ,[auapp_data_fine_operativita] as DB_data_fine_val
      ,[auapp_flag_abilitato] as DB_flag_abilitato
      ,[auapp_note] 
      ,[auapp_app_name] as DB_nome_app
      ,[auapp_flag_internet] as DB_flag_internet
  FROM [dbo].[tb_auapp_appl]
  WHERE auapp_aussu_codice_pk = 1
  order by [auapp_app_name] asc
END
