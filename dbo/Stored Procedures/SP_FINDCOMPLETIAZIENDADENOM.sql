
-- =============================================
-- Author:		Martini & Picone
-- Create date: 
-- Description:	lettura della tabella tb_ausca_sog_contr_az   qualificando:
--	ausca_denominazione = denominazione di input per tipo operazione = 2
--	ausca_denominazione like ‘denominazione%’  di input per tipo operazione = 3
--	ausca_denominazione like ‘%denominazione%’  di input per tipo operazione = 4
-- =============================================
-- =====================================================================
-- Description:   AI 2060 Description:	modifica struttura DatiSecondariAzienza, aggiunto attributo descr_soggetto_certificatore
-- Modificato da: Letizia 
-- Data:		  2015.04.20
-- =====================================================================
-- =====================================================================
-- Description:   AI 2061 Description:	modifica struttura DatiSecondariAzienza, aggiunto attributo ausca_codice_stato_infocamere
-- Modificato da: Letizia 
-- Data:		  2015.09.09
-- =====================================================================
-- =====================================================================
-- Description: Sostituito ausca_codice_comune in ausca_cod_com_Belfiore (AI 2086)
-- Modificato da: Raffaele
-- Data			  2018.07.10
-- =====================================================================
CREATE PROCEDURE [dbo].[SP_FINDCOMPLETIAZIENDADENOM] 
	@denominazione varchar(405), 
	@tipo_operazione int = 0
