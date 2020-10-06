

CREATE PROCEDURE [dbo].[AZ_ElencoSoggettiCertInfoCamere]
	@SIGLA_PROVINCIA VARCHAR(2),
	@CODICE_ATECO	VARCHAR(6),
	@FORMA_GIURIDICA VARCHAR(2)
		
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT TOP 200
		TASC.ausca_codice_fiscale as CodiceFiscale,
		TASC.ausca_piva as PartitaIva,
		TASC.ausca_cciaa + ' ' + TASC.ausca_n_rea as NumeroREA,
		TASC.ausca_denominazione as RagioneSociale,
		TASC.Ausca_descr_comune as Comune,
		TASC.ausca_sigla_provincia as Provincia,
		TASC.ausca_toponimo as Toponimo,
		TASC.ausca_indirizzo as Via,
		TASC.ausca_civico as Civico,
		TASC.ausca_cap as CAP,
		TASC.ausca_frazione as Frazione,
		TASC.ausca_PEC as PEC,
		TANG.aungi_codice_forma as CodiceFormaGiuridica,
		TANG.aungi_descr_breve as FormaGiuridica,
		TAAA.auata_classificazione_ateco as AnnoClassificazioneAteco,
		TAAA.auata_cod_att_output as CodiceAteco,
		TAAA.auata_descr_attivita as DescrizioneAteco,
		TAAA.auata_cod_importanza as CodiceImportanza,
		TAAA.auata_importanza as DescrizioneImportanza,
		TAAA.auata_dt_inizio as DataInizioAteco,
		TAAA.auata_dt_fine as DataFineAteco
	FROM tb_ausca_sog_contr_az AS TASC
	LEFT OUTER JOIN tb_aungi_nat_giur_ct AS TANG on 
		TANG.aungi_codice_pk = TASC.ausca_aungi_codice_pk 	
	LEFT OUTER JOIN tb_auata_ateco_ausca AS TAAA on 
		TAAA.auata_ausca_codice_pk = TASC.ausca_codice_pk 

	WHERE 
		TASC.ausca_soggetto_certificato = 'S'  
		and TASC.ausca_cert_auten_cod_pk = 2  
		and TASC.ausca_cert_cod_entita_rif = 1 
	
		and (ISNULL(@SIGLA_PROVINCIA,'') = '' or TASC.ausca_sigla_provincia = @SIGLA_PROVINCIA) -- Parameto Province
		and (ISNULL(@FORMA_GIURIDICA,'') = '' or TANG.aungi_codice_forma = @FORMA_GIURIDICA) -- Parametro Foma Giuridica
		and (ISNULL(@CODICE_ATECO,'') = '' or TAAA.auata_cod_att_output = @CODICE_ATECO) -- Parametro Codice ATECO

	ORDER BY
		TASC.ausca_denominazione ASC;
    
END

