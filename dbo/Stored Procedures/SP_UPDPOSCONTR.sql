-- ===========================================================================
-- Author:		  Raffaele & Maurizio
-- Modified date: Marzo 2012
-- Description:	  Estensione attributi gestiti

-- Author:		  Raffaele 
-- Modified date: 29 agosto 2012
-- Description:	  Gestione ateco in funzione della lunghezza del codice ateco

-- Author:			Raffaele
-- Modified date:	29 novembre 2012
-- Description:     Inserito l'update di aupoc_ausin_codice_pk 

-- Author:			Raffaele
-- Modified date:	5 dicembre 2012
-- Description:     Corretto un errore in fase di update aupoc_ausin_codice_pk

-- Modified date:	9 gennaio 2013
-- Description:     Corretto un errore in fase di update aupoc_ausin_codice_pk

-- Author:			Peter
-- Modified date:	23 agosto 2013
-- Description:     modifiche per Action Item 2036

-- Author:			Peter
-- Modified date:	7 ottobre 2013
-- Description:     Nelle SELECT da tb_auate_cod_ateco_ct aggiunto TOP 1 per gestire i rari casi di codici ripetuti 
--					(12 nella versione 1991 e 105 nella versione 2002)

-- Author:			Peter
-- Modified date:	24 settembre 2014
-- Action Item:     2050
-- Description:     Aggiunti parametri (facolatativi) per metodo web service "Aggiorna"

-- Author:			Letizia
-- Modified date:	16 aprile 2015
-- Description:     aggiunto campo sullo stato della posizione contributiva per Gestione Separata

-- Author:			Peter
-- Action Item:     AI 2072
-- Modified date:	16 giugno 2016
-- Description:     aggiunta area 13 (Datore Voucher) per Gestione Separata
-- ===========================================================================
CREATE PROCEDURE [dbo].[SP_UPDPOSCONTR] 
	
    @aupoc_codice_pk int,		          --codice_pk
    @aupoc_posizione varchar(50),           --posizione

	--AI 2036: aggiunta clausola "= null" per gestire il caso in cui la corrispondente colonna non cambia valore
	@aupoc_ausca_codice_pk int = null,           --codice_azienda
	@aupoc_auapp_codice_pk int = null,		      --codice_applicazione
	@aupoc_descr_utente varchar(50) = null,      --appName
	--AI 2036:
	--@aupoc_cida varchar(10),	
	--AI 2036.
	@aupoc_cod_comune_istat varchar(3) = null,
	@aupoc_cod_prov_istat varchar(3) = null,
	--AI 2050:
	@aupoc_cod_provincia_istat varchar(3) = null,
	--AI 2050.
	@auvas_data_variazione_stato varchar(10) = null, --rel. 3
	@aupoc_prog_azienda int = null,
	--AI 2050:
	@aupoc_prog_azienda_agr int = null,
	--AI 2050.
	@aupoc_auspc_codice_pk int = null,             --codice_stato_posizione
	--AI 2050:
    @statoPosizioneContributiva int = NULL,
	--AI 2050.
	@aupoc_denom_posiz_contr varchar(405) = null,  --denominazione PC,
    @tipo_ditta varchar(2) = null,                 --rel. 3
    @tipo_ditta2 varchar(2) = null,
    @codice_ateco varchar(20) = null,
    @aupoc_codice_sede_inps varchar(6) = null,      --rel. 3
	--AI 2050:
	@aupoc_aurea_codice_pk int = NULL,
	@aupoc_data_inizio_attivita DateTime = NULL,
    @tipo_posizione int = NULL,
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
-- ======================================================================================
DECLARE @id_tipo_ditta integer = NULL
DECLARE @id_tipo_ditta2 integer = NULL
DECLARE @id_cod_ateco integer = NULL
DECLARE @desc_ateco varchar(200) = NULL
DECLARE @id_cod_ateco91 integer = NULL
DECLARE @id_cod_ateco02 integer = NULL
DECLARE @id_cod_ateco07 integer = NULL

