-- ==================================================================
-- Author:		Vannimartini
-- Create date: 24/05/2013
-- Description:	Valorizzazione del ControCodice per la nuova Azienda
-- ==================================================================
CREATE PROCEDURE [dbo].[AZ_ValorizzaControCodiceCF] 
	@ausca_codice_pk int,
	--@auute_codice_pk int,
	@descrUtente varchar(50)

AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @auute_codice_pk AS int
	
	SELECT	@auute_codice_pk = auute_codice_pk
	FROM	tb_auute_ute_sistema
	WHERE	auute_utenza = @descrUtente
	
	
	exec AZ_valida_CC @ausca_codice_pk, 'AUSCA'
	exec AZ_1_sincronizza @ausca_codice_pk, 1, @auute_codice_pk, @descrUtente

END
