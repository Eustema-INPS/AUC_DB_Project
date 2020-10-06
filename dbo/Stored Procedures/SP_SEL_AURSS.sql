
-- =============================================
-- Author:		Peter
-- Create date: 07/08/2014
-- Description:	lettura della tabella [tb_aurss_rel_sog_sog]
--              per chiavi di AUSCA, AUSCO, AUSSU e AUTIS
-- =============================================
CREATE PROCEDURE [dbo].[SP_SEL_AURSS] 
	-- Add the parameters for the stored procedure here
	@aurss_ausca_codice_pk int,
	@aurss_ausco_codice_pk int,
	@aurss_aussu_codice_pk int,
	@aurss_autis_codice_pk int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT [aurss_codice_pk]
      ,[aurss_ausca_codice_pk]
      ,[aurss_ausco_codice_pk]
      ,[aurss_aussu_codice_pk]
      ,[aurss_autis_codice_pk]
      ,[aurss_data_inizio_validita]
      ,[aurss_data_di_fine_validita]
      ,[aurss_data_iscr_libro_soci]
      ,[aurss_data_atto_di_nomina]
      ,[aurss_data_nomina]
      ,[aurss_data_fine_carica]
      ,[aurss_note]
      ,[aurss_rappresentante_legale]
      ,[aurss_data_modifica]
      ,[aurss_descr_utente]
      ,[aurss_codice_pk_db2]
      ,[aurss_relazione_certificata]
      ,[aurss_rec_del]
      ,[aurss_data_del]
      ,[aurss_cert_auten_cod_pk]
      ,[aurss_cert_cod_entita_rif]
      ,[aurss_cert_data_modifica]
      ,[aurss_indice_qualita_relazione]
      ,[aurss_auten_codice_pk]
      ,[aurss_codice_entita_rif]
      ,[aurss_codice_carica]
      ,[aurss_provenienza]
      ,[aurss_data_iscrizione]
  FROM [dbo].[tb_aurss_rel_sog_sog]
  WHERE
     1=1
     AND [aurss_ausca_codice_pk] = @aurss_ausca_codice_pk
	 AND [aurss_ausco_codice_pk] = @aurss_ausco_codice_pk
	 AND [aurss_aussu_codice_pk] = @aurss_aussu_codice_pk
	 AND [aurss_autis_codice_pk] = @aurss_autis_codice_pk
	 
  END