declare @LUNG integer;
declare @ANNO integer;

SET NOCOUNT ON;

--AI 2050: 

--per compatibilità con chiamate preesistenti, alcuni parametri sono presenti più volte, con nomi diversi:
if @aupoc_cod_prov_istat is null begin
	set	@aupoc_cod_prov_istat = @aupoc_cod_provincia_istat 
end
if @aupoc_prog_azienda is null begin
	set	@aupoc_prog_azienda = @aupoc_prog_azienda_agr 
end
if @aupoc_auspc_codice_pk is null begin
	set	@aupoc_auspc_codice_pk = @statoPosizioneContributiva 
end

--tipo posizione va diminuito di 1
DECLARE @aupoc_tipo_posizione integer = NULL

--Peter 2015.05.14:

--if (@tipo_posizione > 0)
--	begin
--		set @aupoc_tipo_posizione = @tipo_posizione - 1
--	end
--else
--	begin
--		set @aupoc_tipo_posizione = NULL
--	end


if (@tipo_posizione > 0)
	begin
		--per Gestione Separata non bisogna alterare aupoc_tipo_posizione
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

--Peter 2015.05.14.

--AI 2050.

--AI 2036:	aggiunti IF - BEGIN - END per gestire il caso che il corrispondente parametro di input non sia valorizzato
IF @codice_ateco IS NOT NULL
BEGIN
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
END

--AI 2036:
IF @aupoc_auspc_codice_pk = 0
BEGIN
SET @aupoc_auspc_codice_pk = NULL
END
--AI 2036.

--AI 2050: se fornita descrizione ATECO dall'esterno, non la ricavo dal codice 
--IF @codice_ateco IS NOT NULL
--BEGIN
--	SET @desc_ateco = 
--	(
--		SELECT TOP 1 auate_cod_sottocategoria_tit
--		FROM dbo.tb_auate_cod_ateco_ct
--		WHERE auate_cod_ateco_complessivo = @codice_ateco AND auate_anno_riferimento = @ANNO
--	)	
--END
	  	  
if (@descrizione_ateco is not null)
begin
	SET @desc_ateco = @descrizione_ateco
end
else if (@codice_ateco IS NOT NULL)
begin
	SET @desc_ateco = 
	(
		SELECT TOP 1 auate_cod_sottocategoria_tit
		FROM dbo.tb_auate_cod_ateco_ct
		WHERE auate_cod_ateco_complessivo = @codice_ateco AND auate_anno_riferimento = @ANNO
	)
end
--AI 2050.


IF @tipo_ditta IS NOT NULL
BEGIN
	SET @id_tipo_ditta = 
	(
		SELECT autdt_codice_pk 
		FROM dbo.tb_autdt_tipoditta_ct 
		WHERE autdt_codice = @tipo_ditta
	)
END

IF @tipo_ditta2 IS NOT NULL
BEGIN
	SET @id_tipo_ditta2 = 
	(
		SELECT autd2_codice_pk
		FROM dbo.tb_autd2_tipoditta2_ct
		WHERE autd2_codice = @tipo_ditta2
	)
END
--AI 2036.	aggiunti IF - BEGIN - END per gestire il caso che il corrispondente parametro di input non sia valorizzato


DECLARE @stato_precedente INT

--Peter 2015.06.15:
DECLARE @aupoc_data_ultimo_stato Date = NULL
--Peter 2015.06.15.

SELECT TOP(1) 
	@stato_precedente = auvas_auspc_codice_pk
	--Peter 2015.06.15:
	,@aupoc_data_ultimo_stato = auvas_data_variazione_stato
	--Peter 2015.06.15.
FROM 
	dbo.tb_auvas_var_stato_pos
WHERE 
	auvas_aupoc_codice_pk = @aupoc_codice_pk
    --2015.09.09 AI 6092:
	  and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
	--2015.09.09 AI 6092.
 
ORDER BY 
	auvas_data_variazione_stato DESC

