-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UT_ResUtenteCanc]
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
SET   auute_aussu_codice_pk = 1,
      auute_flag_abilitato = 'S',
      auute_data_modifica = GETDATE(),
      auute_descr_utente = @auute_descr_utente
WHERE auute_codice_pk = @auute_codice
AND  auute_aussu_codice_pk = 3
END
