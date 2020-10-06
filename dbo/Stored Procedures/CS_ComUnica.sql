
-- ===============================================================================================
-- Author:		Chiovelli
-- Create date: 07/02/2019
-- Description:	Esegue la SP ComUnica per eseguire i LinkedServer verso SVC
-- ===============================================================================================
CREATE PROCEDURE [dbo].[CS_ComUnica] 
	@spCSname varchar(50),	-- nome della SP di ComunicaStatistiche da eseguire / parametro identificativo
	@IdentificativoPratica	varchar(20),
	@ProtocolloRI			varchar(50) = NULL,
	@ID_Key					int,
	@Area					varchar(10) = NULL,
	@DataInizio				int,
	@DataFine				int,
	@CF						varchar(16)
	
AS
BEGIN

	SET NOCOUNT ON;
	
	BEGIN
		DECLARE @esecuzione as varchar(70)
		
		SELECT @esecuzione = ausys_valore
		FROM   dbo.tb_ausys_sistema
		WHERE (ausys_parametro = 'AUC_SVC')
		
		set @esecuzione += @spCSname
		
		IF @spCSname = 'STAT_SP_11-Ricerca-Pratica'
		BEGIN
			EXEC @esecuzione @IdentificativoPratica, @ProtocolloRI
		END
		IF @spCSname = 'STAT_SP_12-Ricerca-Pratiche-PerDate'
		BEGIN
			EXEC @esecuzione @DataInizio, @DataFine, @Area
		END
		IF @spCSname = 'STAT_SP_13-Allegati-Elenco'
		BEGIN
			EXEC @esecuzione @ID_Key
		END
		IF @spCSname = 'CU_SP_LeggiAree'
		BEGIN
			EXEC @esecuzione
		END
		IF @spCSname = 'CS_RicercaCF'
		BEGIN
			EXEC @esecuzione @CF
		END
	END

	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END

