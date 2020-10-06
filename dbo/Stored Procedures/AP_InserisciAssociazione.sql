-- =============================================
-- Author:		Maurizio Picone
-- =============================================
CREATE PROCEDURE [dbo].[AP_InserisciAssociazione]
	@auref_aufun_codice_pk int,	
	@auref_codice_entita_rif int,
	@auref_data_fine_validita datetime,
	@utente varchar(20)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO  [dbo].[tb_auref_rel_entita_funz]
			   ([auref_aufun_codice_pk]
			   ,[auref_auten_codice_pk]
			   ,[auref_codice_entita_rif]
			   ,[auref_data_inizio_validita]
			   ,[auref_data_fine_validita]
			   ,[auref_data_modifica]
			   ,[auref_descr_utente])
		 VALUES
			   (@auref_aufun_codice_pk
			   ,3 -- = APPLICAZIONE 
			   ,@auref_codice_entita_rif
			   ,GETDATE()
			   ,Convert(DateTime,@auref_data_fine_validita,103)
			   ,GETDATE()
			   ,@utente)
			   
			   if @@ERROR > 0 return 300
			   else return 0
			   
END
