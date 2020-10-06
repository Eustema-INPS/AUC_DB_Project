-- =============================================
-- Author:		Natale Saviano
-- Create date: 05 luglio 2011
-- Description:	Cancellazione dalla tabella relazione utente-funzioni
-- =============================================
CREATE PROCEDURE [dbo].[UT_DelUtFunzioni] 
	-- Add the parameters for the stored procedure here
	@auref_aufun_codice_pk int,
	@auref_auten_codice_pk int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM  [dbo].[tb_auref_rel_entita_funz]
      WHERE auref_aufun_codice_pk = @auref_aufun_codice_pk
      AND auref_auten_codice_pk = @auref_auten_codice_pk
END
