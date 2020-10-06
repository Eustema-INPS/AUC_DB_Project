



-- =============================================
-- Author:		Peter Dimpflmeier
-- Create date: 2016.04.14
-- Description:	
-- Descrizione: La stored ritorna le aziende la cui denominazione contiene @denominazione
--              e che risultano avere posizioni di tipo navale
-- =============================================
CREATE PROCEDURE [dbo].[SP_FIND_ARMATORI_DENOM] 
	-- Add the parameters for the stored procedure here
	@denominazione varchar(405)
	 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	set @denominazione = @denominazione + '%'
	
	Select 
	ausca_codice_pk, 
	ausca_contro_codice, 
	ausca_denominazione,
	ausca_codice_fiscale, 
	ausca_toponimo, 
	ausca_indirizzo, 
	ausca_civico, 
	ausca_descr_comune, 
	ausca_sigla_provincia, 
	ausca_cap

	from tb_ausca_sog_contr_az 

	where 
	ausca_denominazione like @denominazione
	and ausca_armatore = 'S'

	order by ausca_denominazione
	
	
END


