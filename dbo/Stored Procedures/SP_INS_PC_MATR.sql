

-- =============================================
-- Author:		    Raffaele 
-- Modified date:   29 agosto 2012
-- Description:	    Gestione ateco in funzione della lunghezza del codice ateco

-- Author:			Raffaele
-- Modified date:	29 novembre 2012
-- Description:     Inserito l'update di aupoc_ausin_codice_pk 

-- Author:			Raffaele
-- Modified date:	5 dicembre 2012
-- Description:     Corretto un errore in fase di update aupoc_ausin_codice_pk

-- Modified date:	9 gennaio 2013
-- Description:     Corretto un errore in fase di update aupoc_ausin_codice_pk

-- Author:			Peter
-- Modified date:	20 agosto 2013
-- Description:     intervento AI 2036: eliminato CIDA e aggiunto aupoc_aurea_codice_pk

-- Author:			Peter
-- Modified date:	17 settembre 2013
-- Description:     Nelle SELECT da tb_auate_cod_ateco_ct aggiunto TOP 1 per gestire i rari casi di codici ripetuti 
--					(12 nella versione 1991 e 105 nella versione 2002)

-- Author:			Letizia
-- Modified date:	16 aprile 2015
-- Description:     aggiunto campo sullo stato della posizione contributiva per Gestione Separata

-- Author:			Peter
-- Action Item:     AI 2072
-- Modified date:	16 giugno 2016
-- Description:     aggiunta area 13 (Datore Voucher) per Gestione Separata
-- =============================================

CREATE PROCEDURE [dbo].[SP_INS_PC_MATR] 
	
	@aupoc_auapp_codice_pk int ,      --codice_applicazione
	@aupoc_descr_utente varchar(50),  --appName
	@aupoc_ausca_codice_pk int ,      --codice_azienda
	--AI 2036:
	--@aupoc_cida varchar(10), 
	--AI 2036.
	--AI 2050: aggiunto = NULL
	@aupoc_cod_provincia_istat varchar(3) = NULL, 
    @aupoc_cod_comune_istat varchar(3) = NULL, 
	@aupoc_prog_azienda_agr int = NULL, 
    @tipo_ditta varchar(2) = NULL,
    @tipo_ditta2 varchar(2) = NULL,
	@aupoc_data_inizio_attivita varchar(10) = NULL,
    @aupoc_denom_posiz_contr varchar(405) = NULL,
    @aupoc_codice_sede_inps varchar(6) = NULL,
    @auvas_data_variazione_stato varchar(10) = NULL,
    @codice_ateco varchar(20) = NULL,
	--AI 2050.
	--AI 2036:
	--@aupoc_posizione varchar(10), 
	@aupoc_posizione varchar(50), 
	--AI 2036.
    --AI 2036:
    @aupoc_aurea_codice_pk int,
    @tipo_posizione int,
    --AI 2036.
    @statoPosizioneContributiva integer,
	--AI 2050:
	@aupoc_id_sin varchar(10) = NULL,
	@aupoc_id_confluito varchar(10) = NULL,
	@aupoc_cf_confluito varchar(16) = NULL,
	@aupoc_progressivo_confluito varchar(5) = NULL,
	@aupoc_codice_gruppo varchar(6) = NULL,
	@aupoc_codice_categoria varchar(3) = NULL,
	@aupoc_aucom_codice varchar(1) = NULL,
	@descrizione_ateco varchar(200) = NULL,
	--AI 2050.
	@aupoc_stato_posizione_GS varchar (50)=NULL
