
-- =====================================================================================================
-- Author:		Vannimartini
-- Create date: 05/04/2013
-- Description:	Storicizzazione del Codice Fiscale Azienda e/o Tracciamento dell'operazione effettuata
-- =====================================================================================================
CREATE PROCEDURE [dbo].[AZ_StoricoTracciaVariazCF] 
	@CF_orig varchar(16),
	@CF_new varchar(16),
	@ausca_codice_pk int,
	@descrUtente varchar(50),
	@aupoc_codice_pk int,
	@matricolaDM varchar(10) = NULL,
	@tipoAzione varchar(3) = NULL,		-- AA / AB / A1 / A2 / A3 / NEW
	@tipoAzioneVar varchar(3) = NULL	-- AA / AB / NEW
AS
BEGIN

	SET NOCOUNT ON;
	
	-- ============================================
	-- STORICIZZAZIONE
	-- ============================================
	IF @tipoAzione <> 'A1'
	BEGIN
		DECLARE @pkUtente as int
		SELECT @pkUtente = auute_codice_pk FROM dbo.tb_auute_ute_sistema WHERE auute_utenza = @descrUtente
		
		exec AZ_1_sincronizza @ausca_codice_pk, 1, @pkUtente
	END


	-- ============================================
	-- TRACCIAMENTO
	-- ============================================
	DECLARE @descr_lunga as varchar(200)
	DECLARE @descr_breve as varchar(50)
	
	SET @descr_lunga =	CASE 
							WHEN @tipoAzione = 'AA' THEN 'Variazione del Codice Fiscale Soggetto Contribuente da ' + @CF_orig + ' a ' + @CF_new + ' sia su AUSCA che su AUSCO'
							WHEN @tipoAzione = 'AB' THEN 'Variazione del Codice Fiscale Soggetto Contribuente da ' + @CF_orig + ' a ' + @CF_new + ' solo su AUSCA'
							WHEN @tipoAzione = 'A1' THEN 'Spostamento puntuale della singola posizione da ' + @CF_orig + ' a ' + @CF_new
							WHEN @tipoAzione = 'A2' THEN 'Creazione di una nuova Azienda avente CF ' + @CF_new + ', in quanto il CF di origine ' + @CF_orig + ' è presente in Black List'
							WHEN @tipoAzione = 'A3' THEN
								(CASE 
									WHEN @tipoAzioneVar = 'AA' THEN 'Variazione del Codice Fiscale Soggetto Contribuente da ' + @CF_orig + ' a ' + @CF_new + ' sia su AUSCA che su AUSCO. Interazione Utente'
									WHEN @tipoAzioneVar = 'AB' THEN 'Variazione del Codice Fiscale Soggetto Contribuente da ' + @CF_orig + ' a ' + @CF_new + ' solo su AUSCA. Interazione Utente'
									ELSE 'Creazione di una nuova Azienda avente CF ' + @CF_new + ', in quanto il CF di origine ' + @CF_orig + ' NON in Black List. Interazione Utente'
								END)
						END

	SET @descr_breve =	CASE 
							WHEN @tipoAzione = 'AA' THEN @tipoAzione + ' VARIAZIONE CODICE FISCALE SOGGETTO CONTRIBUENTE'
							WHEN @tipoAzione = 'AB' THEN @tipoAzione + ' VARIAZIONE CODICE FISCALE SOGGETTO CONTRIBUENTE'
							WHEN @tipoAzione = 'A1' THEN @tipoAzione + ' SPOSTAMENTO SOGGETTO PER UNA POS. CONTRIBUTIVA'
							WHEN @tipoAzione = 'A2' THEN @tipoAzione + ' CREAZIONE DI UNA NUOVA AZIENDA'
							WHEN @tipoAzione = 'A3' THEN
								(CASE 
									WHEN @tipoAzioneVar = 'NEW' THEN @tipoAzione + ' CREAZIONE DI UNA NUOVA AZIENDA'
									ELSE @tipoAzione + '/' + @tipoAzioneVar + ' VARIAZIONE COD FISCALE SOGGETTO CONTRIBUENTE'
								END)
						END

	
	INSERT INTO dbo.tb_aucfv_cfvar
	(
		aucfv_cf_partenza,
		aucfv_cf_target,
		aucfv_matricola_DM,
		aucfv_tipo_azione,
		aucfv_data_modifica,
		aucfv_descr_utente
	)
	VALUES
	(
		@CF_orig,
		@CF_new,
		@matricolaDM,
		@tipoAzione,
		GETDATE(),
		@descrUtente
	)
    
    INSERT INTO dbo.tb_aulog_log
	(
		aulog_tipo_contesto,
		aulog_nome_attore,
		aulog_data_log,
		aulog_descr_breve,
		aulog_descr_lunga,
		aulog_data_modifica,
		aulog_descr_utente
	)
	VALUES
	(
		'A',
		'Modifica Codice Fiscale',
		GETDATE(),
		@descr_breve,
		@descr_lunga,
		GETDATE(),
		@descrUtente
	)
	
	
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100
END


