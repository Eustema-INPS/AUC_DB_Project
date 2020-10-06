


-- =============================================
-- Author:		Martini
-- Create date: 
-- Description:	
-- Author:			Raffaele 
-- Modified date:	29 agosto 2012
-- Description:     Gestione ateco in funzione della lunghezza del codice ateco
-- Author:			Raffaele
-- Modified date:	29 novembre 2012
-- Description:     Inserita la chiamata alla stored AZ_1_SINCRONIZZA per la storicizzazione dei dati
-- Modified date:	7 ottobre 2013
-- Description:     Nelle SELECT da tb_auate_cod_ateco_ct aggiunto TOP 1 per gestire i rari casi di codici ripetuti 
--					(12 nella versione 1991 e 105 nella versione 2002)
-- Author:			Raffaele 
-- Modified date:	23 maggio 2014
-- Description:     Il codice fiscale del soggetto deve essere memorizzato in maiuscolo
-- ===========================================================================
CREATE PROCEDURE [dbo].[SP_UPDAZIENDA] 
	
	@ausca_descr_utente VARCHAR(50),	--appname
	@ausca_codice_pk int,
	@ausca_codice_comune varchar(4),
	@ausca_regione varchar(25),
	@ausca_codice_stato_estero varchar(4),
	@ausca_denominazione varchar(405),
	@ausca_codice_fiscale varchar(16),
	@ausca_aungi_codice_pk int,	--natura_giuridica
	@ausca_cciaa varchar(2),
	@ausca_codice_toponimo varchar(3),
	@ausca_indirizzo varchar(255),
	@ausca_civico varchar(50),
	@ausca_localita varchar(50),
	@ausca_sede_legale_italia char(1),
	@ausca_descr_comune varchar(30),
	@ausca_frazione varchar(100),
	@ausca_sigla_provincia varchar(2),
	@ausca_cap varchar(10),
	@ausca_telefono1 varchar(20),
	@ausca_telefono2 varchar(20),
	@ausca_telefono3 varchar(20),
	@ausca_fax varchar(20),
	@ausca_telex varchar(20),
	@ausca_email varchar(162),
	@ausca_pec varchar(162),
	@ausca_legalmail varchar(162),
	@ausca_n_rea varchar(20),
	@codice_ateco varchar(15),		--ERA: @ausca_auate_codice_pk int,
	@ausca_codice_entita_rif int,	--codice_applicazione
	@ausca_note varchar(50),
	@ausca_toponimo varchar(50),
	@ausca_cognome varchar(255),
	@ausca_nome varchar(150),
	@ausca_codice_comune_istat varchar(6),
	@ausca_codice_qualita_ind varchar(1)
	
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

      SET @desc_ateco = 
      (
            SELECT TOP 1 auate_cod_sottocategoria_tit
            FROM dbo.tb_auate_cod_ateco_ct
            WHERE auate_cod_ateco_complessivo = @codice_ateco AND auate_anno_riferimento = @ANNO
      )


	--2016.05.13:
	if (@ausca_telefono1 IS NULL OR ltrim(rtrim(@ausca_telefono1)) = '') begin set @ausca_telefono1 = '000000' end
	if (@ausca_telefono2 IS NULL OR ltrim(rtrim(@ausca_telefono2)) = '') begin set @ausca_telefono2 = '000000' end
	if (@ausca_telefono3 IS NULL OR ltrim(rtrim(@ausca_telefono3)) = '') begin set @ausca_telefono3 = '000000' end
	if (@ausca_fax IS NULL OR ltrim(rtrim(@ausca_fax)) = '') begin set @ausca_fax = '000000' end
	--2016.05.13.


	BEGIN
	UPDATE [dbo].[tb_ausca_sog_contr_az]
		SET [ausca_data_modifica] = getdate()
		  ,[ausca_descr_utente] = @ausca_descr_utente
		  ,[ausca_codice_comune] = @ausca_codice_comune
		  ,[ausca_regione] = @ausca_regione
		  ,[ausca_codice_stato_estero] = @ausca_codice_stato_estero
		  ,[ausca_aungi_codice_pk] = @ausca_aungi_codice_pk 
		  ,[ausca_auate_codice_pk] = @id_cod_ateco			--@ausca_auate_codice_pk
		  ,[ausca_auate_1991_codice_pk] = @id_cod_ateco91	--
		  ,[ausca_auate_2002_codice_pk] = @id_cod_ateco02	--
		  ,[ausca_auate_2007_codice_pk] = @id_cod_ateco07	--
		  ,[ausca_ATECO] = @codice_ateco					--
		  ,[ausca_DesATECO] = @desc_ateco					--
		  ,[ausca_denominazione] = @ausca_denominazione
		  ,[ausca_codice_fiscale] = upper(@ausca_codice_fiscale)
		  ,[ausca_cciaa] = @ausca_cciaa
		  ,[ausca_codice_toponimo] = @ausca_codice_toponimo 
		  ,[ausca_indirizzo] = @ausca_indirizzo
		  ,[ausca_civico] = @ausca_civico
		  ,[ausca_localita] = @ausca_localita
		  ,[ausca_sede_legale_italia] = @ausca_sede_legale_italia
		  ,[ausca_frazione] = @ausca_frazione
		  ,[ausca_sigla_provincia] = @ausca_sigla_provincia
		  ,[ausca_cap] = @ausca_cap
		  ,[ausca_telefono1] = @ausca_telefono1
		  ,[ausca_telefono2] = @ausca_telefono2
		  ,[ausca_telefono3] = @ausca_telefono3
		  ,[ausca_fax] = @ausca_fax
		  ,[ausca_telex] = @ausca_telex
		  ,[ausca_email] = @ausca_email
		  ,[ausca_pec] = @ausca_pec
		  ,[ausca_legalmail] = @ausca_legalmail
		  ,[ausca_n_rea] = @ausca_n_rea
		  ,[ausca_codice_entita_rif] = @ausca_codice_entita_rif
		  ,[ausca_note] = @ausca_note
		  ,[ausca_toponimo] = @ausca_toponimo 
	      ,[ausca_cognome] = @ausca_cognome
		  ,[ausca_nome] = @ausca_nome
		  ,[ausca_codice_comune_istat] = @ausca_codice_comune_istat 
		  ,[ausca_codice_qualita_ind] = @ausca_codice_qualita_ind
		  --Peter AI 6088:
		  ,[ausca_descr_comune] = @ausca_descr_comune
		  --Peter AI 6088.

		  WHERE [ausca_codice_pk] = @ausca_codice_pk
	END
	
	
	-- ============================================================
	-- TIENE TRACCIA DELLA VARIAZIONE DEL CODICE FISCALE >> -AUCFI-
	-- ============================================================
	IF @@ERROR = 0 
    BEGIN
		DECLARE @cf_azienda VARCHAR(405)
		
		SET @cf_azienda = 
		(
			SELECT [ausca_codice_fiscale] 
			FROM   [dbo].[tb_ausca_sog_contr_az] 
			WHERE  ausca_codice_pk = @ausca_codice_pk
		)
		
		IF @ausca_codice_fiscale <> @cf_azienda 
		BEGIN
			-- VARIAZIONE CODICI FISCALI - AUCFI 	
			INSERT INTO [dbo].[tb_aucfi_cod_fiscale]
					    (
							[aucfi_ausca_codice_pk],
							[aucfi_codice_fiscale],
							[aucfi_data_inizio_validita]
					    )
			 VALUES
				   (
						@ausca_codice_pk,
						upper(@ausca_codice_fiscale),
						GETDATE()
				    )
		END
		    -- ============================================
		    -- Inserimento dei dati storici 
		    -- ============================================

			EXEC AZ_1_SINCRONIZZA @ausca_codice_pk, '3', @ausca_codice_entita_rif;	

	END	
END

