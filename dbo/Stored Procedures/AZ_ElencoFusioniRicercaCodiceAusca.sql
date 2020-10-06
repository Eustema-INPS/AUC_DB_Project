-- =============================================
-- Author:		Maurizio Picone
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoFusioniRicercaCodiceAusca] 
	@aueve_codice_fiscale varchar(16)
AS
BEGIN
	SELECT     
	tb_aucfi_cod_fiscale.aucfi_ausca_codice_pk as DB_ausca_codice_pk
	
	FROM tb_aucfi_cod_fiscale 
	INNER JOIN
    tb_aueve_eventi 
    ON tb_aucfi_cod_fiscale.aucfi_codice_fiscale = tb_aueve_eventi.aueve_codice_fiscale
    
	WHERE LTRIM(RTRIM(tb_aucfi_cod_fiscale.aucfi_codice_fiscale)) = LTRIM(RTRIM(@aueve_codice_fiscale))
END
