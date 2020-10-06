
-- =============================================
-- Author:		Vannimartini
-- Create date: 05/04/2013
-- Description:	Variazione del Codice Fiscale Azienda
-- =============================================
CREATE PROCEDURE [dbo].[AZ_AggiornaCF] 
	-- Add the parameters for the stored procedure here
	@CF_orig varchar(16),
	@CF_new varchar(16),
	@ausca_codice_pk int,
	@descrUtente varchar(50),
	--@aggiornaAUSCO varchar(2)	-- SI/NO
	@tipoAzione varchar(3)	-- AA / AB / NEW
AS
BEGIN

	SET NOCOUNT ON;
	
	-- ============================================
    -- AUCFI
    -- ============================================
    -- aucfi_codice_fiscale relativo al codice fiscale di destinazione
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
	
	-- modifica del codice fiscale di origine
	UPDATE [dbo].[tb_aucfi_cod_fiscale]
	SET	
		[aucfi_data_fine_validita] = GETDATE(),
		[aucfi_data_modifica] = GETDATE(),
		[aucfi_descr_utente] = @descrUtente
	WHERE
		[aucfi_ausca_codice_pk] = @ausca_codice_pk AND
		[aucfi_codice_fiscale] = @CF_orig
	
	
	-- ============================================
    -- AUSCA
    -- ============================================
    -- aggiornamento del codice fiscale
    UPDATE [dbo].[tb_ausca_sog_contr_az]
	SET	
		[ausca_codice_fiscale] = @CF_new,
		[ausca_data_modifica] = GETDATE(),
		[ausca_descr_utente] = @descrUtente
	WHERE
		[ausca_codice_pk] = @ausca_codice_pk


	-- ============================================
    -- AUSCO
    -- ============================================
    IF @tipoAzione = 'AA'
    BEGIN
    -- aggiornamento del codice fiscale
		UPDATE dbo.tb_ausco_sog_contr_col
		SET	
			ausco_codice_fiscale = @CF_new,
			ausco_data_modifica = GETDATE(),
			ausco_descr_utente = @descrUtente
		WHERE
			ausco_codice_fiscale = @CF_orig
	END
	
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100
END


