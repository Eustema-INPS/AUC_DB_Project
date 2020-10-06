-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2013.12.10
-- Description:	
-- Descrizione: La stored ritorna le prime 200 aziende la cui denominazione comincia per @denominazione
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDAZIENDE_DENOMINAZIONE] 
	-- Add the parameters for the stored procedure here
	@denominazione varchar(405)
	 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set @denominazione = @denominazione + '%'
	
	Select top 200 ausca_codice_pk, ausca_denominazione,
	ausca_codice_fiscale,ausca_descr_stato_infocamere
	from tb_ausca_sog_contr_az 
	where 
	ausca_denominazione like @denominazione
	
	
	
END

