

-- ======================================================================
-- Author:		Quirino Vannimartini
-- Create date: 17/10/2011
-- Description:	Stored Procedure per la ricerca del dettaglio della 
-- 			Posizione contributiva in input
-- ======================================================================

-- ======================================================================
-- Modificata da:  Quirino Vannimartini
-- Data modifica:  02/04/2012
-- Description:	Utilizzo delle nuove tabelle interne
-- ======================================================================

-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  06/12/2012
-- Description:	Utilizzo della FK aupoc_ausin_codice_pk
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  07/05/2013
-- Description:	Aggiunti campi per la gestione di Inpad e Enpals
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  09/05/2013
-- Description:	Aggiunti campo tipologia posizione
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  16/05/2013
-- Description:	Aggiunti campo codice comportamento
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  20/06/2013
-- Description:	Aggiunti campo data ultimo stato e commentate altre date (cessaz, sospensione etc)
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  21/06/2013
-- Description:	Aggiunti gestione riferimenti posizione primaria/secondaria
-- ======================================================================
-- ======================================================================
-- Modificata da:  Quirino Vannimartini
-- Data modifica:  23/09/2013
-- Description:	Aggiunta degli attributi istat in visualizzazione per gli Agricoli
-- ======================================================================
-- ======================================================================
-- Modificata da:  Quirino Vannimartini
-- Data modifica:  24/02/2014
-- Description:	Modifica visualizzazione campo "Tipo posizione" per Gestione separata
-- ======================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  17/06/2014
-- Description:	Aggiunta gestione codici Ateco 2002 e 2007
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  17/06/2014
-- Description:	Aggiunta gestione data domanda iscrizione
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  23/06/2014
-- Description:	Aggiunta lista attività
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  23/07/2014
-- Description:	Aggiunta codice aurea DB_GestioneCodAurea
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  2014.10.09
-- Description:	Aggiunta campi data inizio e fine validità di aupco
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  2015.03.26
-- Description:	Gestione Ateco, riferimento a aupco per Cod AUREA =1
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  2015.04.23
-- Description:	AI 3106
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  2015.04.30
-- Description:	AI 3107
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  2015.05.18
-- Description:	Aggiornato gestione tipo aupoc posizione con codice aurea=12
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Letizia Bellantoni
-- Data modifica:  2015.05.20
-- Description:	Aggiunta gestione Professionisti GS con codice aurea=12
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Raffaele Palmieri
-- Data modifica:  2016.06.13
-- Description:	Aggiunta gestione Datori Voucher GS con codice aurea=13
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Panuccio
-- Data modifica:  2017.07.18
-- Description:	AI 3114 Aggiunto attributo navale
-- ===============================================================================================
-- ===============================================================================================
-- Modificata da: Panuccio
-- Data modifica:  2017.07.27
-- Description:	AI 3115 Aggiunta posizione in output
-- ===============================================================================================
CREATE PROCEDURE [dbo].[AZ_DettaglioPosizioneContributiva]
	@codice_pk int
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		----aupoc_sede_provinciale				AS DB_CodSedeProvinciale,
		--CASE LEN(CONVERT(VARCHAR(2), aupoc_sede_provinciale))
		--	WHEN 1 THEN '0' + CONVERT(VARCHAR(2), aupoc_sede_provinciale)
		--	ELSE CONVERT(VARCHAR(2), aupoc_sede_provinciale)
		--END									AS DB_CodSedeProvinciale,
        
        -- Modificato da Raffaele 29/05/2012
		--SUBSTRING(aupoc_cod_sede_INPS,3,4)	AS DB_CodSedeProvinciale,
        --SUBSTRING(aupoc_cod_sede_INPS,3,4) + ' - ' +  tb_ausin_sedi_inps_ct.ausin_descr As DB_CodSedeProvinciale,
		--Modificato da Letizia il 06/12/2012
		tb_ausin_sedi_inps_ct.ausin_codice_sede + ' - ' +  tb_ausin_sedi_inps_ct.ausin_descr As DB_CodSedeProvinciale,
		
		aupoc_matricola_azienda				AS DB_ProgrMatrAzienda,
		aupoc_controcod_matr_az				AS DB_ControcodMatrAzienda,
		--aupoc_sede_zonale					AS DB_SedeZonale,
		CASE LEN(aupoc_sede_zonale)
			WHEN 1 THEN '0' + aupoc_sede_zonale
			ELSE aupoc_sede_zonale
		END									AS DB_SedeZonale,
	--	AZTIPAZI							AS DB_TipoAzienda,
