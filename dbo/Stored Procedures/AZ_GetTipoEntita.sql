-- =============================================
-- Author:		Chiara Pugliese
-- Create date: 24-06-2011
-- Description:	Stored Procedura per ricavare il tipo entita
-- =============================================
CREATE PROCEDURE [dbo].[AZ_GetTipoEntita]
    @codiceEntita int,
	@tipo int

AS
BEGIN
	
	SET NOCOUNT ON;

	if @tipo = 1 
	BEGIN
		SELECT auute_cognome as DB_Valore
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
		--SELECT auapp_descr as DB_Valore
--		SELECT auapp_app_name as DB_Valore
		SELECT auapp_descr as DB_Valore
		FROM tb_auapp_appl 
		--where auapp_aussu_codice_pk = @codiceEntita
		WHERE auapp_codice_pk = @codiceEntita
	END
END
