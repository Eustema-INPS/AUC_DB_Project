

-- =============================================
-- Author:		Chiara Pugliese
-- Create date: 23-06-2011
-- Description:	Stored per caricare la scheda anagrafica azienda
-- =============================================
-- =============================================
-- Author:		Letizia Bellantoni
-- Modifica date: 08-05-2012
-- Description:	Aggiunte nuovi campi da visualizzare
-- =============================================
-- =============================================
-- Author:		Raffaele
-- Modifica date: 27-07-2012
-- Description:	Nella fase di abilitazione dei pulsanti per i soggetti collegati e delegati 
--              tolti i vincoli temporali 
-- =============================================
-- =============================================
-- Author:		Raffaele
-- Modifica date: 20-09-2012
-- Description:	Erano invertiti i nomi delle variabili ausca_auten_codice_pk e ausca_codice_entita_rif
-- =============================================
-- =============================================
-- Author:		Raffaele
-- Modifica date: 19-10-2012
-- Description:	Rimessi i nomi delle variabili ausca_auten_codice_pk e ausca_codice_entita_rif come erano prima...
-- =============================================
-- =============================================
-- Author:		Raffaele
-- Modifica date: 07-11-2012
-- Description:	Per la sede legale modificata anche la condizione che se il parametro è N si pone a NO
--              altrimenti e' sempre SI.
-- Modificata da: Raffaele
-- Data:		01.02.2013
-- Descrizione:	Modificato il criterio di estrazione dei soggetti collegati: non considera i
--              rappresentanti legali
-- =============================================
-- Modificata da: Letizia
-- Data:		04.04.2013
-- Descrizione:	Eliminata la selezione dei soggetti delegati
-- =============================================
-- Modificata da: Raffaele
-- Data:		26.06.2013
-- Descrizione:	Sostituito i valore di aungi_descr_lunga con aungi_descr_altern
-- =============================================
-- ===============================================================================================
-- Modificata da:  Quirino Vannimartini
-- Data modifica:  27/02/2014
-- Description:	Aggiunta reperimento Dati relativi alla Gestione Separata - Dati legati ad AUSCA
--					Lista delle Attività
--					Codici Fiscali Confluiti
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  02/05/2014
-- Description:	Aggiunta gestione codici Ateco 2002 e 2007
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da:	Raffaele
-- Data modifica:	23/05/2014
-- Description:		Corretta l'estrazione dei codici ateco 2002 e 2007: si estraevano i codici_pk invece degli ateco
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da:	letizia
-- Data modifica:	23/06/2014
-- Description:		Lista Attività spostata in dettaglio pos. contributiva
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia
-- Data:		2015.04.27
-- Descrizione:	AI 3106
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia
-- Data:		2015.05.05
-- Descrizione:	AI 3108
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia
-- Data:		2015.07.14
-- Descrizione:	Aggiunti [ausca_cert_cod_entita_rif],[ausca_cert_auten_cod_pk]
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Stefano Panuccio
-- Data:		2017.07.18
-- Descrizione:	AI3114 - Aggiunti [ausca_armatore]
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Stefano Panuccio
-- Data:		2017.08.08
-- Descrizione:	AI3116 - Aggiunti campi
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Emanuela
-- Data:		2017.10.18
-- Descrizione:	AI3117 - Aggiunta campi [ausca_comune_esteso_ted], [ausca_cod_com_ISTAT], [ausca_cod_com_Belfiore]
-- ===============================================================================================
CREATE PROCEDURE [dbo].[AZ_SchedaAnagraficaAzienda] 
	@codiceAzienda int
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT 
		ausca_codice_pk					AS DB_CodiceAzienda,
		ausca_contro_codice				AS DB_ControCodice,
		ausca_denominazione				AS DB_Denominazione,
		ausca_cognome                   AS DB_Cognome,
		ausca_nome						AS DB_Nome,
		ausca_codice_fiscale 			AS DB_CodiceFiscale,
		ausca_piva						AS DB_Piva,
		ausca_localita 					AS DB_Localita,
		ausca_sigla_provincia 			AS DB_SiglaProvincia,
		ausca_codice_toponimo 			AS DB_CodiceToponimo,
		ausca_toponimo 					AS DB_Toponimo,
		ausca_indirizzo 				AS DB_Indirizzo,
		ausca_civico 					AS DB_Civico,
		ausca_descr_comune 				AS DB_Comune,
		ausca_frazione 					AS DB_Frazione,
		ausca_regione 					AS DB_Regione,
		ausca_cap 						AS DB_Cap,
		ausca_soggetto_certificato 		AS DB_SoggettoCertificato,
		ausca_auten_codice_pk 		    AS DB_CodiceTipoEntita,
		ausca_codice_entita_rif         AS DB_CodiceEntita,
		ausca_cert_auten_cod_pk         AS DB_CodiceTipoEntitaSC,
		ausca_cert_cod_entita_rif		AS DB_CodiceEntitaSC,
		--ausca_auten_codice_pk 		AS DB_CodiceEntita,
		--ausca_codice_entita_rif       AS DB_CodiceTipoEntitA,
		--aungi_descr_lunga 				AS DB_NaturaGiuridica,
		aungi_descr_altern 				AS DB_NaturaGiuridica,		
		ausca_comune_esteso_ted			AS DB_ComuneEstesoTed,
		ausca_cod_com_ISTAT				AS DB_codComuneISTAT,
		ausca_cod_com_Belfiore 			AS DB_codComuneBelfiore,

		CASE ausca_sede_legale_italia
			WHEN 'S' THEN 'SI'
			ELSE 'NO'
		END 							AS DB_SedeLegaleItalia,
		ausca_telefono1 				AS DB_Telefono1,
		ausca_telefono2 				AS DB_Telefono2,
		ausca_telefono3 				AS DB_Telefono3,
		ausca_fax	 					AS DB_Fax,
		ausca_email						AS DB_Email,
		ausca_PEC	 					AS DB_Pec,
		ausca_PEC_IVA	 				AS DB_Pec_IVA,
		ausca_pec_sin	 				AS DB_Pec_Sin,
		isnull(nullif([ausca_legalmail], ''), [ausca_pec_iva])					AS DB_LegalMail,  -- G.C. 2020-02-18
		ausca_note						AS DB_Note,
		--ausca_n_rea_visura				AS DB_Nrea,
		ausca_n_rea						AS DB_Nrea,
		ausca_cciaa						AS DB_Cciaa,
		ausca_attivita_lingua_alt		AS DB_AttivitaLingua,
		CONVERT(varchar(10), ausca_data_inizio_attivita, 103) AS DB_DataInizioAtt,
		CONVERT(varchar(10), ausca_data_fine_attivita, 103)   AS DB_DataFineAtt,
		ausca_ateco						AS DB_Ateco,
		ausca_desateco					AS DB_DescrAteco,
		tb_auate_cod_ateco_ct.auate_cod_ateco_complessivo     AS DB_Ateco91,
		tb_auate_cod_ateco_ct.auate_cod_sottocategoria_tit	AS DB_DescrAteco91,
		--Letizia 02-05-2014 aggiunta gestione codici ateco 2002-2007
		Ateco2002.auate_cod_ateco_complessivo as DB_Ateco2002,
		Ateco2002.auate_cod_sottocategoria_tit as DB_DescrAteco2002,
		Ateco2007.auate_cod_ateco_complessivo as DB_Ateco2007,
		Ateco2007.auate_cod_sottocategoria_tit as DB_DescrAteco2007,
		--AI 3106
		ausca_cod_assoc_AC as DB_CodiceAssociazione,
		ausca_nome_assoc_AC as DB_NomeAssociazione,
		convert(varchar(10),ausca_data_inizio_AC,103) as DataInizioArtComm,
		convert(varchar(10),ausca_data_fine_AC,103) as DataFineArtComm,
		--AI 3106
		
		--AI 3108
		--COOP
		convert(varchar(10),ausca_coop_data_presentazione,103) as DB_CoopDataPresentazione,
		ausca_coop_num_iscrizione as DB_CoopNumIscrizione,
		convert(varchar(10),ausca_coop_data_iscrizione,103)  as DB_CoopDataIscrizione,
		ausca_coop_cod_sezione as DB_CoopCodSezione,
		ausca_coop_sezione as DB_CoopSezione,
		ausca_coop_cod_sottosezione as DB_CoopCodSottosezione,
		ausca_coop_sottosezione as DB_CoopSottosezione,
		ausca_coop_cod_categoria as DB_CoopCodCategoria,
		ausca_coop_categoria as DB_CoopCategoria,
		ausca_coop_cod_categoria_attiv_eserc as DB_CoopCodCategoriaAttivEserc,
		ausca_coop_categoria_attiv_eserc as DB_CoopCategoriaAttivEserc,
		--ARTIGIANI
		
		ausca_art_categoria as DB_ArtCategoria,
		ausca_art_descr_categoria as DB_ArtDescrCategoria,
		ausca_art_num_iscrizione_ruolo as DB_NumIscrizioneRuolo,
		ausca_art_provincia_iscrizione_ruolo as DB_ArtProvinciaIscrizioneRuolo,
		convert(varchar(10),ausca_art_data_accertamento,103) as DB_ArtDataAccertamento,
		convert(varchar(10),ausca_art_data_domanda,103) as DB_ArtDataDomanda,
		convert(varchar(10),ausca_art_data_domanda_accertamento,103) as DB_ArtDataDomandaAccertamento,
		convert(varchar(10),ausca_art_data_iscrizione,103) as DB_ArtDataIscrizione,
		convert(varchar(10),ausca_art_data_delibera,103) as DB_ArtDataDelibera,
		convert(varchar(10),ausca_art_data_iscrizione_inizio,103) as DB_ArtDataIscrizioneInizio,
		convert(varchar(10),ausca_art_data_inizio,103) as DB_ArtDataInizio,
		ausca_art_info_suppl as DB_ArtInfoSuppl,
	    ausca_art_causale_cess as DB_ArtCausaleCess,
		ausca_art_descr_causale_cess as DB_ArtDescrCausaleCess,
		convert(varchar(10),ausca_art_data_domanda_accert_cess,103) as DB_ArtDataDomandaAccertCess,
		convert(varchar(10),ausca_art_data_delibera_cess,103) as DB_ArtDataDeliberaCess,
		convert(varchar(10),ausca_art_data_cessazione,103) as DB_ArtDataCessazione,
		CASE ausca_armatore
			WHEN 'S' THEN 'SI'
			ELSE 'NO'
		END as DB_Armatore,
		--AI 3116:
		ausca_n_iscrizione_ri as DB_NIscrizioneRI,
		ausca_c_fonte as DB_CodiceFonte,
		ausca_f_aggiornamento as DB_FaseAggiornamento,
		convert(varchar(10),ausca_dt_annotazione,103) as DB_DataAnnotazione,
		convert(varchar(10),ausca_dt_iscrizione_rea,103) as DB_DataIscrizioneRea,
		convert(varchar(10),ausca_dt_iscrizione_ri,103) as DB_DataIscrizioneRi,
		ausca_codice_iscrizione_01 as DB_CodiceIscrizione01,
		convert(varchar(10),ausca_dt_iscrizione_sezione_01,103) as DB_DataIscrizioneSezione01,
		ausca_f_colt_diretto_01 as DB_ColtivatoreDiretto01,
		ausca_codice_iscrizione_02 as DB_CodiceIscrizione02,
		convert(varchar(10),ausca_dt_iscrizione_sezione_02,103) as DB_DataIscrizioneSezione02,
		ausca_f_colt_diretto_02 as DB_ColtivatoreDiretto02,
		ausca_codice_iscrizione_03 as DB_CodiceIscrizione03,
		convert(varchar(10),ausca_dt_iscrizione_sezione_03,103) as DB_DataIscrizioneSezione03,
		ausca_f_colt_diretto_03 as DB_ColtivatoreDiretto03,
		ausca_c_stato as DB_Stato,
		convert(varchar(10),ausca_dt_inizio_attivita_impresa,103) as DB_DataInizioAttivitaImpresa,
		ausca_c_causale_canc as DB_CodiceCausaleCanc,
		ausca_causale_cancellazione as DB_CausaleCancellazione,
		convert(varchar(10),ausca_dt_cessazione_canc,103) as DB_DataCessazioneCanc,
		convert(varchar(10),ausca_dt_domanda_canc,103) as DB_DataDomandaCanc,
		convert(varchar(10),ausca_dt_cessazione_att_canc,103) as DB_DataCessazioneAttCanc,
		convert(varchar(10),ausca_dt_canc_canc,103) as DB_DataCancCanc,
		ausca_codice_tipo_trasferimento as DB_CodiceTipoTrasferimento,
		convert(varchar(10),ausca_dt_cessazione_trasferimento,103) as DB_DataCessazioneTrasferimento,
		ausca_codice_causale_trasferimento as DB_CodiceCausaleTrasferimento,
		--AI 3116.
		
		--AI 3108
		(SELECT COUNT(aucon_ausca_codice_pk) FROM dbo.tb_aucon_concorsuale WHERE aucon_ausca_codice_pk = @codiceAzienda) as DB_ProcedureConcorsuali,
		
		-- Fusioni/Scissioni - Tabella <auces> dismessa, sostituita con <aufus> 
		(SELECT COUNT(aufus_codice_pk)       FROM dbo.tb_aufus_fusioni_scissioni WHERE aufus_ausca_codice_pk = @codiceAzienda) as DB_FusioniCessioni,
		
		(SELECT COUNT(auulo_ausca_codice_pk) FROM dbo.tb_auulo_unita_locale WHERE auulo_ausca_codice_pk = @codiceAzienda) as DB_UnitaLocali,
		
		-- Subentri
		(SELECT COUNT(ausub_ausca_codice_pk) FROM dbo.tb_ausub_subentri A WHERE A.ausub_ausca_codice_pk = @codiceAzienda) as DB_Subentri,

