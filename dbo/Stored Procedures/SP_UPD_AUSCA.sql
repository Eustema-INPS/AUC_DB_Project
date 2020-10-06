



-- ===========================================================================
-- Author:		Peter
-- Action item: 2050
-- Create date: 01/08/2014
-- Description:	
-- Update generalizzato AUSCA: tutte le colonne sono facoltative
-- ===========================================================================
CREATE PROCEDURE [dbo].[SP_UPD_AUSCA] 
	
	@ausca_codice_pk int,
	@ausca_descr_utente VARCHAR(50) = NULL,	--appname
	@ausca_codice_comune varchar(4) = NULL,
	@ausca_regione varchar(25) = NULL,
	@ausca_codice_stato_estero varchar(4) = NULL,
	@ausca_denominazione varchar(405) = NULL,
	@ausca_codice_fiscale varchar(16) = NULL,
	@ausca_aungi_codice_pk int = NULL,	--natura_giuridica
	@ausca_cciaa varchar(2) = NULL,
	@ausca_codice_toponimo varchar(3) = NULL,
	@ausca_indirizzo varchar(255) = NULL,
	@ausca_civico varchar(50) = NULL,
	@ausca_localita varchar(50) = NULL,
	@ausca_sede_legale_italia char(1) = NULL,
	@ausca_descr_comune varchar(30) = NULL,
	@ausca_frazione varchar(100) = NULL,
	@ausca_sigla_provincia varchar(2) = NULL,
	@ausca_cap varchar(10) = NULL,
	@ausca_telefono1 varchar(20) = NULL,
	@ausca_telefono2 varchar(20) = NULL,
	@ausca_telefono3 varchar(20) = NULL,
	@ausca_fax varchar(20) = NULL,
	@ausca_telex varchar(20) = NULL,
	@ausca_email varchar(162) = NULL,
	@ausca_pec varchar(162) = NULL,
	@ausca_n_rea varchar(20) = NULL,
	@codice_ateco varchar(15) = NULL,
	--AI 2050:
	@descrizione_ateco varchar(200) = NULL,
	--AI 2050.		
	@ausca_codice_entita_rif int = NULL,	--codice_applicazione
	@ausca_note varchar(50) = NULL,
	@ausca_toponimo varchar(50) = NULL,
	@ausca_cognome varchar(255) = NULL,
	@ausca_nome varchar(150) = NULL,
	@ausca_codice_comune_istat varchar(6) = NULL,
	@ausca_codice_qualita_ind varchar(1) = NULL,
	@ausca_codice_gruppo_enpals varchar(10) = NULL,         
	@ausca_codice_gestione int = NULL,               
	@ausca_provenienza_cert_gs varchar(5) = NULL,           
	@ausca_data_certificazione_gs datetime = NULL,
	@ausca_Stato varchar(50) = NULL
	
AS
BEGIN
	SET NOCOUNT ON;	

	  set @ausca_codice_fiscale = upper(@ausca_codice_fiscale)
	
	  DECLARE @id_cod_ateco integer = NULL
      DECLARE @desc_ateco varchar(200) = NULL

      DECLARE @id_cod_ateco91 integer = NULL
      DECLARE @id_cod_ateco02 integer = NULL
      DECLARE @id_cod_ateco07 integer = NULL

      declare @LUNG integer;
      declare @ANNO integer;
      
      set @LUNG = LEN(@codice_ateco)

	  	--2016.05.13:
		if (@ausca_telefono1 IS NULL OR ltrim(rtrim(@ausca_telefono1)) = '') begin set @ausca_telefono1 = '000000' end
		if (@ausca_telefono2 IS NULL OR ltrim(rtrim(@ausca_telefono2)) = '') begin set @ausca_telefono2 = '000000' end
		if (@ausca_telefono3 IS NULL OR ltrim(rtrim(@ausca_telefono3)) = '') begin set @ausca_telefono3 = '000000' end
		if (@ausca_fax IS NULL OR ltrim(rtrim(@ausca_fax)) = '') begin set @ausca_fax = '000000' end
		--2016.05.13.


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
      --      SELECT TOP 1 auate_cod_sottocategoria_tit
      --      FROM dbo.tb_auate_cod_ateco_ct
      --      WHERE auate_cod_ateco_complessivo = @codice_ateco AND auate_anno_riferimento = @ANNO
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


	BEGIN
	UPDATE [dbo].[tb_ausca_sog_contr_az]
		SET 
 [ausca_data_modifica]                     =       getdate()                                