AS
BEGIN
	SET NOCOUNT ON;
	
    -- ======================================================================================
    -- Prende l'ID del tipo ditta passato dalla tipologica [dbo.tb_autdt_tipoditta_ct]
    -- Se non lo trova (perchè è stato passato in maniera errata dal Client), inserisce NULL
    
    -- Prende l'ID del tipo ditta2 passato dalla tipologica [dbo.tb_autd2_tipoditta_ct]
    -- Se non lo trova (perchè è stato passato in maniera errata dal Client), inserisce NULL
    -- ======================================================================================
    DECLARE @id_tipo_ditta integer = NULL
    DECLARE @id_tipo_ditta2 integer = NULL
	DECLARE @id_cod_ateco integer = NULL
	DECLARE @desc_ateco varchar(200) = NULL
	DECLARE @denominazione_poscontr varchar(405) = NULL

	DECLARE @id_cod_ateco91 integer = NULL
	DECLARE @id_cod_ateco02 integer = NULL
	DECLARE @id_cod_ateco07 integer = NULL

	--AI 2036:
	DECLARE @aupoc_tipo_posizione integer = NULL
	--AI 2036.

	declare @LUNG integer;
	declare @ANNO integer;
	
	--AI 2050:
	--set @LUNG = LEN(@codice_ateco)
	set @LUNG = 0;
	IF (@codice_ateco IS NOT NULL)
	begin
		set @LUNG = LEN(@codice_ateco)
	end
	--AI 2050.

	--AI 2050:
	if (@aupoc_codice_sede_inps IS NULL)
	begin
		set @aupoc_codice_sede_inps = ''
	end
	
	declare @aupoc_data_inizio_attivita_date DateTime = NULL;
	if (@aupoc_data_inizio_attivita IS NOT NULL)
	begin
		set @aupoc_data_inizio_attivita_date = Convert(DateTime,@aupoc_data_inizio_attivita,103)
	end
	--AI 2050.

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

	if (@tipo_posizione > 0)
		begin
			--AI 2050: aggiunta if su area: per Gestione Separata non bisogna alterare aupoc_tipo_posizione
			--2016.06.16 AI 2072:
			--if (@aupoc_aurea_codice_pk <> 5 AND @aupoc_aurea_codice_pk <> 12)
			if (@aupoc_aurea_codice_pk <> 5 AND @aupoc_aurea_codice_pk <> 12 AND @aupoc_aurea_codice_pk <> 13)
			--2016.06.16 AI 2072.
			begin
				set @aupoc_tipo_posizione = @tipo_posizione - 1
			end
			else
			begin
				set @aupoc_tipo_posizione = @tipo_posizione
			end
		end
	else
		begin
			set @aupoc_tipo_posizione = NULL
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

			
    SET @id_tipo_ditta = 
    (
		SELECT autdt_codice_pk 
		FROM dbo.tb_autdt_tipoditta_ct 
		WHERE autdt_codice = @tipo_ditta
    )
    
    SET @id_tipo_ditta2 = 
    (
		SELECT autd2_codice_pk
		FROM dbo.tb_autd2_tipoditta2_ct
	    WHERE autd2_codice = @tipo_ditta2
    )


	--Peter 2015.06.15:
	DECLARE @aupoc_data_ultimo_stato Date = NULL
	SET @aupoc_data_ultimo_stato = @aupoc_data_inizio_attivita_date
	IF ((@statoPosizioneContributiva > 1) and (@auvas_data_variazione_stato IS NOT NULL) and (@auvas_data_variazione_stato <> ''''))
	BEGIN
		SET @aupoc_data_ultimo_stato = Convert(DateTime,@auvas_data_variazione_stato,103)
	END
	--Peter 2015.06.15.

    
	-- ----------------------------------------------------------------------------------------
	-- Maurizio 19 Luglio 2012 
	-- Se non viene passata la denominazione, quella di default è la denominazione dell'azienda
	-- ----------------------------------------------------------------------------------------
	IF (@aupoc_denom_posiz_contr = '') OR (@aupoc_denom_posiz_contr IS NULL)
		BEGIN
			SET @denominazione_poscontr = 
			(
				SELECT ausca_denominazione 
				FROM tb_ausca_sog_contr_az 
				WHERE ausca_codice_pk = @aupoc_ausca_codice_pk
			)
			print @denominazione_poscontr
		END
	ELSE SET @denominazione_poscontr = @aupoc_denom_posiz_contr
	
	
	INSERT INTO [dbo].[tb_aupoc_pos_contr]
           ([aupoc_ausca_codice_pk]
           ,[aupoc_auapp_codice_pk]
           ,[aupoc_auspc_codice_pk]
           ,[aupoc_autdt_codice_pk] -- rel. 3
           ,[aupoc_autd2_codice_pk] -- rel. 4           
           ,[aupoc_contro_codice]
           ,[aupoc_posizione]
           ,[aupoc_data_inizio_attivita]
           ,[aupoc_denom_posiz_contr]
           ,[Aupoc_cod_prov_istat]
           ,[Aupoc_cod_comune_istat]
           ,[Aupoc_prog_azienda_agr]
           ,[Aupoc_cida]
		   ,[aupoc_auate_1991_codice_pk]          -- rel. 4
		   ,[aupoc_auate_2002_codice_pk]          -- rel. 4
		   ,[aupoc_auate_2007_codice_pk]          -- rel. 4
		   ,[aupoc_ATECO]                         -- rel. 4
           ,[aupoc_cod_sede_INPS] -- rel. 3
           ,[aupoc_data_modifica]
           ,[aupoc_descr_utente]
		   --AI 2036:
		   ,[aupoc_aurea_codice_pk]
		   ,[aupoc_tipo_posizione]
		   --AI 2036.
		   ,[aupoc_DesATECO]      -- rel. 4
		   --AI 2050:
		   	,aupoc_id_sin 
			,aupoc_id_confluito 
			,aupoc_cf_confluito 
			,aupoc_progressivo_confluito 
			,aupoc_codice_gruppo 
			,aupoc_codice_categoria 
			,aupoc_aucom_codice 
		   --AI 2050.
		   ,aupoc_descr_stato_GS
		   --Peter 2015.06.15:
			,aupoc_data_ultimo_stato           
		   --Peter 2015.06.15:
)

	VALUES
       ( @aupoc_ausca_codice_pk,
         @aupoc_auapp_codice_pk,
	     --1, -- [aupoc_auspc_codice_pk] - stato della pos.contr: 'attiva'
         @statoPosizioneContributiva, -- [auvas_auspc_codice_pk] 
 	     @id_tipo_ditta,  -- rel. 3
 	     @id_tipo_ditta2, -- rel. 4
 	     '''',
	     @aupoc_posizione,
		 --AI 2050:
         --Convert(DateTime,@aupoc_data_inizio_attivita,103),
		 @aupoc_data_inizio_attivita_date,
		 --AI 2050.
         @denominazione_poscontr,
	     @aupoc_cod_provincia_istat, 
         @aupoc_cod_comune_istat, 
	     @aupoc_prog_azienda_agr, 
	     --AI 2036:
	     --@aupoc_cida, 
	     '''',
	     --AI 2036.
		 @id_cod_ateco91,         -- rel. 4
		 @id_cod_ateco02,         -- rel. 4
		 @id_cod_ateco07,         -- rel. 4
		 @codice_ateco,           -- rel. 4
		 @aupoc_codice_sede_inps, -- rel. 3
         GETDATE(),
         @aupoc_descr_utente,
         --AI 2036:
         @aupoc_aurea_codice_pk,
         @aupoc_tipo_posizione,
         --AI 2036.
         @desc_ateco,
		 --AI 2050:
		 @aupoc_id_sin,
		 @aupoc_id_confluito,
		 @aupoc_cf_confluito,
		 @aupoc_progressivo_confluito,
		 @aupoc_codice_gruppo,
		 @aupoc_codice_categoria,
		 @aupoc_aucom_codice, 
		 --AI 2050.
		 @aupoc_stato_posizione_GS
		--Peter 2015.06.15:
		,@aupoc_data_ultimo_stato           
		--Peter 2015.06.15:
         )
         
         IF @@ERROR = 0 
         BEGIN
         
			DECLARE @codice_pk_inserito INT
			SET     @codice_pk_inserito = SCOPE_IDENTITY()
		    SELECT  @codice_pk_inserito AS id
					
			-- GESTIONE CONTROCODICE --
			EXEC AZ_VALIDA_CC @codice_pk_inserito, 'AUPOC'
			
	        -----------------------------------------
			-- INSERISCO IL PRIMO STATO DELLA PC 
			-- NELLA TABELLA VARIAZIONI [AUVAS]
			-----------------------------------------
			INSERT INTO [dbo].[tb_auvas_var_stato_pos]
			(
					[auvas_aupoc_codice_pk]
				   ,[auvas_auspc_codice_pk]
				   ,[auvas_data_variazione_stato]
				   ,[auvas_utente]
				   ,[auvas_dispositivo_utente]
				   ,[auvas_data_modifica]
				   ,[auvas_descr_utente]
			)
			VALUES
			(
					@codice_pk_inserito
				   ,1 -- [auvas_auspc_codice_pk] - primo stato della pos.contr: ''attiva''
				   --,Convert(DateTime,@auvas_data_variazione_stato,103)
				   --AI 2050:
		           --,Convert(DateTime,@aupoc_data_inizio_attivita,103)
				   ,@aupoc_data_inizio_attivita_date
				   --AI 2050.
				   ,NULL
				   ,NULL
				   ,GETDATE()
				   ,@aupoc_descr_utente
			)
			
	        -----------------------------------------
			-- INSERISCO UN ALTRO STATO DELLA PC 
			-- NELLA TABELLA VARIAZIONI [AUVAS]
			-- SE E'' STATO PASSATO UNO STATO DIVERSO 
			-- DA ''ATTIVA'' (ID > 1)
			-----------------------------------------
			--AI 2050:
			--IF ((@statoPosizioneContributiva > 1) and (@auvas_data_variazione_stato <> ''''))
			IF ((@statoPosizioneContributiva > 1) and (@auvas_data_variazione_stato IS NOT NULL) and (@auvas_data_variazione_stato <> ''''))
			--AI 2050.
			BEGIN
			INSERT INTO [dbo].[tb_auvas_var_stato_pos]
			(
					[auvas_aupoc_codice_pk]
				   ,[auvas_auspc_codice_pk]
				   ,[auvas_data_variazione_stato]
				   ,[auvas_utente]
				   ,[auvas_dispositivo_utente]
				   ,[auvas_data_modifica]
				   ,[auvas_descr_utente]
			)
			VALUES
			(
					@codice_pk_inserito
				   ,@statoPosizioneContributiva -- [auvas_auspc_codice_pk] 
				   ,Convert(DateTime,@auvas_data_variazione_stato,103)
				   ,NULL
				   ,NULL
				   ,GETDATE()
				   ,@aupoc_descr_utente
			)
		   END
				-----------------------------------------
				-- Update della chiave verso AUSIN
				-----------------------------------------
				declare @c_sede varchar(4) = NULL
				declare @LUN integer = 0
					
				set @LUN = LEN(@aupoc_codice_sede_inps)

				if (@LUN = 4) 
				begin
					SET @c_sede = @aupoc_codice_sede_inps
				end
				else 
				begin 
					if (@LUN = 6) 
					begin
						SET @c_sede = SUBSTRING(@aupoc_codice_sede_inps,3,4) 
					end
				end
				if @c_sede is not null 
				begin
				
					UPDATE    tb_aupoc_pos_contr
					SET       aupoc_ausin_codice_pk = tb_ausin_sedi_inps_ct.ausin_codice_pk
					FROM  tb_aupoc_pos_contr INNER JOIN
                      tb_ausin_sedi_inps_ct ON @c_sede = tb_ausin_sedi_inps_ct.ausin_codice_sede
					WHERE     (tb_aupoc_pos_contr.aupoc_codice_pk = @codice_pk_inserito)
					
					--UPDATE    tb_aupoc_pos_contr
					--SET              aupoc_ausin_codice_pk = ausin_codice_pk 
					--FROM         tb_aupoc_pos_contr INNER JOIN
     --                 tb_ausin_sedi_inps_ct ON @c_sede = tb_ausin_sedi_inps_ct.ausin_codice_sede 				
				end	 
	  END
END


