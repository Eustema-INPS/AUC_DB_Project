-- =============================================
-- Author:		Maurizio Picone
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoSubentri] 
	@ausca_codice_pk int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT     
		ausub_tipo, 
		ausub_denominazione, 
		ausub_codice_fiscale, 
		ausub_titolo, 
		aucfi_ausca_codice_pk

	FROM         
		tb_aucfi_cod_fiscale 

	INNER JOIN
		tb_ausub_subentri ON tb_aucfi_cod_fiscale.aucfi_codice_fiscale = tb_ausub_subentri.ausub_codice_fiscale

	WHERE 
		tb_ausub_subentri.ausub_ausca_codice_pk = @ausca_codice_pk
END
