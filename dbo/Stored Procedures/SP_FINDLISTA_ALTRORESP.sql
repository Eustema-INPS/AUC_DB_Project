


-- =============================================
-- Author:		Stefano Chiovelli
-- Create date: 29.01.2018
-- Description:	Stored Procedure per caricare tutti i soggetti che sono altro responsabile per l'azienda
-- =============================================


CREATE PROCEDURE [dbo].[SP_FINDLISTA_ALTRORESP]
	@codice_fiscale_azienda varchar(16)
AS
BEGIN

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
	  ,[ausco_denominazione]
	  ,tb_autis_tipo_sog_col_ct.autis_descr
	  ,tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk
	  ,autis_codice_carica
	  ,autis_descr
	  ,aursp_data_inizio_validita as aurss_data_inizio_validita
	  ,aursp_data_di_fine_validita as aurss_data_di_fine_validita
	  ,'' as tipologia_fonte
	  , '' as descrizione_fonte

	FROM         
		   tb_ausco_sog_contr_col INNER JOIN
                      tb_aursp_rel_sog_pos ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk INNER JOIN
                      tb_autis_tipo_sog_col_ct ON tb_aursp_rel_sog_pos.aursp_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk INNER JOIN
                      tb_aupoc_pos_contr ON tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk INNER JOIN
                      tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk 
               
	WHERE 
	ausca_codice_fiscale = @codice_fiscale_azienda 
	--non si prendono in considerazione i collaboratori (artigiani e commercianti)
	and aursp_autis_codice_pk<>163

    ORDER BY aursp_data_inizio_validita, ausco_codice_fiscale

END

