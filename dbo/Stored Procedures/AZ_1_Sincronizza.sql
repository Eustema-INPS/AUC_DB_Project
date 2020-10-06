
-- =================================================================================================
-- Author:		Maurizio Picone
-- Create date: 15/11/2011
-- Description:	
-- LA STORED SINCRONIZZA LA TABELLA DELLE VARIAZIONI ANAGRAFICA AZIENDA (tb_auvar_var_dati)      
-- CON LA TABELLA MADRE (tb_ausca_sog_contr_az)                                                  
-- TENENDO CONTO DEI CAMPI ELENCATI NELLA TABELLA DEI CAMPI SENSIBILI (tb_aueva_elenco_variabili)
-- Modificata da: Raffaele
-- Data modifica: 09/09/2013
-- =================================================================================================

-- =================================================================================================
-- Modificata da:  Quirino
-- Data modifica:  25/05/2013
-- Description:		Aggiunto parametro "@descrUtente" che riceve valorizzato solo se richiamata dalla
--					funzionalità applicativa di "modifica Codice Fiscale"
-- =================================================================================================
-- Modificata da:  Raffaele
-- Data modifica:  16/04/2014
-- Description:		Aggiunta la gestione della variabile AUSCA_STATO
-- =================================================================================================


CREATE PROCEDURE [dbo].[AZ_1_Sincronizza]
	@codiceAzienda int,
	@auvar_auten_codice_pk int,
	@auvar_codice_entita_riferimento int,
	@descrUtente varchar(50) = NULL		-- modifica Quirino 25/05/2013
AS
BEGIN
	SET NOCOUNT ON;	

    -- =============================================================================
    -- Reperimento dell'elenco variabili da monitorare [tb_aueva_elenco_variabili]
    -- =============================================================================
	DECLARE CURSORE_CAMPI Cursor
	FOR
    SELECT [aueva_nome_var] FROM [dbo].[tb_aueva_elenco_variabili] 
       
    -- ===============================================
    -- Ciclo sull'elenco dei campi e creazione query
    -- ===============================================
    OPEN CURSORE_CAMPI 
      
    DECLARE @NomeCampo Varchar(50)    
	DECLARE @VALORE_CAMPO_AUVAR VARCHAR(200)
	DECLARE @VALORE_CAMPO_AUSCA VARCHAR(200)
	DECLARE @TROVATO INT

    FETCH NEXT FROM CURSORE_CAMPI INTO @NomeCampo
	WHILE (@@FETCH_STATUS = 0)		
	BEGIN	       

	set @VALORE_CAMPO_AUVAR = NULL
	set @VALORE_CAMPO_AUSCA = NULL
	set @TROVATO = 0

	SET @VALORE_CAMPO_AUVAR =
		   (SELECT TOP 1 auvar_valore_modificato as VALORE_MODIFICATO
				FROM tb_auvar_var_dati 
				WHERE auvar_aueva_nome_var= @NomeCampo AND auvar_ausca_codice_pk = @CodiceAzienda
				GROUP by auvar_valore_modificato, auvar_data_variazione
				ORDER BY auvar_data_variazione DESC)

	if @VALORE_CAMPO_AUVAR is NULL 
		SET @VALORE_CAMPO_AUVAR = ''

--print @VALORE_CAMPO_AUVAR

if @TROVATO = 0 AND @NomeCampo = 'ausca_denominazione' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_denominazione FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_codice_fiscale' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_codice_fiscale FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_cciaa' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_cciaa FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_codice_toponimo' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_codice_toponimo FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_toponimo' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_toponimo FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_indirizzo' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_indirizzo FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_civico' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_civico FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_localita' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_localita FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_codice_comune' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_codice_comune FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_descr_comune' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_descr_comune FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_frazione' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_frazione FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_sigla_provincia' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_sigla_provincia FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_regione' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_regione FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_sede_legale_italia' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_sede_legale_italia FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_codice_stato_estero' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_codice_stato_estero FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_cap' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_cap FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_telefono1' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_telefono1 FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_telefono2' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_telefono2 FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_telefono3' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_telefono3 FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_fax' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_fax FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_telex' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_telex FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_email' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_email FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_PEC' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_PEC FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_legalmail' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT isnull(nullif([ausca_legalmail], ''), [ausca_pec_iva]) [ausca_legalmail] FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) END  -- G.C. 2020-02-18
if @TROVATO = 0 AND @NomeCampo = 'ausca_n_rea' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_n_rea FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_note' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_note FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_soggetto_certificato' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_soggetto_certificato FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_data_variazione_stato' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_data_variazione_stato FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_desateco' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_desateco FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_ateco' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_ateco FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_stato' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_stato FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_cognome' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_cognome FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end
if @TROVATO = 0 AND @NomeCampo = 'ausca_nome' begin SET @TROVATO = 1 SET @VALORE_CAMPO_AUSCA = CONVERT(VARCHAR(100),(SELECT ausca_nome FROM tb_ausca_sog_contr_az WHERE ausca_codice_pk = @CodiceAzienda)) end

--print isnull(@VALORE_CAMPO_AUSCA,'NULL')+ ' ' + @VALORE_CAMPO_AUVAR

		IF (@VALORE_CAMPO_AUSCA <> CONVERT(VARCHAR(100), @VALORE_CAMPO_AUVAR) ) or
		(@VALORE_CAMPO_AUSCA is null and @VALORE_CAMPO_AUVAR is not null and rtrim(ltrim(@VALORE_CAMPO_AUVAR))<>'')
		BEGIN		
			IF @VALORE_CAMPO_AUVAR = ' ' 
				SET @VALORE_CAMPO_AUVAR = NULL
			IF @descrUtente <> ''
				BEGIN
					INSERT INTO tb_auvar_var_dati
					(
						auvar_ausca_codice_pk,
						auvar_aueva_nome_var,
						auvar_valore_originale,
						auvar_valore_modificato,
						auvar_data_variazione,
						auvar_auten_codice_pk,
						auvar_codice_entita_rif,
						auvar_data_modifica,
						auvar_descr_utente
					)
					VALUES
					(
						@codiceAzienda,
						@nomeCampo,
						CONVERT(VARCHAR(100), @VALORE_CAMPO_AUVAR),
						CONVERT(VARCHAR(100), @VALORE_CAMPO_AUSCA),
						GETDATE(),
						@auvar_auten_codice_pk,
						@auvar_codice_entita_riferimento,
						GETDATE(),
						@descrUtente
					)
				END
			ELSE
				BEGIN
					INSERT INTO [tb_auvar_var_dati]
					   ([auvar_ausca_codice_pk]
					   ,[auvar_aueva_nome_var]
					   ,[auvar_valore_originale]
					   ,[auvar_valore_modificato]
					   ,[auvar_data_variazione]
					   ,[auvar_auten_codice_pk]
					   ,[auvar_codice_entita_rif]
					   ,[auvar_data_modifica])
					VALUES
					   (@codiceAzienda
					   ,@nomeCampo
					   ,CONVERT(VARCHAR(100), @VALORE_CAMPO_AUVAR)
					   ,CONVERT(VARCHAR(100), @VALORE_CAMPO_AUSCA)
					   ,GETDATE()
					   ,@auvar_auten_codice_pk
					   ,@auvar_codice_entita_riferimento
					   ,GETDATE())
				END
		END

		        
		FETCH NEXT FROM CURSORE_CAMPI INTO @NomeCampo
	END
		
	CLOSE CURSORE_CAMPI
	DEALLOCATE CURSORE_CAMPI
END

