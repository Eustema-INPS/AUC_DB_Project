
-- ===================================================================
-- Author:		Vannimartini
-- Create date: 24/05/2013
-- Description:	Inserimento di una nuova Azienda (Tipo Azione A2/A3)
-- ===================================================================
CREATE PROCEDURE [dbo].[AZ_InserimentoNuovaAziendaCF] 
	@CF_orig varchar(16),
	@CF_new varchar(16),
	@ausca_codice_pk int,
	@codicePosizione varchar(20),
	@descrUtente varchar(50),
	--@codiceAzienda varchar(20),
	@CodMatricola varchar(20),
	@tipoAzione varchar(2),
	@interazioneUtente varchar(3),
	@Denominazione varchar(405),
	@Cognome varchar(255),
	@Nome varchar(150),
	@PartitaIva varchar(11),
	@Toponimo varchar(50),
	@Indirizzo varchar(255),
	@Civico varchar(50),
	@CAP varchar(10),
	@Provincia varchar(2),
	@Comune varchar(30),
	@Localita varchar(50),
	@Telefono1 varchar(20),
	@Telefono2 varchar(20),
	@Telefono3 varchar(20) = NULL,
	@Fax varchar(20),
	@DataInizioAttivita varchar(10), --da convertire in DateTime
	@NaturaGiuridica varchar(6),	--da convertire in Integer
	@SedeLegaleIta varchar(1) = NULL,
	@Email varchar(162),
	@Pec varchar(162),
	@auute_utenza varchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	
	
	-- =========================================================================================
    -- AUSCA - Inserimento della nuova Azienda
    -- =========================================================================================
    
    -- reperimento del CodiceEntita in funzione dell'Utente connesso (@auute_utenza)
    DECLARE @auute_codice_pk AS int
    SELECT	@auute_codice_pk = auute_codice_pk
	FROM	[dbo].[tb_auute_ute_sistema]
	WHERE	auute_utenza = @auute_utenza
    
    -- Inserimento della nuova Azienda in AUSCA
    INSERT INTO [dbo].[tb_ausca_sog_contr_az]
    (
		ausca_denominazione,
		ausca_cognome,
		ausca_nome,
		ausca_codice_fiscale,
		ausca_piva,
		ausca_toponimo,
		ausca_indirizzo,
		ausca_civico,
		ausca_cap,
		ausca_sigla_provincia,
		ausca_descr_comune,
		ausca_localita,
		ausca_telefono1,
		ausca_telefono2,
		ausca_telefono3,
		ausca_fax,
		ausca_data_inizio_attivita,
		ausca_aungi_codice_pk,
		ausca_sede_legale_italia,
		ausca_email,
		ausca_PEC,
		ausca_auten_codice_pk,
		ausca_codice_entita_rif
    )
    VALUES
    (
		@Denominazione,
		@Cognome,
		@Nome,
		@CF_new,
		@PartitaIva,
		@Toponimo,
		@Indirizzo,
		@Civico,
		@CAP,
		@Provincia,
		@Comune,
		@Localita,
		@Telefono1,
		@Telefono2,
		@Telefono3,
		@Fax,
		CONVERT(datetime, @DataInizioAttivita),
		CONVERT(integer, @NaturaGiuridica),
		--CASE @SedeLegaleIta
		--	WHEN 'NO' THEN 'N'
		--	ELSE 'S'
		--END,
		@SedeLegaleIta,
		@Email,
		@Pec,
		1,
		@auute_codice_pk
    )



	-- =========================================================================================
    -- AUCFI - Inserimento del nuovo codice fiscale relativo al codice fiscale di destinazione
    -- =========================================================================================
	INSERT INTO [dbo].[tb_aucfi_cod_fiscale]
	(
	   [aucfi_ausca_codice_pk],
	   [aucfi_codice_fiscale],
	   [aucfi_data_inizio_validita],
	   [aucfi_data_modifica],
       [aucfi_descr_utente]
	)
	VALUES
	(
		@ausca_codice_pk,
		@CF_new,
		GETDATE(),
		GETDATE(),
		@descrUtente
	)
	
	-- ================================================
	-- AUCFI - modifica del codice fiscale di origine
	-- ================================================
	UPDATE [dbo].[tb_aucfi_cod_fiscale]
	SET	
		[aucfi_data_fine_validita] = GETDATE(),
		[aucfi_data_modifica] = GETDATE(),
		[aucfi_descr_utente] = @descrUtente
	WHERE
		[aucfi_ausca_codice_pk] = @ausca_codice_pk AND
		[aucfi_codice_fiscale] = @CF_orig
	

	
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100
END


