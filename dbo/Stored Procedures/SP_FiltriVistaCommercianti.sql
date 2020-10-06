


-- Italo Paioletti 24/07/2014
-- Modificata da Raf 09/12/2014 aggiunta PEC ausca
-- Modificata da Raf 11/12/2014 aggiunta email ausca
CREATE PROCEDURE [dbo].[SP_FiltriVistaCommercianti]	@codFiscaleSoggetto varchar(16) AS
 BEGIN

	SELECT
		tb_ausco_sog_contr_col.ausco_cognome As CognomeSoggetto, 
		tb_ausco_sog_contr_col.ausco_nome As NomeSoggetto, 
		tb_ausca_sog_contr_az.ausca_codice_fiscale As CodiceFiscaleAzienda, 
		tb_ausca_sog_contr_az.ausca_denominazione  As DenominazioneAzienda, 
		tb_aungi_nat_giur_ct.aungi_codice_forma  As NaturaGiuridicaAzienda, 
		CONVERT(varchar(10),tb_ausca_sog_contr_az.ausca_data_inizio_attivita,103) As DataInizioAttivitaAzienda,		
		CONVERT(varchar(10),tb_ausca_sog_contr_az.ausca_data_fine_attivita,103) As DataFineAttivitaAzienda,
		tb_auate_cod_ateco_ct.auate_cod_ateco_complessivo  As Ateco2007Azienda, 
		tb_autis_tipo_sog_col_ct.autis_codice_carica As CodiceCarica, 
		CONVERT(varchar(10),tb_aurss_rel_sog_sog.aurss_data_inizio_validita,103) As DataInizioCarica,
		ausca_PEC as PEC_azienda,
		ausca_email as email_azienda,
		ausco_PEC as PEC_soggetto,
		ausco_email as email_soggetto
	FROM tb_ausco_sog_contr_col INNER JOIN tb_aurss_rel_sog_sog ON 
		tb_ausco_sog_contr_col.ausco_codice_pk = tb_aurss_rel_sog_sog.aurss_ausco_codice_pk INNER JOIN tb_ausca_sog_contr_az ON 
		tb_aurss_rel_sog_sog.aurss_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk INNER JOIN tb_aungi_nat_giur_ct ON 
		tb_ausca_sog_contr_az.ausca_aungi_codice_pk = tb_aungi_nat_giur_ct.aungi_codice_pk INNER JOIN tb_auate_cod_ateco_ct ON 
		tb_ausca_sog_contr_az.ausca_auate_2007_codice_pk = tb_auate_cod_ateco_ct.auate_codice_pk INNER JOIN tb_autis_tipo_sog_col_ct ON 
		tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
	WHERE tb_ausco_sog_contr_col.ausco_codice_fiscale = @codFiscaleSoggetto ;

 END