--Peter 2015.06.15:
IF @stato_precedente <> @aupoc_auspc_codice_pk
BEGIN
	SET @aupoc_data_ultimo_stato = Convert(DateTime,@auvas_data_variazione_stato,103)
END
--Peter 2015.06.15.


IF @aupoc_posizione <> '' AND @aupoc_posizione IS NOT NULL
BEGIN
		UPDATE [dbo].[tb_aupoc_pos_contr]
		SET 
		   --AI 2036: aggiunte condizioni ISNULL per gestire il caso di parametri non valorizzati
			[aupoc_data_modifica]     = getdate()
		   ,[aupoc_descr_utente]      = ISNULL(@aupoc_descr_utente,[aupoc_descr_utente]) 
		   --Peter 2015.04.27:
		   ,[aupoc_ausca_codice_pk]   = ISNULL(@aupoc_ausca_codice_pk,[aupoc_ausca_codice_pk])
		   --Peter 2015.04.27.
		   ,[aupoc_auapp_codice_pk]   = ISNULL(@aupoc_auapp_codice_pk,[aupoc_auapp_codice_pk])
		   ,[aupoc_auspc_codice_pk]   = ISNULL(@aupoc_auspc_codice_pk,[aupoc_auspc_codice_pk])
		   ,[aupoc_denom_posiz_contr] = ISNULL(@aupoc_denom_posiz_contr,[aupoc_denom_posiz_contr])
		   ,[aupoc_posizione]         = @aupoc_posizione
		   ,[aupoc_cod_comune_istat]  = ISNULL(@aupoc_cod_comune_istat,[aupoc_cod_comune_istat])
		   ,[aupoc_cod_prov_istat]    = ISNULL(@aupoc_cod_prov_istat, [aupoc_cod_prov_istat])
		   ,[aupoc_prog_azienda_agr]  = ISNULL(@aupoc_prog_azienda,	[aupoc_prog_azienda_agr])
		   ,[aupoc_autdt_codice_pk]      = ISNULL(@id_tipo_ditta,[aupoc_autdt_codice_pk])          -- rel. 3
		   ,[aupoc_autd2_codice_pk]      = ISNULL(@id_tipo_ditta2,[aupoc_autd2_codice_pk])         -- rel. 4
		   ,[aupoc_auate_1991_codice_pk] = ISNULL(@id_cod_ateco91,[aupoc_auate_1991_codice_pk])         -- rel. 4
		   ,[aupoc_auate_2002_codice_pk] = ISNULL(@id_cod_ateco02,[aupoc_auate_2002_codice_pk])         -- rel. 4
		   ,[aupoc_auate_2007_codice_pk] = ISNULL(@id_cod_ateco07,[aupoc_auate_2007_codice_pk])         -- rel. 4
		   ,[aupoc_ATECO]                = ISNULL(@codice_ateco,[aupoc_ATECO])           -- rel. 4
		   ,[aupoc_DesATECO]             = ISNULL(@desc_ateco,[aupoc_DesATECO])             -- rel. 4
           ,[aupoc_cod_sede_INPS]        = ISNULL(@aupoc_codice_sede_inps,[aupoc_cod_sede_INPS]) -- rel. 3
		   --AI 2050:
		   ,[aupoc_data_inizio_attivita] = ISNULL(@aupoc_data_inizio_attivita, [aupoc_data_inizio_attivita])
		   ,[aupoc_tipo_posizione]       = ISNULL(@aupoc_tipo_posizione, [aupoc_tipo_posizione])
		   	,[aupoc_id_sin]					= ISNULL(@aupoc_id_sin , [aupoc_id_sin])
			,[aupoc_id_confluito]			= ISNULL(@aupoc_id_confluito, [aupoc_id_confluito])
			,[aupoc_cf_confluito]			= ISNULL(@aupoc_cf_confluito , [aupoc_cf_confluito])
			,[aupoc_progressivo_confluito]	= ISNULL(@aupoc_progressivo_confluito , [aupoc_progressivo_confluito])
			,[aupoc_codice_gruppo]			= ISNULL(@aupoc_codice_gruppo , [aupoc_codice_gruppo])
			,[aupoc_codice_categoria]		= ISNULL(@aupoc_codice_categoria , [aupoc_codice_categoria])
			,[aupoc_aucom_codice]			= ISNULL(@aupoc_aucom_codice , [aupoc_aucom_codice])
			,[aupoc_aurea_codice_pk]		= ISNULL(@aupoc_aurea_codice_pk , [aupoc_aurea_codice_pk])
		   --AI 2050.
		    ,[aupoc_descr_stato_GS]			= ISNULL(@aupoc_stato_posizione_GS , [aupoc_descr_stato_GS])
			--Peter 2015.06.15:
			,[aupoc_data_ultimo_stato]      = ISNULL(@aupoc_data_ultimo_stato, aupoc_data_ultimo_stato)
			--Peter 2015.06.15.
		  

		WHERE [aupoc_codice_pk]  = @aupoc_codice_pk