-- raf
		(
			SELECT autia_codice
			FROM tb_autia_tipo_accentr_ct 
			WHERE 
				autia_codice_pk = aupoc_autia_codice_pk 
		)									AS DB_TipoAzienda,

--		''									AS DB_TipoAzienda,
-- raf
	--	AZPOSRIF							AS DB_PosizioneRiferimento,
		''									AS DB_PosizioneRiferimento,
		CONVERT(VARCHAR(10), aupoc_data_inizio_attivita, 103)
											AS DB_DataCostituzioneAzienda,
		
		convert(varchar(10),aupoc_data_ultimo_stato,103)  as DB_DataEvento,
		--Letizia 17-06-2014
		CASE convert(varchar(10),aupoc_data_domanda_iscr,103)
			WHEN '01/01/1900' THEN ''
			ELSE convert(varchar(10),aupoc_data_domanda_iscr,103)
		END		
		as DB_DataDomandaIscr,
		--(
		--	SELECT CONVERT(VARCHAR(10), MAX(auvas_data_variazione_stato), 103)
		--	FROM tb_auvas_var_stato_pos
		--	WHERE 
		--		auvas_aupoc_codice_pk = @codice_pk AND
		--		auvas_auspc_codice_pk = 2
		--)									AS DB_DataCessazioneProvvisoria,
		--(
		--	SELECT CONVERT(VARCHAR(10), MAX(auvas_data_variazione_stato), 103)
		--	FROM tb_auvas_var_stato_pos
		--	WHERE 
		--		auvas_aupoc_codice_pk = @codice_pk AND
		--		auvas_auspc_codice_pk = 3
		--)									AS DB_DataCessazioneAzienda,
		--(
		--	SELECT CONVERT(VARCHAR(10), MAX(auvas_data_variazione_stato), 103)
		--	FROM tb_auvas_var_stato_pos
		--	WHERE 
		--		auvas_aupoc_codice_pk = @codice_pk AND
		--		auvas_auspc_codice_pk = 4
		--)									AS DB_DataSospensione,
		--(
		--	SELECT CONVERT(VARCHAR(10), MAX(auvas_data_variazione_stato), 103)
		--	FROM tb_auvas_var_stato_pos
		--	WHERE 
		--		auvas_aupoc_codice_pk = @codice_pk AND
		--		auvas_auspc_codice_pk = 5
		--)									AS DB_DataRiattivazione,
	--	auspc_descr							AS DB_SituazioneAzienda,
		''									AS DB_SituazioneAzienda,
		auspc_descr							AS DB_DescrSituazioneAzienda,
		aupoc_denom_posiz_contr				AS DB_DenominazioneAzienda,
	--	AZATTECO							AS DB_AttivitaDichiarata,
	    aupoc_attivita_dichiarata           AS DB_AttivitaDichiarata,
		''									AS DB_AttivitaDichiarata,
		autdt_codice						AS DB_CodTipoDitta,
		autd2_codice						AS DB_CodTipoDitta2,
		autdt_descrizione					AS DB_DescrTipoDitta,
		autd2_descrizione					AS DB_DescrTipoDitta2,
		autd2_descrizione_lunga				DB_DescrLungaTipoDitta2,
		auind_toponimo						AS DB_PrefissoStradale,	
		auind_indirizzo						AS DB_Indirizzo,
		--auind_civico						AS DB_NumeroCivico,
		CASE UPPER(auind_civico)
			WHEN 'SNC' THEN '' 
			ELSE auind_civico
		END
											AS DB_NumeroCivico,
		auind_cap							AS DB_Cap,
		auind_descr_comune					AS DB_Comune,
		auind_sigla_provincia				AS DB_Provincia,
		aupco_cod_stat_contr				AS DB_CodStatistico,
		--aggiunta da Letizia per valorizzare tooltip del codice CSC
		aucsc_settore						as DB_CscSettore,
		aucsc_classe						as DB_CscClasse,
		aucsc_categoria						as DB_CscCategoria,
		--fine aggiunta 
		aupco_codici_autor					AS DB_CodAutorizzazioni,
		aupco_data_inizio_validita			AS DB_DataInizioValidita,
        aupco_data_fine_validita			AS DB_DataFineValidita,
	--	AZCDCLAS							AS DB_CodClassAzienda,	--NON SO SE SERVE
	--	AZCDCLAS.descrizione_breve			AS DB_Classificazione,	--NON SO SE SERVE
	--	AZTIPAZI.descrizione				AS DB_DescrTipoAzienda,
	-- raf
		(
			SELECT autia_descrizione
			FROM tb_autia_tipo_accentr_ct 
			WHERE 
				autia_codice_pk = aupoc_autia_codice_pk 
		)									AS DB_DescrTipoAzienda,
