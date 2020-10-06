-- =============================================
-- Author:        Raffaele
-- Create date:   20-09-2012
-- Description:   Stored Procedura per ricavare il tipo entita
-- =============================================

CREATE PROCEDURE [dbo].[SP_GETTIPOENTITA]
      @codiceEntita int,
      @tipo int
AS

BEGIN
      SET NOCOUNT ON;

      if @tipo = 1
      BEGIN
            SELECT auute_utenza as DB_Valore
            FROM tb_auute_ute_sistema
            WHERE auute_codice_pk = @codiceEntita
      END


      if @tipo = 2
      BEGIN
            SELECT auece_descr as DB_Valore
            FROM tb_auece_ente_cert 
            WHERE auece_codice_pk = @codiceEntita
      END

     
      if @tipo = 3
      BEGIN
            SELECT auapp_app_name as DB_Valore
            FROM tb_auapp_appl
            WHERE auapp_codice_pk = @codiceEntita
      END
END
