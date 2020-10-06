


-- =============================================
-- AI 2067
-- Author:		Peter
-- Create date: 12/01/2016
-- Description:	lettura della tabella [tb_aupnr_procedure_per_nrc] 
--              per sede Inps o codice fiscale
-- Modificatore Raffaele 
-- Data:        29/2/2016
-- Descrizione: Inserito raggruppamento per eliminare il prodotto cartesiano 
--              relativo a più posizioni per lo stesso cf e stessa sede. 
-- =============================================
CREATE PROCEDURE [dbo].[SP_SEL_AUPNR_SEDE] 
	@codiceSede varchar(4)
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT     	
	tb_aupnr_procedure_per_nrc.aupnr_codice_fiscale, 
	tb_aupnr_procedure_per_nrc.aupnr_tipo_procedura, 
	tb_aupnr_procedure_per_nrc.aupnr_data_inizio, 
	tb_aupnr_procedure_per_nrc.aupnr_gestione_pc, 
	tb_aupnr_procedure_per_nrc.aupnr_presenza_pc, 
	tb_aupnr_procedure_per_nrc.aupnr_data_invio_email
	FROM         
	tb_aupoc_pos_contr INNER JOIN
	tb_ausin_sedi_inps_ct ON tb_aupoc_pos_contr.aupoc_ausin_codice_pk = tb_ausin_sedi_inps_ct.ausin_codice_pk INNER JOIN
	tb_aupnr_procedure_per_nrc ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_aupnr_procedure_per_nrc.aupnr_ausca_codice_pk
	WHERE     
	(tb_ausin_sedi_inps_ct.ausin_codice_sede = @codiceSede) 
	AND (tb_aupoc_pos_contr.aupoc_aurea_codice_pk = 1) 
	AND (tb_aupnr_procedure_per_nrc.aupnr_gestione_pc = 1) 
	group by 
	tb_aupnr_procedure_per_nrc.aupnr_codice_fiscale, 
	tb_aupnr_procedure_per_nrc.aupnr_tipo_procedura, 
	tb_aupnr_procedure_per_nrc.aupnr_data_inizio, 
	tb_aupnr_procedure_per_nrc.aupnr_gestione_pc, 
	tb_aupnr_procedure_per_nrc.aupnr_presenza_pc, 
	tb_aupnr_procedure_per_nrc.aupnr_data_invio_email

	 
  END



