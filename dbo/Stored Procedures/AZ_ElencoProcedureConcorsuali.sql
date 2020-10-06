-- =============================================
-- Author:		Maurizio Picone
-- =============================================
-- Author:		Letizia Bellantoni
-- Data:		2014.05.16
-- Descrizione: Aggiunto campo codice liquidazione
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoProcedureConcorsuali] 
	
	@aucon_ausca_codice_pk int
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [aucon_codice_pk]
      ,[aucon_ausca_codice_pk]
      ,[aucon_info]
      ,[aucon_data_iscrizione]
      ,[aucon_tribunale]
      ,[aucon_num_registrazione]
      ,[aucon_data_registrazione]
      ,[aucon_localita_uff_registro]
      ,[aucon_prov_uff_registro]
      ,[aucon_data_modifica]
      ,[aucon_descr_utente]
      ,aucon_codice_liquidazione
      
   FROM [dbo].[tb_aucon_concorsuale]
   WHERE [dbo].[tb_aucon_concorsuale].aucon_ausca_codice_pk = @aucon_ausca_codice_pk

END