,[ausca_descr_utente]                      =       ISNULL(@ausca_descr_utente                   ,[ausca_descr_utente]                     )                  
,[ausca_codice_comune]                     =       ISNULL(@ausca_codice_comune                  ,[ausca_codice_comune]                    )  
,[ausca_regione]                           =       ISNULL(@ausca_regione                        ,[ausca_regione]                          )  
,[ausca_codice_stato_estero]               =       ISNULL(@ausca_codice_stato_estero            ,[ausca_codice_stato_estero]              )  
,[ausca_aungi_codice_pk]                   =       ISNULL(@ausca_aungi_codice_pk                ,[ausca_aungi_codice_pk]                  )  
,[ausca_auate_codice_pk]                   =       ISNULL(@id_cod_ateco			                ,[ausca_auate_codice_pk]                  )
,[ausca_auate_1991_codice_pk]              =       ISNULL(@id_cod_ateco91	                    ,[ausca_auate_1991_codice_pk]             )     
,[ausca_auate_2002_codice_pk]              =       ISNULL(@id_cod_ateco02	                    ,[ausca_auate_2002_codice_pk]             )     
,[ausca_auate_2007_codice_pk]              =       ISNULL(@id_cod_ateco07	                    ,[ausca_auate_2007_codice_pk]             )     
,[ausca_ATECO]                             =       ISNULL(@codice_ateco					        ,[ausca_ATECO]                            )
,[ausca_DesATECO]                          =       ISNULL(@desc_ateco					        ,[ausca_DesATECO]                         )   
,[ausca_denominazione]                     =       ISNULL(@ausca_denominazione                  ,[ausca_denominazione]                    )  
,[ausca_codice_fiscale]                    =       ISNULL(@ausca_codice_fiscale                 ,[ausca_codice_fiscale]                   )
,[ausca_cciaa]                             =       ISNULL(@ausca_cciaa                          ,[ausca_cciaa]                            )  
,[ausca_codice_toponimo]                   =       ISNULL(@ausca_codice_toponimo                ,[ausca_codice_toponimo]                  )  
,[ausca_indirizzo]                         =       ISNULL(@ausca_indirizzo                      ,[ausca_indirizzo]                        )  
,[ausca_civico]                            =       ISNULL(@ausca_civico                         ,[ausca_civico]                           )  
,[ausca_localita]                          =       ISNULL(@ausca_localita                       ,[ausca_localita]                         )  
,[ausca_sede_legale_italia]                =       ISNULL(@ausca_sede_legale_italia             ,[ausca_sede_legale_italia]               )  
,[ausca_frazione]                          =       ISNULL(@ausca_frazione                       ,[ausca_frazione]                         )  
,[ausca_sigla_provincia]                   =       ISNULL(@ausca_sigla_provincia                ,[ausca_sigla_provincia]                  )  
,[ausca_cap]                               =       ISNULL(@ausca_cap                            ,[ausca_cap]                              )  
,[ausca_telefono1]                         =       ISNULL(@ausca_telefono1                      ,[ausca_telefono1]                        )  
,[ausca_telefono2]                         =       ISNULL(@ausca_telefono2                      ,[ausca_telefono2]                        )  
,[ausca_telefono3]                         =       ISNULL(@ausca_telefono3                      ,[ausca_telefono3]                        )  
,[ausca_fax]                               =       ISNULL(@ausca_fax                            ,[ausca_fax]                              )  
,[ausca_telex]                             =       ISNULL(@ausca_telex                          ,[ausca_telex]                            )  
,[ausca_email]                             =       ISNULL(@ausca_email                          ,[ausca_email]                            )  
,[ausca_pec]                               =       ISNULL(@ausca_pec                            ,[ausca_pec]                              )  
,[ausca_n_rea]                             =       ISNULL(@ausca_n_rea                          ,[ausca_n_rea]                            )  
,[ausca_codice_entita_rif]                 =       ISNULL(@ausca_codice_entita_rif              ,[ausca_codice_entita_rif]                )  
,[ausca_note]                              =       ISNULL(@ausca_note                           ,[ausca_note]                             )  
,[ausca_toponimo]                          =       ISNULL(@ausca_toponimo                       ,[ausca_toponimo]                         )  
,[ausca_cognome]                           =       ISNULL(@ausca_cognome                        ,[ausca_cognome]                          )  
,[ausca_nome]                              =       ISNULL(@ausca_nome                           ,[ausca_nome]                             )  
,[ausca_codice_comune_istat]               =       ISNULL(@ausca_codice_comune_istat            ,[ausca_codice_comune_istat]              )  
,[ausca_codice_qualita_ind]                =       ISNULL(@ausca_codice_qualita_ind             ,[ausca_codice_qualita_ind]               )  
,[ausca_codice_gestione]                   =       ISNULL(@ausca_codice_gestione                ,[ausca_codice_gestione]                  )  
,[ausca_provenienza_cert_gs]               =       ISNULL(@ausca_provenienza_cert_gs            ,[ausca_provenienza_cert_gs]              )  
,[ausca_data_certificazione_gs]            =       ISNULL(@ausca_data_certificazione_gs         ,[ausca_data_certificazione_gs]           )  
,[ausca_Stato]                             =       ISNULL(@ausca_Stato                          ,[ausca_Stato]                            )  


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


