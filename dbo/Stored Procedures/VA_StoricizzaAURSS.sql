



-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  20/10/2017
-- Description:		Storicizza i dati della tabella "tb_aurss_rel_sog_sog" nella tabella "tb_ausrs_storico_rel_sog"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_StoricizzaAURSS]

/*@CF varchar (16),*/
@CodAz int,
@causa varchar (1),
@motivo varchar (200),
@utente varchar (50)

AS
BEGIN
	SET NOCOUNT ON;


insert into    [AUC].[dbo].[tb_ausrs_storico_rel_sog] (

       [ausrs_aurss_codice_pk]
      ,[ausrs_ausca_codice_pk]
      ,[ausrs_ausco_codice_pk]
      ,[ausrs_aussu_codice_pk]
      ,[ausrs_autis_codice_pk]
      ,[ausrs_data_inizio_validita]
      ,[ausrs_data_di_fine_validita]
      ,[ausrs_data_iscr_libro_soci]
      ,[ausrs_data_atto_di_nomina]
      ,[ausrs_data_nomina]
      ,[ausrs_data_fine_carica]
      ,[ausrs_note]
      ,[ausrs_rappresentante_legale]
      ,[ausrs_data_modifica]
      ,[ausrs_descr_utente]
      ,[ausrs_codice_pk_db2]
      ,[ausrs_relazione_certificata]
      ,[ausrs_cert_auten_cod_pk]
      ,[ausrs_cert_cod_entita_rif]
      ,[ausrs_cert_data_modifica]
      ,[ausrs_indice_qualita_relazione]
      ,[ausrs_auten_codice_pk]
      ,[ausrs_codice_entita_rif]
      ,[ausrs_codice_carica]
      ,[ausrs_provenienza]
      ,[ausrs_data_iscrizione]
      ,[ausrs_flag_chiusura]
      ,[ausrs_cap_agire]
      ,[ausrs_flag_se_elettore]
      ,[ausrs_potere_firma]
      ,[ausrs_quote_partec]
      ,[ausrs_perce_partec]
      ,[ausrs_quote_partec_e]
      ,[ausrs_quota_c_valuta]
      ,[ausrs_cod_durata_carica]
      ,[ausrs_anni_ese_carica]
      ,[ausrs_data_pres_carica]
      ,[ausrs_prog_pers]
      ,[ausrs_progressivo_carica]
      ,[ausrs_causa_storicizzazione]
      ,[ausrs_utente_storicizzazione]
      ,[ausrs_data_storicizzazione]
      ,[ausrs_motivo_storicizzazione])


select * from (

select  [aurss_codice_pk]
      ,[aurss_ausca_codice_pk]
      ,[aurss_ausco_codice_pk]
      ,[aurss_aussu_codice_pk]
      ,[aurss_autis_codice_pk]
      ,[aurss_data_inizio_validita]
      ,[aurss_data_di_fine_validita]
      ,[aurss_data_iscr_libro_soci]
      ,[aurss_data_atto_di_nomina]
      ,[aurss_data_nomina]
      ,[aurss_data_fine_carica]
      ,[aurss_note]
      ,[aurss_rappresentante_legale]
      ,[aurss_data_modifica]
      ,[aurss_descr_utente]
      ,[aurss_codice_pk_db2]
      ,[aurss_relazione_certificata]     
      ,[aurss_cert_auten_cod_pk]
      ,[aurss_cert_cod_entita_rif]
      ,[aurss_cert_data_modifica]
      ,[aurss_indice_qualita_relazione]
      ,[aurss_auten_codice_pk]
      ,[aurss_codice_entita_rif]
      ,[aurss_codice_carica]
      ,[aurss_provenienza]
      ,[aurss_data_iscrizione]
      ,[aurss_flag_chiusura]
      ,[aurss_cap_agire]
      ,[aurss_flag_se_elettore]
      ,[aurss_potere_firma]
      ,[aurss_quote_partec]
      ,[aurss_perce_partec]
      ,[aurss_quote_partec_e]
      ,[aurss_quota_c_valuta]
      ,[aurss_cod_durata_carica]
      ,[aurss_anni_ese_carica]
      ,[aurss_data_pres_carica]
      ,[aurss_prog_pers]
      ,[aurss_progressivo_carica]
      ,rtrim(@causa) as [ausrs_causa_storicizzazione]
      ,rtrim(@utente) as [ausrs_utente_storicizzazione]
      ,Getdate() as [ausrs_data_storicizzazione]
      ,rtrim(@motivo) as [ausrs_motivo_storicizzazione]

FROM [AUC].[dbo].[tb_aurss_rel_sog_sog]
where  [aurss_codice_pk] = @CodAz) as tab



END