--		''									AS DB_DescrTipoAzienda,

-- raf
		tb_ausin_sedi_inps_ct.ausin_descr	AS DB_DescrSede,
		
-- Maurizio 22/05/2012
--		aupoc_auate_1991_codice_pk 	  AS DB_Ateco,
	
		aupoc_ATECO				 	  AS DB_Ateco, -- Raffaele 29/05/2012
		--Letizia 17-06-2014 aggiunta gestione codici ateco 1991-2002-2007
		--Ateco1991.auate_cod_ateco_complessivo as DB_Ateco91,
		--Ateco1991.auate_cod_sottocategoria_tit as DB_DescrAteco91,
		--Ateco2002.auate_cod_ateco_complessivo as DB_Ateco2002,
		--Ateco2002.auate_cod_sottocategoria_tit as DB_DescrAteco2002,
		--Ateco2007.auate_cod_ateco_complessivo as DB_Ateco2007,
		--Ateco2007.auate_cod_sottocategoria_tit as DB_DescrAteco2007,

		--Letizia 20150326
		case tb_aupoc_pos_contr.aupoc_aurea_codice_pk
				when 1 then AupcoAteco1991.auate_cod_ateco_complessivo
				else Ateco1991.auate_cod_ateco_complessivo
		end as DB_Ateco91,
		case tb_aupoc_pos_contr.aupoc_aurea_codice_pk
				when 1 then AupcoAteco1991.auate_cod_sottocategoria_tit
				else Ateco1991.auate_cod_sottocategoria_tit
		end as DB_DescrAteco91,
		case tb_aupoc_pos_contr.aupoc_aurea_codice_pk
				when 1 then AupcoAteco2002.auate_cod_ateco_complessivo
				else Ateco2002.auate_cod_ateco_complessivo
		end as DB_Ateco2002,
		case tb_aupoc_pos_contr.aupoc_aurea_codice_pk
				when 1 then AupcoAteco2002.auate_cod_sottocategoria_tit
				else Ateco2002.auate_cod_sottocategoria_tit
		end as DB_DescrAteco2002,
		case tb_aupoc_pos_contr.aupoc_aurea_codice_pk
				when 1 then AupcoAteco2007.auate_cod_ateco_complessivo
				else Ateco2007.auate_cod_ateco_complessivo
		end as DB_Ateco2007,
		case tb_aupoc_pos_contr.aupoc_aurea_codice_pk
				when 1 then AupcoAteco2007.auate_cod_sottocategoria_tit
				else Ateco2007.auate_cod_sottocategoria_tit
		end as DB_DescrAteco2007,
		--fine
		
		aupoc_id_sin				  AS DB_IdSin, --Letizia 07-05-2013
		aupoc_id_confluito			  AS DB_IdConfluito,--Letizia 07-05-2013
		aupoc_cf_confluito			  AS DB_CodFiscConfluito,--Letizia 07-05-2013
		aupoc_progressivo_confluito   AS DB_ProgConfluito,--Letizia 07-05-2013
		aupoc_codice_gruppo			  AS DB_CodGruppo,--Letizia 07-05-2013
		aupoc_codice_categoria		  AS DB_CodCategoria,--Letizia 07-05-2013
		aucat_descr					  AS DB_DescCategoria,--Letizia 07-05-2013
		aupoc_note					  AS DB_Note,

