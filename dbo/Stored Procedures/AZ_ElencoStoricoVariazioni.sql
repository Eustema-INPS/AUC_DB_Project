-- ======================================================================
-- Author:		Quirino Vannimartini
-- Create date: 11/10/2011
-- Description:Stored Procedure per caricare l'elenco dello storico delle variazioni avvenute
--			per l'azienda in input
-- ======================================================================
CREATE PROCEDURE [dbo].[AZ_ElencoStoricoVariazioni]
	@codiceAzienda int
AS
BEGIN

	SET NOCOUNT ON;

--* Selezione dell'elenco variazioni con la data più recente per ogni variabile
	SELECT 
	MAX(auvar_data_variazione)	AS maxData,
	auvar_aueva_nome_var		AS variabile
	INTO #miaTb
	FROM tb_auvar_var_dati
	WHERE auvar_ausca_codice_pk = @codiceAzienda
	GROUP BY auvar_aueva_nome_var


	SELECT 
		Auvar1.auvar_codice_pk					  AS DB_CodiceVariazione,
		Auvar1.auvar_aueva_nome_var				  AS DB_NomeAttributo,
		tb_aueva_elenco_variabili.aueva_descr_var AS DB_DescrAttributo,
		
		CONVERT(varchar(10), Auvar1.auvar_data_variazione, 103)
												AS DB_DataVariazione,
		Auvar1.auvar_valore_originale			AS DB_ValoreIniziale,
		Auvar1.auvar_valore_modificato			AS DB_ValoreFinale,
		CASE Auvar1.auvar_auten_codice_pk 
			WHEN 1 THEN
			(
				SELECT 'U - ' + auute_cognome
				FROM tb_auute_ute_sistema 
				WHERE auute_codice_pk = Auvar1.auvar_codice_entita_rif
			)
			WHEN 2 THEN
			(
				SELECT 'E - ' + auece_descr
				FROM tb_auece_ente_cert  
				WHERE auece_codice_pk = Auvar1.auvar_codice_entita_rif
			)
			WHEN 3 THEN 
			(
				SELECT 'A - ' + auapp_app_name
				FROM tb_auapp_appl 
				--WHERE auapp_aussu_codice_pk = auvar_codice_entita_rif
				WHERE auapp_codice_pk = Auvar1.auvar_codice_entita_rif
			)
		END										AS DB_TipoNomeUtente,
		(
			SELECT COUNT(auvar_codice_pk)
			FROM tb_auvar_var_dati
			WHERE auvar_ausca_codice_pk = @codiceAzienda
			AND auvar_aueva_nome_var = Auvar1.auvar_aueva_nome_var
		)										AS DB_NumeroVariazioni
	FROM
			tb_auvar_var_dati AS Auvar1
	INNER JOIN 
			[#miaTb] ON 
		Auvar1.auvar_data_variazione = [#miaTb].maxData AND
		Auvar1.auvar_aueva_nome_var = [#miaTb].variabile
	INNER JOIN
			tb_aueva_elenco_variabili ON 
		Auvar1.auvar_aueva_nome_var = aueva_nome_var
	INNER JOIN
			tb_auvar_var_dati AS Auvar2 ON
		Auvar2.auvar_aueva_nome_var = Auvar1.auvar_aueva_nome_var AND 
		Auvar2.auvar_data_variazione = Auvar1.auvar_data_variazione
	WHERE 
		Auvar1.auvar_ausca_codice_pk = @codiceAzienda
	GROUP BY 
		Auvar1.auvar_codice_pk,
		Auvar1.auvar_aueva_nome_var,
		Auvar1.auvar_data_variazione,
		Auvar1.auvar_valore_originale,
		Auvar1.auvar_valore_modificato,
		Auvar1.auvar_auten_codice_pk,
		Auvar1.auvar_codice_entita_rif,
		aueva_sequenza, tb_aueva_elenco_variabili.aueva_descr_var
	ORDER BY 
		aueva_sequenza


	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END