END

--AI 2036:

--ELSE
--BEGIN
--	IF @aupoc_cida <> '' AND @aupoc_cida IS NOT NULL
--	BEGIN
--		UPDATE [dbo].[tb_aupoc_pos_contr]
--		SET 
--			[aupoc_data_modifica]     = getdate()
--		   ,[aupoc_descr_utente]      = @aupoc_descr_utente		 
--		   ,[aupoc_auapp_codice_pk]   = @aupoc_auapp_codice_pk
--		   ,[aupoc_auspc_codice_pk]   = @aupoc_auspc_codice_pk	
--		   ,[aupoc_denom_posiz_contr] = @aupoc_denom_posiz_contr	
--		   ,[aupoc_cida]	          = @aupoc_cida
--		   ,[aupoc_cod_comune_istat]  = @aupoc_cod_comune_istat
--		   ,[aupoc_cod_prov_istat]    = @aupoc_cod_prov_istat		   
--		   ,[aupoc_prog_azienda_agr]  = @aupoc_prog_azienda	
--		   ,[aupoc_autdt_codice_pk]      = @id_tipo_ditta          -- rel. 3
--		   ,[aupoc_autd2_codice_pk]      = @id_tipo_ditta2         -- rel. 4
--		   ,[aupoc_auate_1991_codice_pk] = @id_cod_ateco91         -- rel. 4
--		   ,[aupoc_auate_2002_codice_pk] = @id_cod_ateco02         -- rel. 4
--		   ,[aupoc_auate_2007_codice_pk] = @id_cod_ateco07         -- rel. 4
--		   ,[aupoc_ATECO]                = @codice_ateco           -- rel. 4
--		   ,[aupoc_DesATECO]             = @desc_ateco             -- rel. 4
--           ,[aupoc_cod_sede_INPS]        = @aupoc_codice_sede_inps -- rel. 3

--		WHERE [aupoc_codice_pk]  = @aupoc_codice_pk
--	END
--END	

--AI 2036.

/***
 Author: Maurizio Picone
 UPDATE DELLO -STATO- DELLA POSIZIONE CONTRIBUTIVA 
 NELLA TABELLA DELLE VARIAZIONI, SE E' STATO MODIFICATO RISPETTO AL PRECEDENTE
***/



IF @stato_precedente <> @aupoc_auspc_codice_pk
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
				@aupoc_codice_pk
			   ,@aupoc_auspc_codice_pk -- STATO
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
					WHERE     (tb_aupoc_pos_contr.aupoc_codice_pk = @aupoc_codice_pk)

					--UPDATE    tb_aupoc_pos_contr
					--SET              aupoc_ausin_codice_pk = ausin_codice_pk 
					--FROM         tb_aupoc_pos_contr INNER JOIN
					--  tb_ausin_sedi_inps_ct ON @c_sede = tb_ausin_sedi_inps_ct.ausin_codice_sede 				
				end	 

END