--INIZIO modifca Quirino 27/02/2014
		-- Lista delle Attività
	    --	(SELECT COUNT(aulat_ausca_codice_PK) FROM dbo.tb_aulat_lista_attivita WHERE aulat_ausca_codice_PK = @codiceAzienda) as DB_ListaAttivita,
		
		-- Elenco Codici Fiscali Confluiti
		(SELECT COUNT(aucfc_ausca_codice_PK) FROM dbo.tb_aucfc_cfconfluiti WHERE aucfc_ausca_codice_PK = @codiceAzienda) as DB_CodiciFiscaliConfluiti,
--FINE modifca Quirino 27/02/2014

		/* Verifica Presenza Sogg. Delegati - Maurizio */
		--(SELECT COUNT(audel_codice_pk) 
		--FROM
		--	tb_audel_del 
			--INNER JOIN
			--tb_aurad_rel_az_del ON 
			--	audel_codice_pk = aurad_audel_codice_pk INNER JOIN
			--tb_autid_tipo_del_ct ON 
			--	aurad_autid_codice_pk = autid_codice_pk INNER JOIN
			--tb_aupoc_pos_contr ON 
			--	aurad_aupoc_codice_pk = aupoc_codice_pk INNER JOIN
			--tb_ausca_sog_contr_az ON 
			--	aupoc_ausca_codice_pk = ausca_codice_pk INNER JOIN
			--tb_auapp_appl ON 
			--	aupoc_auapp_codice_pk = auapp_codice_pk
	 --   WHERE 
		--	ausca_codice_pk = @codiceAzienda 
		--) AS DB_SoggettiDelegati,
		
		/* Verifica Presenza Rapp. Legali - Maurizio 
		(SELECT COUNT(tb_ausco_sog_contr_col.ausco_codice_pk)    		
		FROM         
			tb_ausca_sog_contr_az INNER JOIN
			tb_aurss_rel_sog_sog ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aurss_rel_sog_sog.aurss_ausca_codice_pk INNER JOIN
			tb_ausco_sog_contr_col ON tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk INNER JOIN
			tb_autis_tipo_sog_col_ct ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
		WHERE ausca_codice_pk = @codiceAzienda 
		AND aurss_rappresentante_legale = 'S'
		) AS DB_RappresentantiLegali */
		
		/* Verifica Presenza Sogg. Collegati - Quirino */
		(SELECT COUNT(ausco_codice_pk) 
		FROM
			tb_ausca_sog_contr_az INNER JOIN
			tb_aurss_rel_sog_sog ON 
				tb_ausca_sog_contr_az.ausca_codice_pk = tb_aurss_rel_sog_sog.aurss_ausca_codice_pk INNER JOIN
			tb_ausco_sog_contr_col ON 
				tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk INNER JOIN
			tb_autis_tipo_sog_col_ct ON 
				tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
		WHERE 
		
			ausca_codice_pk = @codiceAzienda AND (aurss_rappresentante_legale = 'N' or aurss_rappresentante_legale is null or aurss_rappresentante_legale = '')
-- Modificato da Raffaele 27 luglio 2012 per consentire la visualizzazione dei legami scaduti 
--            in quanto esistono aziende solo con legami scaduti che non si vedrebbero mai. 
			--ausca_codice_pk = @codiceAzienda AND 
			--(tb_aurss_rel_sog_sog.aurss_data_di_fine_validita >= GETDATE() AND
			--tb_aurss_rel_sog_sog.aurss_data_inizio_validita <= GETDATE() )
		) AS DB_SoggettiCollegati
	
	FROM
		tb_ausca_sog_contr_az 
	LEFT OUTER JOIN
		tb_aungi_nat_giur_ct ON 
			tb_ausca_sog_contr_az.ausca_aungi_codice_pk = tb_aungi_nat_giur_ct.aungi_codice_pk
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct ON
		tb_auate_cod_ateco_ct.auate_codice_pk=tb_ausca_sog_contr_az.ausca_auate_1991_codice_pk
	--Letizia 02-05-2014 aggiunta gestione codici ateco 2002-2007
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as Ateco2007 ON
		Ateco2007.auate_codice_pk=tb_ausca_sog_contr_az.ausca_auate_2007_codice_pk
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as Ateco2002 ON
		Ateco2002.auate_codice_pk=tb_ausca_sog_contr_az.ausca_auate_2002_codice_pk
	WHERE 
		ausca_codice_pk = @codiceAzienda
END


