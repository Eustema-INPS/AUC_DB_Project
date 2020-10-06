
-- =====================================================================
-- Author:		Picone
-- Create date: 7 agosto 2012
-- Description:	lettura COMPLETA della tabella tb_ausca_sog_contr_az
-- Modificato da Raffaele il 2018/07/10
-- Sostituito ausca_codice_comune in ausca_cod_com_Belfiore (AI 2086)
-- =====================================================================
CREATE PROCEDURE [dbo].[SP_FINDCOMPLETIAZIENDA_PK] 
	@aupoc_codice_pk int
AS
BEGIN
	SET NOCOUNT ON;

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
	end as fonte_acquisizione	 
	
	--AI 2056.

      
  FROM  [dbo].[tb_ausca_sog_contr_az] 
  
  inner join  [dbo].[tb_aupoc_pos_contr]
  on [tb_aupoc_pos_contr].aupoc_ausca_codice_pk = ausca_codice_pk

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
  
  where   [tb_aupoc_pos_contr].aupoc_codice_pk = @aupoc_codice_pk
  
END


