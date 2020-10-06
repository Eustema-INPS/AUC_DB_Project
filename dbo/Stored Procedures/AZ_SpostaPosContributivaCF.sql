-- =======================================================================================
-- Author:		Vannimartini
-- Create date: 13/05/2013
-- Description:	Spostamento puntuale della singola posizione al nuovo Codice Fiscale (A1)
-- =======================================================================================
CREATE PROCEDURE [dbo].[AZ_SpostaPosContributivaCF] 
	@CF_orig varchar(16),
	@CF_new varchar(16),
	@ausca_codice_pk int,
	@descrUtente varchar(50),
	@aupoc_codice_pk int

AS
BEGIN

	SET NOCOUNT ON;
	
	-- =================================================================================================
    -- AUCFI - Ricerca del nuovo ausca_codice_pk da assegnare all'aupoc_ausca_codice_pk della posizione
    -- =================================================================================================
	SELECT	@ausca_codice_pk = aucfi_ausca_codice_pk
	FROM tb_aucfi_cod_fiscale
	WHERE aucfi_codice_fiscale = @CF_new
	
	
	-- =====================================================================================
    -- AUPOC - Spostamento della posizione contributiva al nuovo CF (aupoc_ausca_codice_pk)
    -- =====================================================================================
    UPDATE tb_aupoc_pos_contr
	SET	
		aupoc_ausca_codice_pk = @ausca_codice_pk,
		aupoc_data_modifica = GETDATE(),
		aupoc_descr_utente = @descrUtente
	WHERE aupoc_codice_pk = @aupoc_codice_pk
    
	
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100
END
