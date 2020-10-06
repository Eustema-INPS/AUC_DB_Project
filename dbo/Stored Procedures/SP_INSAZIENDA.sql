


-- =============================================
-- Author:			Raffaele
-- Modified date: 	Marzo 2012
-- Description:		Implementazione dati azienda
-- Author:			Raffaele 
-- Modified date:	29 agosto 2012
-- Description:     Gestione ateco in funzione della lunghezza del codice ateco
-- Author:			Raffaele
-- Modified date:	29 novembre 2012
-- Description:     Inserita la chiamata alla stored AZ_1_SINCRONIZZA per la storicizzazione dei dati
-- Author:			Peter
-- Modified date:	17 settembre 2013
-- Description:     Nelle SELECT da tb_auate_cod_ateco_ct aggiunto TOP 1 per gestire i rari casi di codici ripetuti 
--					(12 nella versione 1991 e 105 nella versione 2002)
-- Author:			Raffaele 
-- Modified date:	23 maggio 2014
-- Description:     Il codice fiscale del soggetto deve essere memorizzato in maiuscolo
--
-- Author:			Peter 
-- Modified date:	2014.08.01
-- Action item:		2050
-- Description:     modifiche per compatibilità con il nuovo metodo "Aggiorna" di WSAggiornaAnagrUnicaContr
--
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSAZIENDA]

--AI 2050: aggiunto "= NULL" a tutti i parametri per renderli facoltativi
			
	@ausca_denominazione varchar(405) = NULL,
	@ausca_codice_fiscale varchar(16) = NULL,
	@ausca_aungi_codice_pk int = NULL,		  -- natura_giuridica
	@ausca_cciaa varchar(2) = NULL,
	@ausca_codice_toponimo varchar(3) = NULL,
	@ausca_indirizzo varchar(255) = NULL,
	@ausca_civico varchar(50) = NULL,
	@ausca_localita varchar(50) = NULL,
	@ausca_sede_legale_italia char(1) = NULL,
	@ausca_codice_comune varchar(4) = NULL,
	@ausca_descr_comune varchar(30) = NULL,
	@ausca_frazione varchar(100) = NULL,
	@ausca_sigla_provincia varchar(2) = NULL,
	@ausca_regione varchar(25) = NULL,
	@ausca_codice_stato_estero varchar(4) = NULL,
	@ausca_cap varchar(10) = NULL,
	@ausca_telefono1 varchar(20) = NULL,
	@ausca_telefono2 varchar(20) = NULL,
	@ausca_telefono3 varchar(20) = NULL,
	@ausca_fax varchar(20) = NULL,
	@ausca_telex varchar(20) = NULL,
	@ausca_email varchar(162) = NULL,
	@ausca_pec varchar(162) = NULL,
	@ausca_legalmail varchar(162) = NULL,
	@ausca_n_rea varchar(20) = NULL,
	@codice_ateco varchar(15) = NULL,       --ERA: @ausca_auate_codice_pk int,
	@ausca_codice_entita_rif int = NULL,  	 --codice_applicazione
	@ausca_note varchar(50) = NULL,
	@ausca_descr_utente varchar(50) = NULL, --appname
	@ausca_toponimo varchar(50) = NULL,
	@ausca_cognome varchar(255) = NULL,
	@ausca_nome varchar(150) = NULL,
	@ausca_codice_comune_istat varchar(6) = NULL,
	@ausca_codice_qualita_ind varchar(1) = NULL,
	--AI 2050:
	@ausca_codice_gruppo_enpals varchar(10) = NULL,         
	@ausca_codice_gestione int = NULL,               
	@ausca_provenienza_cert_gs varchar(5) = NULL,           
	@ausca_data_certificazione_gs datetime = NULL,
	@ausca_Stato varchar(50) = NULL,
	@descrizione_ateco varchar(200) = NULL,
	--AI 2050.
	@aupoc_data_inizio_attivita varchar(10) = NULL,
	@tipo_soggetto varchar(20) = NULL,
    @ausco_codice_fiscale varchar(16) = NULL,
    @ausco_denominazione varchar(405) = NULL,
    @ausco_cognome varchar(255) = NULL
		
