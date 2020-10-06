



-- =============================================
-- AI 2067
-- Author:		Peter
-- Create date: 12/01/2016
-- Description:	lettura della tabella [tb_aupnr_procedure_per_nrc] 
--              per sede Inps o codice fiscale
-- =============================================
CREATE PROCEDURE [dbo].[SP_SEL_AUPNR_CF] 
	@codiceFiscale varchar(16)
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1
	aupnr_codice_fiscale, 
	aupnr_tipo_procedura, 
	aupnr_data_inizio, 
	aupnr_gestione_pc, 
	aupnr_presenza_pc,
	aupnr_data_invio_email
	FROM 
	tb_aupnr_procedure_per_nrc
	WHERE     
	aupnr_gestione_pc = 1
	AND (aupnr_codice_fiscale = @codiceFiscale)

	order by aupnr_data_modifica desc

	 
  END




