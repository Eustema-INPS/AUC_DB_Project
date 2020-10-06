-- =============================================
-- Author:		Italo Paioletti
-- Create date: 18/09/2012
-- Description:	
-- Cancellazione delle tabelle 'foglie' relazionate alla AUSCA 
-- =============================================
CREATE PROCEDURE [dbo].[BA_CancellazioneTabelleTarget]
	
AS
BEGIN
		-- Relazioni Azienda Soggetto collegato 
		-- Cancellazione Relazioni Certificate
		-- Tutte quelle certificate della specifica Azienda
		UPDATE dbo.tb_aurss_rel_sog_sog
		SET aurss_rec_del = 'S', aurss_data_del = GETDATE()
		FROM dbo.tb_aurss_rel_sog_sog INNER JOIN dbo.Import_ausca_sog_contr_azienda ON 
			 tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = Import_ausca_sog_contr_azienda.St_ausca_codice_pk
		WHERE (tb_aurss_rel_sog_sog.aurss_relazione_certificata = 'S') AND 
			  (Import_ausca_sog_contr_azienda.St_ausca_codice_pk IS NOT NULL);	
					  
		-- Cancellazione Relazioni NON Certificate
		-- Puntiale per ausca_codice_pk-ausco_codice_pk-ausco_codice_pk
		UPDATE tb_aurss_rel_sog_sog
		SET aurss_rec_del = 'S', aurss_data_del = GETDATE()
		FROM  tb_aurss_rel_sog_sog INNER JOIN Import_aurss_relazione_soggetto_soggetto ON 
			  tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = Import_aurss_relazione_soggetto_soggetto.St_aurss_ausca_codice_pk AND 
			  tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = Import_aurss_relazione_soggetto_soggetto.St_aurss_ausco_codice_pk AND 
			  tb_aurss_rel_sog_sog.aurss_autis_codice_pk = Import_aurss_relazione_soggetto_soggetto.St_aurss_autis_codice_pk
		WHERE (ISNULL(tb_aurss_rel_sog_sog.aurss_relazione_certificata, 'N') <> 'S');
			  
		-- Unità Locali
		--DELETE FROM tb_auulo_unita_locale
		UPDATE dbo.tb_auulo_unita_locale
		SET auulo_rec_del = 'S', auulo_data_del = GETDATE()
		FROM Import_ausca_sog_contr_azienda INNER JOIN tb_auulo_unita_locale ON 
			 Import_ausca_sog_contr_azienda.St_ausca_codice_pk = tb_auulo_unita_locale.auulo_ausca_codice_pk
		WHERE (Import_ausca_sog_contr_azienda.St_ausca_codice_pk IS NOT NULL);
		
		-- Procedure Concorsuali
		--DELETE FROM dbo.tb_aucon_concorsuale
		UPDATE dbo.tb_aucon_concorsuale
		SET aucon_rec_del = 'S', aucon_data_del = GETDATE()
		FROM dbo.Import_ausca_sog_contr_azienda INNER JOIN dbo.tb_aucon_concorsuale ON 
			 Import_ausca_sog_contr_azienda.St_ausca_codice_pk = tb_aucon_concorsuale.aucon_ausca_codice_pk
		WHERE Import_ausca_sog_contr_azienda.St_ausca_codice_pk IS NOT NULL;
		
		---------------------
		-- Fusioni-Scissioni 
		---------------------
		-- EVENTI
		--DELETE FROM dbo.tb_aueve_eventi
		UPDATE dbo.tb_aueve_eventi
		SET aueve_rec_del = 'S', aueve_data_del = GETDATE()
		FROM tb_aufus_fusioni_scissioni INNER JOIN tb_aueve_eventi ON 
			 tb_aufus_fusioni_scissioni.aufus_codice_pk = tb_aueve_eventi.aueve_aufus_codice_pk 
			 INNER JOIN Import_ausca_sog_contr_azienda ON 
			 tb_aufus_fusioni_scissioni.aufus_ausca_codice_pk = Import_ausca_sog_contr_azienda.St_ausca_codice_pk
		WHERE Import_ausca_sog_contr_azienda.St_ausca_codice_pk IS NOT NULL;
		
		-- FUSIONI SCISSIONI
		--DELETE FROM dbo.tb_aufus_fusioni_scissioni
		UPDATE dbo.tb_aufus_fusioni_scissioni
		SET aufus_rec_del = 'S', aufus_data_del = GETDATE()
		FROM dbo.tb_aufus_fusioni_scissioni INNER JOIN dbo.Import_ausca_sog_contr_azienda ON 
			 tb_aufus_fusioni_scissioni.aufus_ausca_codice_pk = Import_ausca_sog_contr_azienda.St_ausca_codice_pk
		WHERE Import_ausca_sog_contr_azienda.St_ausca_codice_pk IS NOT NULL;
		
		-- SUBENTRI
		--DELETE FROM dbo.tb_ausub_subentri
		UPDATE dbo.tb_ausub_subentri
		SET ausub_rec_del = 'S', ausub_data_del = GETDATE()
		FROM dbo.Import_ausca_sog_contr_azienda INNER JOIN dbo.tb_ausub_subentri ON 
			 Import_ausca_sog_contr_azienda.St_ausca_codice_pk = tb_ausub_subentri.ausub_ausca_codice_pk
		WHERE Import_ausca_sog_contr_azienda.St_ausca_codice_pk IS NOT NULL;
		
END
