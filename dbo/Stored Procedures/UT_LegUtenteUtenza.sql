-- =============================================
-- Author:		Natale Saviano
-- Create date: 05 luglio 2011
-- Description:	Elenco utenti ricercati per utenza
-- =============================================
CREATE PROCEDURE [dbo].[UT_LegUtenteUtenza]
	@auute_utenza varchar(50)
AS
BEGIN

SET NOCOUNT ON;

	SELECT     
	dbo.tb_auute_ute_sistema.auute_codice_pk AS DB_codice, 
	dbo.tb_auute_ute_sistema.auute_cognome AS DB_cognome, 
	dbo.tb_auute_ute_sistema.auute_nome AS DB_nome, 
	dbo.tb_auruo_ruolo.auruo_descr AS DB_ruolo,
	CASE auute_aussu_codice_pk WHEN 1 THEN 'Attivo' WHEN 2 THEN 'Sospeso' END AS DB_aussu_codice, 
	dbo.tb_auute_ute_sistema.auute_data_inizio_validita AS DB_data_inizio_validita, 
	dbo.tb_auute_ute_sistema.auute_data_fine_validita AS DB_data_fine_validita, dbo.tb_auute_ute_sistema.auute_note AS DB_note, 
	dbo.tb_auute_ute_sistema.auute_utenza AS DB_utenza, dbo.tb_auute_ute_sistema.auute_data_modifica AS DB_data_modifica, 
	dbo.tb_auute_ute_sistema.auute_descr_utente AS DB_descr_utente, 
	dbo.tb_auute_ute_sistema.auute_flag_abilitato AS DB_flag_abilitato

	FROM         
	dbo.tb_auute_ute_sistema 
	INNER JOIN
	dbo.tb_auruo_ruolo ON dbo.tb_auute_ute_sistema.auute_auruo_codice_pk = dbo.tb_auruo_ruolo.auruo_codice_pk

	WHERE auute_utenza = @auute_utenza AND auute_aussu_codice_pk = 1
	ORDER BY auute_utenza ASC
END
