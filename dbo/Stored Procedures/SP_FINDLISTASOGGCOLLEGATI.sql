-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	
-- Moddificata da: Raffaele
-- Data: 14 novembre 2013
-- Descrizione: La stored ritorna solo i rappresentanti legali indipendentemente dal
--				periodo di validità, prima tornava tutti i soggetti collegati validi.
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDLISTASOGGCOLLEGATI] 
	-- Add the parameters for the stored procedure here
	@codice_fiscale_azienda varchar(16)
	 
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	SELECT [ausco_codice_pk]
	  ,[ausco_codice_fiscale]
	  ,[ausco_cognome]
	  ,[ausco_nome]
	  ,[ausco_sesso]
	  ,[ausco_cittadinanza]
	  ,[ausco_comune_nascita]
	  ,[ausco_data_nascita]
	  ,[ausco_prov_nascita]
	  ,[ausco_stato_estero_nascita]
	  ,[ausco_tipo_persona]
	  ,[ausco_codice_toponimo]
	  ,[ausco_toponimo]
	  ,[ausco_indirizzo]
	  ,[ausco_civico]
	  ,[ausco_cap]
	  ,[ausco_codice_comune]
	  ,[ausco_localita]
	  ,[ausco_provincia]
	  ,[ausco_sigla_nazione]
	  ,[ausco_codice_stato_estero]
	  ,[ausco_telefono]
	  ,[ausco_fax]
	  ,[ausco_email]
	  ,[ausco_pec]
	  ,[ausco_legalmail]
	  ,[ausco_note]
	  ,[ausco_data_modifica]
	  ,[ausco_descr_utente]
	  ,[ausco_denominazione] -- rel. 2
	  ,tb_autis_tipo_sog_col_ct.autis_descr
	  ,tb_aurss_rel_sog_sog.aurss_data_nomina
	  ,tb_aurss_rel_sog_sog.aurss_ausca_codice_pk
	  --AI 2035:
	  ,autis_codice_carica
	  ,autis_descr
	  ,aurss_data_inizio_validita
	  ,aurss_data_di_fine_validita
	  --AI 2035.

	  --AI 2056:

	  ,case 
			when tb_aurss_rel_sog_sog.aurss_auten_codice_pk = 1 then 'Utente '
			when tb_aurss_rel_sog_sog.aurss_auten_codice_pk = 2 then 'Certif.'
			when tb_aurss_rel_sog_sog.aurss_auten_codice_pk = 3 then 'Applic.' 
			else 'Non definita'
	  end as tipologia_fonte

	  ,case 
		  when  aurss_auten_codice_pk = 1 then 
		  (
				SELECT auute_utenza 
				FROM tb_auute_ute_sistema
				WHERE auute_codice_pk = aurss_codice_entita_rif
		  )
		  when aurss_auten_codice_pk = 2 then 
		  (
				 SELECT auece_descr 
				 FROM tb_auece_ente_cert 
				 WHERE auece_codice_pk = aurss_codice_entita_rif
		  )
		  when aurss_auten_codice_pk = 3 then 
		  (
				SELECT     tb_aurea_area_gestione.aurea_descrizione
	    		FROM        tb_auapp_appl LEFT OUTER JOIN
				tb_aurea_area_gestione ON tb_auapp_appl.auapp_aurea_codice_pk = tb_aurea_area_gestione.aurea_codice_pk
				WHERE     (tb_auapp_appl.auapp_codice_pk = aurss_codice_entita_rif)
		  )
		  else 'Non definita'
	  end as descrizione_fonte

	  --AI 2056.
	  
	  
	  
  FROM  [dbo].[tb_ausco_sog_contr_col]
  
  left outer join  [dbo].[tb_aurss_rel_sog_sog]
  on tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk
  
  left outer join  [dbo].[tb_ausca_sog_contr_az]
  on tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
  
  left outer join  [dbo].tb_autis_tipo_sog_col_ct
  on aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
  
  where ausca_codice_fiscale = @codice_fiscale_azienda 
  and	
  aurss_rappresentante_legale = 'S' -- Aggiunta da Raffaele 14 novembre 2013
  -- Eliminate da Raffaele 14 novembre 2013
  --((getdate()  >= aurss_data_inizio_validita
  -- and   getdate()  <= aurss_data_di_fine_validita)
  -- or	(getdate()  >= aurss_data_inizio_validita
  -- and   aurss_data_di_fine_validita is null)) 		
  
END
