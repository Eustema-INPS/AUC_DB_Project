-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	Accesso alla tabella tb_auref_rel_entita_funz
--			in join con tb_auapp_appl   e tb_aufun_funz_sistema
--			qualificando: 
--			auapp_appname = AppName
--			per aufun_funzione = metodo invocato 
--			auref_aufun_codice_pk = aufun_codice_pk 
--			auref_codice_entita_rif = auapp_codice_pk  
--			auref_auten_codice_pk = 3 (Applicazione)
--	data di sistema compresa tra auref_data_inizio_validita e auref_data_fine_validita
-- Modificata da: Raffaele
-- Data:		2016.10.03
-- Descrizione:	Conversione getdate
-- =============================================
CREATE PROCEDURE [dbo].[SP_APPLICAZIONEABILITATA] 
	-- Add the parameters for the stored procedure here
	@AppName varchar(50) , 
	@metodo_invocato varchar(50)
	with recompile
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [auref_codice_pk]
      ,[auref_aufun_codice_pk]      
      ,[auref_auten_codice_pk]
      ,tb_auapp_appl.auapp_codice_pk
      ,tb_auapp_appl.auapp_app_name
      ,tb_aufun_funz_sistema.aufun_codice_pk
      ,tb_aufun_funz_sistema.aufun_funzione
      ,[auref_codice_entita_rif]
      ,[auref_data_inizio_validita]
      ,[auref_data_fine_validita]
      ,[auref_data_modifica]
      ,[auref_descr_utente]
  FROM  [dbo].[tb_auref_rel_entita_funz]
  left outer join  [dbo].[tb_auapp_appl]
  on auref_codice_entita_rif = auapp_codice_pk
  left outer join   [dbo].[tb_aufun_funz_sistema]
  on auref_aufun_codice_pk = aufun_codice_pk
  where auapp_app_name = @AppName
  and	aufun_funzione= @metodo_invocato and
  auref_auten_codice_pk = 3 and
  (convert(date,GETDATE(),103) BETWEEN convert(date,auref_data_inizio_validita,103) AND convert(date,auref_data_fine_validita,103))

--  getdate()  >= auref_data_inizio_validita
--  and	getdate()  <= auref_data_fine_validita
  
END
