-- =============================================
-- Author:		Natale Saviano
-- Create date: 07 luglio 2011
-- Description:	Cancellazione logica dell'utente
-- =============================================
CREATE PROCEDURE [dbo].[UT_DelUtente]  
	-- Add the parameters for the stored procedure here
	@auute_codice int,
	@auute_descr_utente varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE  [dbo].[tb_auute_ute_sistema]
SET   auute_aussu_codice_pk = 3,
	  auute_data_modifica = GETDATE(),
	  auute_descr_utente = @auute_descr_utente
WHERE auute_codice_pk = @auute_codice 
END