--INIZIO modifica Quirino 24/02/2014
		--CASE aupoc_tipo_posizione 
		--	WHEN 1 THEN 'Autonomo'
		--	ELSE 'Datore Lavoro'
		--END	AS DB_TipoPosizione,		--Letizia 09-05-2013
		--Letizia 2015.05.18 aggiunta gestione del codice aurea 12
		CASE 
			WHEN aupoc_aurea_codice_pk in (5,12,13) THEN --Inserita area 13 per Datore Voucher
				CASE aupoc_tipo_posizione 
					WHEN 1 THEN 'Committente'
					WHEN 2 THEN 'Professionista'
					ELSE 'Datore Voucher'				-- Inserito Datore Voucher
				END
			ELSE
				CASE aupoc_tipo_posizione 
					WHEN 1 THEN 'Autonomo'
					ELSE 'Datore Lavoro'
				END
		
		END
									  AS DB_TipoPosizione,
--FINE modifica Quirino 24/02/2014

		aupoc_aucom_codice as DB_CodCompartimento, --Letizia 16-05-2013
		aucom_descr	       as DB_DescCompartimento, --Letizia 16-05-2013
		tb_auate_cod_ateco_ct.auate_cod_sottocategoria_tit  AS DB_DescrAteco,
		aurea_descrizione			  AS DB_Gestione,
		aupoc_aurea_codice_pk		  AS DB_GestioneCodAurea,
		autd2_descrizione             AS DB_DescrTipoDitta2,
		autdt_descrizione_lunga       AS DB_DescrLungaTipoDitta,
		autd2_descrizione_lunga       AS DB_DescrLungaTipoDitta2,
		CASE aupoc_navale
			WHEN 'N' THEN 'NO'
			ELSE 'SI'
		END as DB_Navale,
				
		(SELECT COUNT(tb_aurpp_rel_poc_poc.aurpp_codice_pk)
		 FROM tb_aurpp_rel_poc_poc
		 WHERE tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia=@codice_pk) 
		 AS DB_NumPosizioniSecondarie,
		 
		(SELECT COUNT(tb_aurpp_rel_poc_poc.aurpp_codice_pk) 
		 FROM tb_aurpp_rel_poc_poc
		 WHERE tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_madre=@codice_pk)   
		 AS DB_NumPosizioniPrincipale,

		-- Lista delle Attività
		(SELECT COUNT(aulat_ausca_codice_PK) FROM dbo.tb_aulat_lista_attivita WHERE aulat_ausca_codice_PK =[aupoc_ausca_codice_pk] ) as DB_ListaAttivita
	
		,aupoc_cod_prov_istat		AS DB_CodiceProvincia	-- Quirino 23-09-2013
		,aupoc_cod_comune_istat		AS DB_CodiceComune		-- Quirino 23-09-2013
		,aupoc_prog_azienda_agr		AS DB_Progressivo		-- Quirino 23-09-2013
		--AI 3106
		,aupoc_cod_cancellazione_AC as DB_Cod_Cancellazione
		--AI 3106
		--AI 3107
		,aupoc_descr_stato_gs as DB_DescrStato_GS
		--AI 3107 Fine
		
		--AI 3111
		,aupoc_chiave_LD as DB_ChiaveLavDom
		,aupoc_cfLavoratore_LD as DB_CodFiscLavDom
		,aupoc_codice_stato_LD as DB_CodStatoLavDom
		,aupoc_descr_stato_LD as DB_DescrStatoLavDom
		--Ai 3111 Fine
		--AI 3115
		,aupoc_posizione as DB_Posizione
		--AI 3115
	
	FROM tb_aupoc_pos_contr 
	LEFT OUTER JOIN tb_auspc_stato_pos_contr_ct ON 
			tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk 
	LEFT OUTER JOIN tb_aupco_periodo_contr ON 
		tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk AND
		convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	LEFT OUTER JOIN tb_autdt_tipoditta_ct ON
		aupoc_autdt_codice_pk = autdt_codice_pk
	LEFT OUTER JOIN tb_auind_indirizzi ON
		UPPER(auind_tabella) = 'AUPOC' AND auind_tabella_codice_pk = @codice_pk
	LEFT OUTER JOIN tb_ausin_sedi_inps_ct ON
		--CASE LEN(CONVERT(VARCHAR(2), aupoc_sede_provinciale))
		--	WHEN 1 THEN '0' + CONVERT(VARCHAR(2), aupoc_sede_provinciale)
		--	ELSE CONVERT(VARCHAR(2), aupoc_sede_provinciale)
		--END
		--+
		--CASE LEN(aupoc_sede_zonale)
		--	WHEN 1 THEN '0' + aupoc_sede_zonale
		--	ELSE aupoc_sede_zonale
		--END
		--SUBSTRING(aupoc_cod_sede_INPS,3,4) -- Modificato da Raffaele 29/05/2012
		--= ausin_codice_sede
		--Modificato da Letizia 06/12/2012
		aupoc_ausin_codice_pk=tb_ausin_sedi_inps_ct.ausin_codice_pk
	
	
	
	--aggiunta da Letizia per valorizzare tooltip del codice CSC,potrebbe essere modificato quando sarà aggiunta FK su tabella AUPCO
	LEFT OUTER JOIN tb_aucsc_cod_stat_contr_ct
	on tb_aupco_periodo_contr.aupco_cod_stat_contr=tb_aucsc_cod_stat_contr_ct.aucsc_codice
	
	-- Maurizio 22/05/2012 -- Per Tipo Ditta 2
	LEFT OUTER JOIN tb_autd2_tipoditta2_ct
	on tb_autd2_tipoditta2_ct.autd2_codice = aupoc_autd2_codice_pk
	
	-- Maurizio 22/05/2012 -- Per Codice Ateco
	LEFT OUTER JOIN tb_auate_cod_ateco_ct
	on tb_auate_cod_ateco_ct.auate_codice_pk = aupoc_auate_1991_codice_pk

	--Letizia 17-06-2014 aggiunta gestione codici ateco 2002-2007
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as Ateco1991 ON
		Ateco1991.auate_codice_pk=aupoc_auate_1991_codice_pk
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as Ateco2002 ON
		Ateco2002.auate_codice_pk=aupoc_auate_2002_codice_pk
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as Ateco2007 ON
		Ateco2007.auate_codice_pk=aupoc_auate_2007_codice_pk
	
	--Letizia 20150326 aggiunta gestione Aupco-auate 
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as AupcoAteco1991 ON
		AupcoAteco1991.auate_codice_pk=aupco_auate_1991_codice_pk  AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as AupcoAteco2002 ON
		AupcoAteco2002.auate_codice_pk=aupco_auate_2002_codice_pk  AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as AupcoAteco2007 ON
		AupcoAteco2007.auate_codice_pk=aupco_auate_2007_codice_pk  AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	 --Fine

	-- Maurizio 22/05/2012 -- Per Posizioni Madre / Figlie
	LEFT OUTER JOIN [dbo].[tb_aurpp_rel_poc_poc]
	on [dbo].[tb_aurpp_rel_poc_poc].aurpp_codice_pk = @codice_pk
	
	-- Letizia 07/05/2013 -- Aggiunta gestione Enpals
	LEFT OUTER JOIN dbo.tb_aucat_categoria_ct
	on dbo.tb_aucat_categoria_ct.aucat_codice =dbo.tb_aupoc_pos_contr.aupoc_codice_categoria

	LEFT OUTER JOIN dbo.tb_aucom_compartimento_ct
	on dbo.tb_aucom_compartimento_ct.aucom_codice=dbo.tb_aupoc_pos_contr.aupoc_aucom_codice
	
	-- Letizia 07/05/2013 -- Aggiunta gestione Enpals
	LEFT OUTER JOIN dbo.tb_aurea_area_gestione
	on dbo.tb_aurea_area_gestione.aurea_codice_pk =dbo.tb_aupoc_pos_contr.aupoc_aurea_codice_pk	
	WHERE aupoc_codice_pk = @codice_pk
	


			
			
			
			
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END


