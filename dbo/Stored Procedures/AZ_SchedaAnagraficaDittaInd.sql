
-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 27-03-2013
-- Description:	Stored per caricare la scheda per le ditte individuali
-- =============================================
-- Modificata da: Raffaele
-- Data:		26.06.2013
-- Descrizione:	Sostituito i valore di aungi_descr_lunga con aungi_descr_altern
-- =============================================
-- ===============================================================================================
-- Modificata da:  Quirino Vannimartini
-- Data modifica:  28/02/2014
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
CREATE PROCEDURE [dbo].[AZ_SchedaAnagraficaDittaInd] 
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
		--ausca_auten_codice_pk 		AS DB_CodiceEntita,
		--ausca_codice_entita_rif       AS DB_CodiceTipoEntitA,
		--aungi_descr_lunga 				AS DB_NaturaGiuridica,
		aungi_descr_altern 				AS DB_NaturaGiuridica,
		CASE ausca_sede_legale_italia
			WHEN 'N' THEN 'NO'
			ELSE 'SI'
		END 							AS DB_SedeLegaleItalia,
		ausca_telefono1 				AS DB_Telefono1,
		ausca_telefono2 				AS DB_Telefono2,
		ausca_telefono3 				AS DB_Telefono3,
		ausca_fax	 					AS DB_Fax,
		ausca_email						AS DB_Email,
		ausca_PEC						AS DB_Pec,
		isnull(nullif([ausca_legalmail], ''), [ausca_pec_iva])					AS DB_LegalMail, -- G.C. 2020-02-18
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
		
	    ausco_cognome as DB_DI_Cognome,
	    ausco_nome as DB_DI_Nome,
	    ausco_toponimo as DB_DI_Toponimo,
	    ausco_frazione as DB_DI_frazione,
	    ausco_localita as DB_DI_Localita,
	    ausco_indirizzo as DB_DI_Indirizzo,
	    ausco_civico as DB_DI_Civico,
	    ausco_cap as DB_DI_Cap,
	    ausco_codice_comune as DB_DI_COdComune,
	    ausco_provincia as DB_DI_Provincia,
	    ausco_pec as DB_DI_Pec,
	    ausco_cittadinanza AS DB_DI_Cittadinanza,
	  	CONVERT(VARCHAR(10), ausco_data_nascita, 103) AS DB_DI_DataNascita,
	  	ausco_codice_pk as DB_CodiceAusco,
	    ausco_sesso				    AS DB_DI_Sesso,
	    ausco_comune_nascita	    AS DB_DI_ComuneNascita,
	    ausco_prov_nascita			AS DB_DI_ProvinciaNascita,
	    ausco_stato_estero_nascita	AS DB_DI_StatoEsteroNascita,
	    ausco_sigla_nazione		    AS DB_DI_Nazione,
	    ausco_telefono				AS DB_DI_Telefono,
	  	ausco_fax					AS DB_DI_Fax,
		ausco_email					AS DB_DI_Email,
		ausco_pec					AS DB_DI_Pec,
		ausco_legalmail				AS DB_DI_LegalMail,
		ausco_codice_fiscale	    AS DB_DI_CodiceFiscale, 
		
		(SELECT COUNT(aucon_ausca_codice_pk) FROM dbo.tb_aucon_concorsuale WHERE aucon_ausca_codice_pk = @codiceAzienda) as DB_ProcedureConcorsuali,
		
		-- Fusioni/Scissioni - Tabella <auces> dismessa, sostituita con <aufus> 
		(SELECT COUNT(aufus_codice_pk)       FROM dbo.tb_aufus_fusioni_scissioni WHERE aufus_ausca_codice_pk = @codiceAzienda) as DB_FusioniCessioni,
		
		(SELECT COUNT(auulo_ausca_codice_pk) FROM dbo.tb_auulo_unita_locale WHERE auulo_ausca_codice_pk = @codiceAzienda) as DB_UnitaLocali,
		
		-- Subentri
		(SELECT COUNT(ausub_ausca_codice_pk) FROM dbo.tb_ausub_subentri A WHERE A.ausub_ausca_codice_pk = @codiceAzienda) as DB_Subentri,

--INIZIO modifca Quirino 27/02/2014
		-- Lista delle Attività
		--(SELECT COUNT(aulat_ausca_codice_PK) FROM dbo.tb_aulat_lista_attivita WHERE aulat_ausca_codice_PK = @codiceAzienda) as DB_ListaAttivita,
		
		-- Elenco Codici Fiscali Confluiti
		(SELECT COUNT(aucfc_ausca_codice_PK) FROM dbo.tb_aucfc_cfconfluiti WHERE aucfc_ausca_codice_PK = @codiceAzienda) as DB_CodiciFiscaliConfluiti
--FINE modifca Quirino 27/02/2014
	
	--FROM
	
	--tb_ausco_sog_contr_col 
	--INNER JOIN
 --   tb_aurss_rel_sog_sog ON 
 --   tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk 
 --   RIGHT OUTER JOIN
 --   tb_ausca_sog_contr_az ON tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
    

	--LEFT  JOIN
	--	tb_aungi_nat_giur_ct ON 
	--	tb_ausca_sog_contr_az.ausca_aungi_codice_pk = tb_aungi_nat_giur_ct.aungi_codice_pk
	--LEFT  JOIN
	--	tb_auate_cod_ateco_ct ON
	--	tb_auate_cod_ateco_ct.auate_codice_pk=tb_ausca_sog_contr_az.ausca_auate_1991_codice_pk
   
 --   LEFT JOIN tb_autis_tipo_sog_col_ct 
 --   ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk 
	
	FROM         tb_ausco_sog_contr_col INNER JOIN
                      tb_aurss_rel_sog_sog ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk RIGHT OUTER JOIN
                      tb_ausca_sog_contr_az ON tb_ausco_sog_contr_col.ausco_codice_fiscale = tb_ausca_sog_contr_az.ausca_codice_fiscale AND 
                      tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk LEFT OUTER JOIN
                      tb_aungi_nat_giur_ct ON tb_ausca_sog_contr_az.ausca_aungi_codice_pk = tb_aungi_nat_giur_ct.aungi_codice_pk LEFT OUTER JOIN
                      tb_auate_cod_ateco_ct ON tb_auate_cod_ateco_ct.auate_codice_pk = tb_ausca_sog_contr_az.ausca_auate_1991_codice_pk LEFT OUTER JOIN
                      tb_autis_tipo_sog_col_ct ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
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

