-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	lettura della tabella tb_aucfi_cod_fiscale  qualificando
-- =============================================
CREATE PROCEDURE [dbo].[SP_ESISTEAZIENDACF] 
	-- Add the parameters for the stored procedure here
	@codice_fiscale_di_input varchar(16)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [aucfi_codice_pk]
      ,[aucfi_ausca_codice_pk]
      ,[aucfi_data_inizio_validita]
      ,[aucfi_data_fine_validita]
  FROM  [dbo].[tb_aucfi_cod_fiscale]
  WHERE 		
		aucfi_codice_fiscale = @codice_fiscale_di_input
END
