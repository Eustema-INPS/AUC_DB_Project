-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	lettura della tabella tb_auspc_stato_pos_contr_ct
-- qualificando: auspc_descr = stato_pos_contr 
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDSTATOPOSCONTR] 
	-- Add the parameters for the stored procedure here
	@stato_pos_contr varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1000 [auspc_codice_pk]
      ,[auspc_ordinamento]
      ,[auspc_data_modifica]
      ,[auspc_descr_utente]
  FROM  [dbo].[tb_auspc_stato_pos_contr_ct]
  where auspc_descr = @stato_pos_contr 
END
