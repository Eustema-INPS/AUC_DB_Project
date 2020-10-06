

-- ===============================================================================================
-- Nuova creazione da: Paletta
-- Data modifica:  2018.11.23
-- Description:	AI 3117
-- ===============================================================================================
CREATE PROCEDURE [dbo].[AZ_PosizioneErrata]
	@posizione varchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		tb_ausin_sedi_inps_ct.ausin_codice_sede + ' - ' +  tb_ausin_sedi_inps_ct.ausin_descr As DB_CodSedeProvinciale,
		
		aupoc_matricola_azienda				AS DB_ProgrMatrAzienda,
		aupoc_controcod_matr_az				AS DB_ControcodMatrAzienda,
		CASE LEN(aupoc_sede_zonale)
			WHEN 1 THEN '0' + aupoc_sede_zonale
			ELSE aupoc_sede_zonale
		END									AS DB_SedeZonale,
		(
			SELECT autia_codice
			FROM tb_autia_tipo_accentr_ct 
			WHERE 
				autia_codice_pk = aupoc_autia_codice_pk 
		)									AS DB_TipoAzienda,

		''									AS DB_PosizioneRiferimento,
		CONVERT(VARCHAR(10), aupoc_data_inizio_attivita, 103)
											AS DB_DataCostituzioneAzienda,
		
		convert(varchar(10),aupoc_data_ultimo_stato,103)  as DB_DataEvento,
		CASE convert(varchar(10),aupoc_data_domanda_iscr,103)
			WHEN '01/01/1900' THEN ''
			ELSE convert(varchar(10),aupoc_data_domanda_iscr,103)
		END		
		as DB_DataDomandaIscr,
		''									AS DB_SituazioneAzienda,
		auspc_descr							AS DB_DescrSituazioneAzienda,
		aupoc_denom_posiz_contr				AS DB_DenominazioneAzienda,
	    aupoc_attivita_dichiarata           AS DB_AttivitaDichiarata,
		auind_toponimo						AS DB_PrefissoStradale,	
		auind_indirizzo						AS DB_Indirizzo,
		CASE UPPER(auind_civico)
			WHEN 'SNC' THEN '' 
			ELSE auind_civico
		END
											AS DB_NumeroCivico,
		auind_cap							AS DB_Cap,
		auind_descr_comune					AS DB_Comune,
		auind_sigla_provincia				AS DB_Provincia,
		aupco_cod_stat_contr				AS DB_CodStatistico,
		aucsc_settore						as DB_CscSettore,
		aucsc_classe						as DB_CscClasse,
		aucsc_categoria						as DB_CscCategoria,
		aupco_codici_autor					AS DB_CodAutorizzazioni,
		aupco_data_inizio_validita			AS DB_DataInizioValidita,
        aupco_data_fine_validita			AS DB_DataFineValidita,
		(
			SELECT autia_descrizione
			FROM tb_autia_tipo_accentr_ct 
			WHERE 
				autia_codice_pk = aupoc_autia_codice_pk 
		)									AS DB_DescrTipoAzienda,

		tb_ausin_sedi_inps_ct.ausin_descr	AS DB_DescrSede,

		aupoc_ATECO				 	  AS DB_Ateco, 
		case aupoc_aurea_codice_pk
				when 1 then AupcoAteco1991.auate_cod_ateco_complessivo
				else Ateco1991.auate_cod_ateco_complessivo
		end as DB_Ateco91,
		case aupoc_aurea_codice_pk
				when 1 then AupcoAteco1991.auate_cod_sottocategoria_tit
				else Ateco1991.auate_cod_sottocategoria_tit
		end as DB_DescrAteco91,
		case aupoc_aurea_codice_pk
				when 1 then AupcoAteco2002.auate_cod_ateco_complessivo
				else Ateco2002.auate_cod_ateco_complessivo
		end as DB_Ateco2002,
		case aupoc_aurea_codice_pk
				when 1 then AupcoAteco2002.auate_cod_sottocategoria_tit
				else Ateco2002.auate_cod_sottocategoria_tit
		end as DB_DescrAteco2002,
		case aupoc_aurea_codice_pk
				when 1 then AupcoAteco2007.auate_cod_ateco_complessivo
				else Ateco2007.auate_cod_ateco_complessivo
		end as DB_Ateco2007,
		case aupoc_aurea_codice_pk
				when 1 then AupcoAteco2007.auate_cod_sottocategoria_tit
				else Ateco2007.auate_cod_sottocategoria_tit
		end as DB_DescrAteco2007,
		aupoc_note					  AS DB_Note,

		CASE 
			WHEN aupoc_aurea_codice_pk in (5,12,13) THEN 
				CASE aupoc_tipo_posizione 
					WHEN 1 THEN 'Committente'
					WHEN 2 THEN 'Professionista'
					ELSE 'Datore Voucher'				
				END
			ELSE
				CASE aupoc_tipo_posizione 
					WHEN 1 THEN 'Autonomo'
					ELSE 'Datore Lavoro'
				END
		
		END
									  AS DB_TipoPosizione,
		tb_auate_cod_ateco_ct.auate_cod_sottocategoria_tit  AS DB_DescrAteco,
		aurea_descrizione			  AS DB_Gestione,
		aupoc_aurea_codice_pk		  AS DB_GestioneCodAurea,

		aupoc_contro_codice + aupoc_codice_pk As DB_IdentificativoAUC,
		CASE aupoc_navale
			WHEN 'N' THEN 'NO'
			ELSE 'SI'
		END as DB_Navale,
				
		(SELECT COUNT(tb_aupoe_PosizioniErrate_Aurpp.aurpp_codice_pk)
		 FROM tb_aupoe_PosizioniErrate_Aurpp
		 WHERE tb_aupoe_PosizioniErrate_Aurpp.aurpp_aupoc_cod_pk_figlia=tb_aupoe_PosizioniErrate_Aupoc.aupoc_codice_pk) 
		 AS DB_NumPosizioniSecondarie,
		 
		(SELECT COUNT(tb_aupoe_PosizioniErrate_Aurpp.aurpp_codice_pk) 
		 FROM tb_aupoe_PosizioniErrate_Aurpp
		 WHERE tb_aupoe_PosizioniErrate_Aurpp.aurpp_aupoc_cod_pk_madre=tb_aupoe_PosizioniErrate_Aupoc.aupoc_codice_pk)   
		 AS DB_NumPosizioniPrincipale,

		(SELECT COUNT(aulat_ausca_codice_PK) FROM dbo.tb_aulat_lista_attivita WHERE aulat_ausca_codice_PK =[aupoc_ausca_codice_pk] ) as DB_ListaAttivita
		,tb_aupoe_PosizioniErrate_Aupoc.aupoc_posizione as DB_Posizione
	
	FROM tb_aupoe_PosizioniErrate_Aupoc
	LEFT OUTER JOIN tb_auspc_stato_pos_contr_ct ON 
			aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk 
	LEFT OUTER JOIN tb_aupoe_PosizioniErrate_Aupco ON 
		aupoc_codice_pk = aupco_aupoc_codice_pk AND
		convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	LEFT OUTER JOIN tb_aupoe_PosizioniErrate_Auind ON
		UPPER(auind_tabella) = 'AUPOC' AND auind_tabella_codice_pk = tb_aupoe_PosizioniErrate_Aupoc.aupoc_codice_pk
	LEFT OUTER JOIN tb_ausin_sedi_inps_ct ON
		aupoc_ausin_codice_pk=tb_ausin_sedi_inps_ct.ausin_codice_pk	
	LEFT OUTER JOIN tb_aucsc_cod_stat_contr_ct
	on aupco_cod_stat_contr=tb_aucsc_cod_stat_contr_ct.aucsc_codice
	LEFT OUTER JOIN tb_auate_cod_ateco_ct
	on tb_auate_cod_ateco_ct.auate_codice_pk = aupoc_auate_1991_codice_pk

	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as Ateco1991 ON
		Ateco1991.auate_codice_pk=aupoc_auate_1991_codice_pk
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as Ateco2002 ON
		Ateco2002.auate_codice_pk=aupoc_auate_2002_codice_pk
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as Ateco2007 ON
		Ateco2007.auate_codice_pk=aupoc_auate_2007_codice_pk
	
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as AupcoAteco1991 ON
		AupcoAteco1991.auate_codice_pk=aupco_auate_1991_codice_pk  AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as AupcoAteco2002 ON
		AupcoAteco2002.auate_codice_pk=aupco_auate_2002_codice_pk  AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	LEFT OUTER JOIN
		tb_auate_cod_ateco_ct  as AupcoAteco2007 ON
		AupcoAteco2007.auate_codice_pk=aupco_auate_2007_codice_pk  AND convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
	LEFT OUTER JOIN [dbo].tb_aupoe_PosizioniErrate_Aurpp
	on [dbo].tb_aupoe_PosizioniErrate_Aurpp.aurpp_codice_pk = tb_aupoe_PosizioniErrate_Aupoc.aupoc_codice_pk
	LEFT OUTER JOIN dbo.tb_aurea_area_gestione
	on dbo.tb_aurea_area_gestione.aurea_codice_pk = aupoc_aurea_codice_pk	
	WHERE  tb_aupoe_PosizioniErrate_Aupoc.aupoc_posizione = @posizione
	
		
			
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END




