-- =============================================
-- Author:		Italo Paioletti
-- Create date: 07/09/2012
-- Popolamento e valorizzazione delle Staging di PRIMO LIVELLO
-- Description:	Aggiorna il campo St_TabName_PRESENTE  qualora il record fosse già presente sul DB Target 
-- =============================================
CREATE PROCEDURE [dbo].[BA_InfoCamere_UpdFK1]
	
AS
BEGIN
	-------------
	-- Passo 1 --
	-- AUSCA   --
	-- Target: Import_ausca_sog_contr_azienda
	-------------
	-- Vengono IDENTIFICATE tutte le righe GIA PRESENTI 
	-- Quindi 
	--		Tutti i record con St_ausca_PRESENTE = 'S' interesseranno l'AGGIORNAMENTO
	--		Tutti i record con St_ausca_PRESENTE = NULL interesseranno l'INSERIMENTO
	
	-----------
	-- AURSS -- 
	-----------
	-- 1.1 Identificazione Scarti 
	
	-- CASO 1
		UPDATE DBO.Import_aurss_relazione_soggetto_soggetto
		SET St_Aurss_FLAG = 1
		WHERE	rtrim(ltrim(St_aurss_CodicefiscaleAzienda)) = '' AND 
				rtrim(ltrim(St_aurss_CodicefiscaleSoggetto)) = '';	
	-- CASO 2
		UPDATE DBO.Import_aurss_relazione_soggetto_soggetto
		SET St_Aurss_FLAG = 2
		WHERE	rtrim(ltrim(St_aurss_CodicefiscaleAzienda)) = '' AND 
				rtrim(ltrim(St_aurss_CodicefiscaleSoggetto)) <> '';
			
	-- CASO 3
		UPDATE DBO.Import_aurss_relazione_soggetto_soggetto
		SET St_Aurss_FLAG = 3
		WHERE	rtrim(ltrim(St_aurss_CodicefiscaleAzienda)) <> '' AND 
				rtrim(ltrim(St_aurss_CodicefiscaleSoggetto)) = '';
			
	-- 1.2 Aggiornamento delle FK 
		
		-- Aggiornamento FK -> AUSCA
		UPDATE dbo.Import_aurss_relazione_soggetto_soggetto
		SET St_aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
		FROM Import_aurss_relazione_soggetto_soggetto INNER JOIN tb_ausca_sog_contr_az 
		ON Import_aurss_relazione_soggetto_soggetto.St_aurss_CodicefiscaleAzienda = 
		tb_ausca_sog_contr_az.ausca_codice_fiscale;


		-- Aggiornamento FK -> AUSCO
		UPDATE dbo.Import_aurss_relazione_soggetto_soggetto
		SET   St_aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk
		FROM  Import_aurss_relazione_soggetto_soggetto INNER JOIN tb_ausco_sog_contr_col 
		ON Import_aurss_relazione_soggetto_soggetto.St_aurss_CodicefiscaleSoggetto = tb_ausco_sog_contr_col.ausco_codice_fiscale;

		-- Aggiornamento FK -> AUTIS
		UPDATE dbo.Import_aurss_relazione_soggetto_soggetto
		SET St_aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
		FROM Import_aurss_relazione_soggetto_soggetto INNER JOIN tb_autis_tipo_sog_col_ct 
		ON Import_aurss_relazione_soggetto_soggetto.St_aurss_CodiceCarica = 
		   tb_autis_tipo_sog_col_ct.autis_codice_carica;
	
	
	
	-- 1.4 UNITA' LOCALI - AUULO
	
		-- 1.4.1	Aggiornamento fk verso Ausca
			
			UPDATE dbo.Import_auulo
			SET auulo_ausca_codice_pk = dbo.tb_ausca_sog_contr_az.ausca_codice_pk
			FROM dbo.Import_auulo INNER JOIN dbo.tb_ausca_sog_contr_az ON 
				 dbo.Import_auulo.auulo_codice_fiscale = dbo.tb_ausca_sog_contr_az.ausca_codice_fiscale;			 
		
		-- 1.4.3	SCARTI : FK verso AUSCA VUOTA (auulo_FLAG = 1)		
			UPDATE dbo.Import_auulo
			SET auulo_FLAG = 1
			WHERE dbo.Import_auulo.auulo_ausca_codice_pk is null;
			

	-- 1.5 PROCEDURE CONCORSUALI - AUCON
	
		-- 1.5.1	Aggiornamento fk verso Ausca
			
			UPDATE dbo.Import_aucon_concorsuale
			SET aucon_ausca_codice_pk = dbo.tb_ausca_sog_contr_az.ausca_codice_pk
			FROM dbo.Import_aucon_concorsuale INNER JOIN dbo.tb_ausca_sog_contr_az ON 
				 dbo.Import_aucon_concorsuale.aucon_codice_fiscale = dbo.tb_ausca_sog_contr_az.ausca_codice_fiscale;
					 				 	
		-- 1.5.3	SCARTI :  (aucon_FLAG = 1)		
			UPDATE dbo.Import_aucon_concorsuale
			SET aucon_FLAG = 1
			WHERE aucon_ausca_codice_pk is null;
			
			
	-- 1.6 Fusioni / Scissioni
		
		-- 1.6.1	Aggiornamento fk verso Ausca
			UPDATE dbo.Import_aufus_fusioni_scissioni
			SET  dbo.Import_aufus_fusioni_scissioni.aufus_ausca_codice_pk = dbo.tb_ausca_sog_contr_az.ausca_codice_pk
			FROM dbo.Import_aufus_fusioni_scissioni INNER JOIN dbo.tb_ausca_sog_contr_az ON 
			dbo.Import_aufus_fusioni_scissioni.aufus_codice_fiscale_AUSCA = dbo.tb_ausca_sog_contr_az.ausca_codice_fiscale;		
				 
		-- 1.6.2	SCARTI :  (aufus_FLAG = 1)		
			UPDATE [dbo].[Import_aufus_fusioni_scissioni]
			SET [aufus_FLAG]  = 1
			WHERE aufus_ausca_codice_pk is null;
				
	-- 1.7 EVENTI
		
		-- 1.7.1	Aggiornamento fk verso Ausca
			UPDATE dbo.Import_aueve_eventi
			SET aueve_ausca_codice_pk = dbo.tb_ausca_sog_contr_az.ausca_codice_pk
			FROM dbo.Import_aueve_eventi INNER JOIN dbo.tb_ausca_sog_contr_az ON 
			     dbo.Import_aueve_eventi.aueve_codice_fiscale_AUSCA = dbo.tb_ausca_sog_contr_az.ausca_codice_fiscale;
				 
		-- 1.7.2	SCARTI :  (aufus_FLAG = 1)		
			UPDATE [dbo].Import_aueve_eventi
			SET [aueve_FLAG]  = 1
			WHERE aueve_ausca_codice_pk is null;
				
	-- 1.8 SUBENTRI
		
		-- 1.8.1	Aggiornamento fk verso Ausca
			UPDATE dbo.Import_ausub_subentri
			SET ausub_ausca_codice_pk = dbo.tb_ausca_sog_contr_az.ausca_codice_pk
			FROM dbo.Import_ausub_subentri INNER JOIN dbo.tb_ausca_sog_contr_az ON 
			     dbo.Import_ausub_subentri.ausub_codice_fiscale = dbo.tb_ausca_sog_contr_az.ausca_codice_fiscale;
				 
		-- 1.7.2	SCARTI :  (aufus_FLAG = 1)		
			UPDATE [dbo].Import_ausub_subentri
			SET [ausub_FLAG]  = 1
			WHERE ausub_ausca_codice_pk is null;
							     
END
