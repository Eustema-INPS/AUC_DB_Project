-- Modificata da: Letizia
-- Data:		16-05-2013
-- Descrizione:	Seleziona il solo codice fiscale
-- =============================================
CREATE PROCEDURE [dbo].[AZ_GetCodiceFiscale] 
	@codiceAzienda int
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT ausca_codice_fiscale as DB_CodiceFiscale from dbo.tb_ausca_sog_contr_az
	where ausca_codice_pk=@codiceAzienda
END