AS
BEGIN
	SET NOCOUNT ON;
	
      DECLARE @id_cod_ateco integer = NULL
      DECLARE @desc_ateco varchar(200) = NULL

      DECLARE @id_cod_ateco91 integer = NULL
      DECLARE @id_cod_ateco02 integer = NULL
      DECLARE @id_cod_ateco07 integer = NULL

      declare @LUNG integer;
      declare @ANNO integer;
      
      set @LUNG = LEN(@codice_ateco)

      if (@LUNG = 5) 
      begin
            set @ANNO = 2002 
            SET @id_cod_ateco02 = 
            (
                  SELECT TOP 1 auate_codice_pk
                  FROM dbo.tb_auate_cod_ateco_ct
                  WHERE auate_cod_ateco_complessivo = @codice_ateco AND auate_anno_riferimento = @ANNO
            )
            set @id_cod_ateco = @id_cod_ateco02 
      end
      else
      begin
            set @ANNO = 2007
            SET @id_cod_ateco07 = 
            (
                  SELECT TOP 1 auate_codice_pk
                  FROM dbo.tb_auate_cod_ateco_ct
                  WHERE auate_cod_ateco_complessivo = @codice_ateco AND auate_anno_riferimento = @ANNO
            )
            set @id_cod_ateco = @id_cod_ateco07 
      end

	  --AI 2050: se fornita descrizione ATECO dall'esterno, non la ricavo dal codice 
		--SET @desc_ateco = 
		--(
		--	SELECT TOP 1 auate_cod_sottocategoria_tit
		--	FROM dbo.tb_auate_cod_ateco_ct
		--	WHERE auate_cod_ateco_complessivo = @codice_ateco AND auate_anno_riferimento = @ANNO
		--)
	  if (@descrizione_ateco is not null)
	  begin
			SET @desc_ateco = @descrizione_ateco
	  end
	  else
	  begin
		  SET @desc_ateco = 
		  (
				SELECT TOP 1 auate_cod_sottocategoria_tit
				FROM dbo.tb_auate_cod_ateco_ct
				WHERE auate_cod_ateco_complessivo = @codice_ateco AND auate_anno_riferimento = @ANNO
		  )
	  end
	  --AI 2050.

	--Peter 2015.06.15:
	if (@ausca_denominazione IS NULL AND @ausca_cognome IS NOT NULL AND @ausca_nome IS NOT NULL)
	begin
		SET @ausca_denominazione = @ausca_cognome + ' ' + @ausca_nome
	end 
	--Peter 2015.06.15.

				
	--2016.05.11:
	if (@ausca_telefono1 IS NULL OR ltrim(rtrim(@ausca_telefono1)) = '') begin set @ausca_telefono1 = '000000' end
	if (@ausca_telefono2 IS NULL OR ltrim(rtrim(@ausca_telefono2)) = '') begin set @ausca_telefono2 = '000000' end
	if (@ausca_telefono3 IS NULL OR ltrim(rtrim(@ausca_telefono3)) = '') begin set @ausca_telefono3 = '000000' end
	if (@ausca_fax IS NULL OR ltrim(rtrim(@ausca_fax)) = '') begin set @ausca_fax = '000000' end
	--2016.05.11.


	INSERT INTO [dbo].[tb_ausca_sog_contr_az]
           ([ausca_denominazione],
	        [ausca_contro_codice],
            [ausca_codice_fiscale],
            [ausca_aungi_codice_pk],
            [ausca_cciaa],
            [ausca_codice_toponimo],
            [ausca_indirizzo],
            [ausca_civico],
            [ausca_localita],
            [ausca_sede_legale_italia],
            [ausca_codice_comune],
            [ausca_descr_comune],
	        [ausca_frazione],
	        [ausca_sigla_provincia],
	        [ausca_regione],
	        [ausca_codice_stato_estero],
            [ausca_cap],
            [ausca_telefono1],
            [ausca_telefono2],
            [ausca_telefono3],
            [ausca_fax],
            [ausca_telex],
            [ausca_email],
            [ausca_PEC],
            [ausca_legalmail],
            [ausca_n_rea],
            [ausca_auate_codice_pk],
            [ausca_auate_1991_codice_pk],          --
            [ausca_auate_2002_codice_pk],          --
            [ausca_auate_2007_codice_pk],          --
            [ausca_ATECO],                         --
			[ausca_DesATECO],					   --
            [ausca_codice_entita_rif],
            [ausca_note],
            [ausca_descr_utente],
            [ausca_toponimo],
            [ausca_soggetto_certificato],
            [ausca_auten_codice_pk],
            [ausca_data_modifica],
			[ausca_cognome],
			[ausca_nome],
			[ausca_codice_comune_istat],
			[ausca_codice_qualita_ind],
			--AI 2050:
			[ausca_codice_gruppo_enpals],         
			[ausca_codice_gestione],               
			[ausca_provenienza_cert_gs],           
			[ausca_data_certificazione_gs],
			[ausca_Stato],
			--AI 2050.
			[ausca_data_inizio_attivita])
			
     VALUES
           (@ausca_denominazione,
	        '',
			upper(@ausca_codice_fiscale),
			@ausca_aungi_codice_pk,	
			@ausca_cciaa,
			@ausca_codice_toponimo,
			@ausca_indirizzo,
			@ausca_civico,
			@ausca_localita,
			@ausca_sede_legale_italia,
			@ausca_codice_comune,
			@ausca_descr_comune,
			@ausca_frazione,
			@ausca_sigla_provincia,
			@ausca_regione,
			@ausca_codice_stato_estero,
			@ausca_cap,
			@ausca_telefono1,
			@ausca_telefono2,
			@ausca_telefono3,
			@ausca_fax,
			@ausca_telex,
			@ausca_email,
			@ausca_pec,
			@ausca_legalmail,
			@ausca_n_rea,
			@id_cod_ateco,			--@ausca_auate_codice_pk,
			@id_cod_ateco91,		--	
			@id_cod_ateco02,		--	
			@id_cod_ateco07,		--	
			@codice_ateco,			--
			@desc_ateco,			--
			@ausca_codice_entita_rif,  
			@ausca_note,
			@ausca_descr_utente, 
			@ausca_toponimo,
			'N',
			'3',
			GETDATE(),
			@ausca_cognome,
			@ausca_nome,
			@ausca_codice_comune_istat,
			@ausca_codice_qualita_ind,
			--AI 2050:
			@ausca_codice_gruppo_enpals,         
			@ausca_codice_gestione,               
			@ausca_provenienza_cert_gs,           
			@ausca_data_certificazione_gs,
			@ausca_Stato,
			--AI 2050.

			--@aupoc_data_inizio_attivita
            Convert(DateTime,@aupoc_data_inizio_attivita,103));
            --print 'dopo insert su ausca ' + convert(varchar, @@ERROR)
		
		
		    -- ============================================
		    -- CODICE CC e RITORNO DELL'ID AZIENDA INSERITO
		    -- ============================================
			DECLARE @codice_pk_inserito integer;
			SET     @codice_pk_inserito = SCOPE_IDENTITY();
			SELECT  @codice_pk_inserito AS id
			
			EXEC AZ_VALIDA_CC @codice_pk_inserito, 'AUSCA';	
			--print ' dopo calcolo contro codice: '+ convert(varchar, @codice_pk_inserito)


		    -- ============================================
		    -- Inserimento dei dati storici 
		    -- ============================================

			EXEC AZ_1_SINCRONIZZA @codice_pk_inserito, '3', @ausca_codice_entita_rif;	


		    -- ============================================
		    -- AUCFI
		    -- ============================================
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
				    @codice_pk_inserito,
					upper(@ausca_codice_fiscale),
					GETDATE(),
					GETDATE(),
					@ausca_descr_utente
				   )
            --print 'dopo insert su aucfi'
END