AS
BEGIN
	SET NOCOUNT ON;


	if @tipo_operazione = 3   
		BEGIN
				SET @denominazione = @denominazione  + '%'
		END
	else if @tipo_operazione = 4   
		BEGIN
			SET @denominazione = '%' + @denominazione  + '%'
		END

	if (@tipo_operazione = 2 or @tipo_operazione = 3 or @tipo_operazione = 4)
		BEGIN
			SELECT 
			   [ausca_codice_pk]
			  ,[ausca_denominazione]
			  ,[ausca_codice_fiscale]
			  ,[ausca_aungi_codice_pk]
			  ,[aungi_descr_lunga]
			  ,[ausca_cciaa]
			  ,[ausca_codice_toponimo]
			  ,[ausca_indirizzo]
			  ,[ausca_civico]
			  ,[ausca_localita]
			  ,[ausca_sede_legale_italia]
			  ,ausca_cod_com_Belfiore --(AI 2086)
			  ,[ausca_descr_comune]
			  ,[ausca_frazione]
			  ,[ausca_sigla_provincia]
			  ,[ausca_regione]
			  ,[ausca_codice_stato_estero]
			  --,[stato_estero]
			  ,[ausca_cap]
			  ,[ausca_telefono1]
			  ,[ausca_telefono2]
			  ,[ausca_telefono3]
			  ,[ausca_fax]
			  ,[ausca_telex]
			  ,[ausca_email]
			  ,[ausca_PEC]
			  ,isnull(nullif([ausca_legalmail], ''), [ausca_pec_iva]) [ausca_legalmail]  -- G.C. 2020-02-18
			  ,[ausca_n_rea]
			  ,[ausca_auate_codice_pk]
			  ,[auate_cod_sezione_tit]
			  -- Riorganizzazione Inquadramento 2 - Attività 29:
			  -- ,[auate_cod_ateco_complessivo] 
			  ,LEFT(auate_cod_ateco_complessivo + '000000', 6)
			  -- Riorganizzazione Inquadramento 2 - Attività 29.
			  ,[ausca_soggetto_certificato]
			  ,[ausca_data_variazione_stato]
			  ,[ausca_auten_codice_pk]
			  ,[auten_descr]
			  ,[ausca_codice_entita_rif]
			  ,[ausca_note]
			  ,[ausca_data_modifica]
			  ,[ausca_descr_utente]
			  ,[ausca_toponimo]
		            

				--2014.04.17: se cognome e nome sono nulli in AUSCA, si leggono da AUSCO
				--,[ausca_cognome] -- rel.2      
				--,[ausca_nome] -- rel.2
				,ISNULL([ausca_cognome], [ausco_cognome]) as ausca_cognome      
				,ISNULL([ausca_nome], [ausco_nome]) as ausca_nome      
				--2014.04.17.

			  ,[ausca_codice_comune_istat] -- rel.2
			  ,[ausca_codice_qualita_ind] -- rel.2
			  ,[ausca_contro_codice] -- rel.2
			  
			  -----------------------------------------------------
			  -- CODICE FORMA - Modifica 20 Settembre 2012
			  -----------------------------------------------------
			  ,aungi_codice_forma,
			  
			  -----------------------------------------------------
			  -- UTENTE / APPLICAZIONE - Modifica 20 Settembre 2012
			  -----------------------------------------------------
			  
			  --modifica Peter 2013.03.20:
			  case 
			  when ausca_auten_codice_pk = 1 then 
			  (
				SELECT auute_utenza 
				FROM tb_auute_ute_sistema
				WHERE auute_codice_pk = ausca_codice_entita_rif
			  )
			  when ausca_auten_codice_pk = 2 then 
			  (
				 SELECT auece_descr as DB_Valore_Utente
				 FROM tb_auece_ente_cert 
				 WHERE auece_codice_pk = ausca_codice_entita_rif
			  )
			  when ausca_auten_codice_pk = 3 then 
			  (
				 SELECT auapp_app_name as DB_Valore_Utente
				 FROM tb_auapp_appl
				 WHERE auapp_codice_pk = ausca_codice_entita_rif
			  )
			  else ''
			  end as DB_Valore_Utente 	 
			  --modifica Peter 2013.03.20.

			--AI 2056:

			,[ausca_codice_gruppo_enpals]
			,[ausca_codice_gestione]               
			,[ausca_provenienza_cert_gs]           
			,[ausca_data_certificazione_gs]

			,case when ausca_auten_codice_pk = 1 then
			(
			SELECT auute_utenza
			FROM tb_auute_ute_sistema
			WHERE auute_codice_pk = ausca_codice_entita_rif
			)
			when ausca_auten_codice_pk = 2 then
			(
			SELECT auece_descr
			FROM tb_auece_ente_cert
			WHERE auece_codice_pk = ausca_codice_entita_rif
			)
			when ausca_auten_codice_pk = 3 then
			(
			SELECT     tb_aurea_area_gestione.aurea_descrizione
			FROM        tb_auapp_appl LEFT OUTER JOIN
			tb_aurea_area_gestione ON tb_auapp_appl.auapp_aurea_codice_pk = tb_aurea_area_gestione.aurea_codice_pk
			WHERE     (tb_auapp_appl.auapp_codice_pk = ausca_codice_entita_rif)
			)
			else 'Non definita'
			end as fonte_acquisizione,
			--AI 2056
			
			--AI 2060
			case when [ausca_cert_auten_cod_pk] = 2 and [ausca_soggetto_certificato]='S' then
			(
			SELECT auece_descr
			FROM tb_auece_ente_cert
			WHERE auece_codice_pk = [ausca_cert_cod_entita_rif]
			)
			end as descr_soggetto_certificatore,
			--AI 2060
	      
		  	--AI 2061
			case when	ausca_codice_stato_infocamere is null or ausca_codice_stato_infocamere='' then 'A'
			else ausca_codice_stato_infocamere
			end as ausca_codice_stato_infocamere
			--AI 2061

			FROM  [dbo].[tb_ausca_sog_contr_az]
			
			left outer join  [dbo].[tb_aungi_nat_giur_ct]
			on tb_ausca_sog_contr_az.ausca_aungi_codice_pk=tb_aungi_nat_giur_ct.aungi_codice_pk 
			
			left outer join  [dbo].tb_auate_cod_ateco_ct
			on tb_ausca_sog_contr_az.ausca_auate_codice_pk=tb_auate_cod_ateco_ct.auate_codice_pk
			
			left outer join  [dbo].tb_auten_tipo_entita_ct
			on tb_ausca_sog_contr_az.ausca_auten_codice_pk=tb_auten_tipo_entita_ct.auten_codice_pk
			
			  --2014.04.17: se cognome e nome sono nulli in AUSCA, si leggono da AUSCO
			  left outer join  [dbo].tb_ausco_sog_contr_col
			  on tb_ausca_sog_contr_az.ausca_codice_fiscale = tb_ausco_sog_contr_col.ausco_codice_fiscale
			  --2014.04.17.

			WHERE ausca_denominazione LIKE @denominazione
		END

END

