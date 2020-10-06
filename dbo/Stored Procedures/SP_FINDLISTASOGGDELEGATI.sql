-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	I soggetti delegati vengono recuperati attraverso le posizioni contributive dell’azienda.
--Accesso alla tabella tb_ausca  in join con
-- tb_aupoc_pos_contr,  tb_aurad_rel_az_del  e tb_audel_del
--   qualificando: 
--	ausca_codice_fiscale = codice fiscale di input
--	ausca_codice_pk  = aupoc_ausca_codice_pk
--	aupoc_codice_pk = aurad_aupoc_codice_pk
--	aurad_audel_codice_pk = audel_codice_pk
--	data operazione inclusa tra aurad_data_inizio_validita  e   aurad_data_di_fine_validita
-- oppure 
-- data operazione >= aurad_data_inizio_validita  e aurad_data_di_fine_validita non impostata
-- =============================================
CREATE PROCEDURE [dbo].[SP_FINDLISTASOGGDELEGATI] 
	-- Add the parameters for the stored procedure here
	@codice_fiscale_azienda varchar(16)
	
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1000 [ausca_codice_pk]
      ,[ausca_denominazione]
      ,[ausca_codice_fiscale]
      ,[ausca_aungi_codice_pk]
      ,[ausca_cciaa]
      ,[ausca_codice_toponimo]
      ,[ausca_indirizzo]
      ,[ausca_civico]
      ,[ausca_localita]
      ,[ausca_sede_legale_italia]
      ,[ausca_codice_comune]
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
      ,[ausca_soggetto_certificato]
      ,[ausca_data_variazione_stato]
      ,[ausca_auten_codice_pk]
      ,[ausca_codice_entita_rif]
      ,[ausca_note]
      ,[ausca_data_modifica]
      ,[ausca_descr_utente]
      ,[ausca_toponimo]
      ,[ausca_data_inizio_attivita]
      ,[aupoc_ausca_codice_pk]
      ,[audel_codice_pk]
	  ,[audel_codice_fiscale]
	  ,[audel_cognome]
	  ,[audel_nome]
	  ,[audel_note]
	  ,[audel_data_modifica]
	  ,[audel_descr_utente]
      ,[audel_denominazione] -- rel. 2
      
  FROM  
  [dbo].[tb_ausca_sog_contr_az]
  
  left outer join  
  [dbo].[tb_aupoc_pos_contr] on ausca_codice_pk  = aupoc_ausca_codice_pk
  
  left outer join  
  [dbo].[tb_aurad_rel_az_del] on aupoc_codice_pk = aurad_aupoc_codice_pk
  
  left outer join  [dbo].[tb_audel_del] on aurad_audel_codice_pk = audel_codice_pk
  
  WHERE 
  ausca_codice_fiscale = @codice_fiscale_azienda
  AND	
  (aurad_data_inizio_validita <= getdate()  AND aurad_data_fine_validita >= getdate())
  
END

