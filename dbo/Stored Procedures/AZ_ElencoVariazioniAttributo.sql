-- ======================================================================
-- Author:		Quirino Vannimartini
-- Create date: 12/10/2011
-- Description:Stored Procedure per caricare l'elenco delle variazioni avvenute per il singolo
--			attributo per l'azienda in input
-- ======================================================================
CREATE PROCEDURE [dbo].[AZ_ElencoVariazioniAttributo]
	@codiceAzienda int,
	@nomeAttributo varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		auvar_aueva_nome_var		AS DB_Attributo,
		auvar_valore_originale		AS DB_ValoreIniziale,
		auvar_valore_modificato		AS DB_ValoreFinale,
		CONVERT(varchar(10), auvar_data_variazione, 103)
									AS DB_DataVariazione,
		CASE auvar_auten_codice_pk 
			WHEN 1 THEN
			(
				SELECT 'U - ' + auute_cognome
				FROM tb_auute_ute_sistema 
				WHERE auute_codice_pk = auvar_codice_entita_rif
			)
			WHEN 2 THEN
			(
				SELECT 'E - ' + auece_descr
				FROM tb_auece_ente_cert  
				WHERE auece_codice_pk = auvar_codice_entita_rif
			)
			WHEN 3 THEN 
			(
				SELECT 'A - ' + auapp_app_name
				FROM tb_auapp_appl 
				WHERE auapp_codice_pk = auvar_codice_entita_rif
			)
		END							AS DB_TipoNomeUtente
	FROM tb_auvar_var_dati
	WHERE 
		auvar_ausca_codice_pk = @codiceAzienda AND
		auvar_aueva_nome_var = @nomeAttributo
	ORDER BY 
		auvar_data_variazione DESC


	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END
