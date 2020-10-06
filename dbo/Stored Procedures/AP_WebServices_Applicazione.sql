-- =============================================
-- Author:		Maurizio Picone, Pietro Trivelli
-- Modificata da Raffaele il 3/10/2016 gestione data
-- =============================================
CREATE PROCEDURE [dbo].[AP_WebServices_Applicazione]

@id_applicazione int

AS
BEGIN
		SET NOCOUNT ON;
		SELECT 
			FUNZIONI.aufun_codice_pk AS CODICE_FUNZIONE,
			CASE 
				WHEN (TABELLA_APPOGGIO.aufun_codice_pk is null) then 'NO'
--				WHEN (CONVERT(DATETIME,CONVERT(VARCHAR(10), TABELLA_APPOGGIO.auref_data_inizio_validita,103),103) >= GETDATE() and CONVERT(DATETIME,CONVERT(VARCHAR(10), TABELLA_APPOGGIO.auref_data_fine_validita,103),103) <= GETDATE()) 
				WHEN (CONVERT(DATETIME,CONVERT(VARCHAR(10), TABELLA_APPOGGIO.auref_data_inizio_validita,103),103) >= convert(date,GETDATE(),103) and CONVERT(DATETIME,CONVERT(VARCHAR(10), TABELLA_APPOGGIO.auref_data_fine_validita,103),103) <= convert(date,GETDATE(),103)) 
				THEN 'SI'
			    ELSE 'SI' 
			END AS ASSOCIATA,
			
			FUNZIONI.aufun_descr AS DESCRIZIONE_FUNZIONE, 
			CONVERT(VARCHAR(10), TABELLA_APPOGGIO.auref_data_inizio_validita,103) AS DATA_INIZIO_VAL, 
			CONVERT(VARCHAR(10), TABELLA_APPOGGIO.auref_data_fine_validita,103)  AS DATA_FINE_VAL,
			FUNZIONI.[aufun_raggruppamento] as RAGGRUPPAMENTO,
			TABELLA_APPOGGIO.auref_codice_entita_rif as CODICE_APPLICAZIONE,
			TABELLA_APPOGGIO.auref_codice_pk as CODICE_RELAZIONE
			
		FROM dbo.tb_aufun_funz_sistema FUNZIONI left outer join

		(SELECT     
		dbo.tb_aufun_funz_sistema.aufun_codice_pk, 
		dbo.tb_aufun_funz_sistema.aufun_funzione, 
		dbo.tb_aufun_funz_sistema.aufun_raggruppamento, 
		dbo.tb_aufun_funz_sistema.aufun_tipo_funzione, 
		dbo.tb_aufun_funz_sistema.aufun_descr, 
		dbo.tb_aufun_funz_sistema.aufun_flag_abilitato, 
		dbo.tb_aufun_funz_sistema.aufun_data_modifica, 
		dbo.tb_aufun_funz_sistema.aufun_descr_utente, 
		dbo.tb_auref_rel_entita_funz.*

		FROM         
		dbo.tb_aufun_funz_sistema 
		INNER JOIN
		dbo.tb_auref_rel_entita_funz ON dbo.tb_aufun_funz_sistema.aufun_codice_pk = dbo.tb_auref_rel_entita_funz.auref_aufun_codice_pk

		WHERE     
		dbo.tb_auref_rel_entita_funz.auref_auten_codice_pk = 3 
		and dbo.tb_auref_rel_entita_funz.auref_codice_entita_rif = @id_applicazione) TABELLA_APPOGGIO
		 
		on FUNZIONI.aufun_codice_pk = TABELLA_APPOGGIO.aufun_codice_pk

		WHERE (FUNZIONI.aufun_tipo_funzione = 'W' AND FUNZIONI.aufun_flag_abilitato = 'S')
END
