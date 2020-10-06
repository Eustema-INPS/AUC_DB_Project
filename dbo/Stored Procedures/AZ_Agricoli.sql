

-- ===============================================================================================
-- Author:		Vannimartini
-- Create date: 03/07/2013
-- Description:	Esegue la SP Agricoli in input sul DB DBANUAG per popolare la sceda relativa.
--				Per i ValCida, quando "@spA5name=DescrizioniTD", preleva le DescrizioniTipoDitta
-- ===============================================================================================
CREATE PROCEDURE [dbo].[AZ_Agricoli] 
	@spA5name varchar(50),	-- nome della SP di 5A da eseguire / parametro identificativo
	@aupoc_cida int			-- numero CIDA / parametro Tipo Ditta 1 o 2
AS
BEGIN

	SET NOCOUNT ON;
	
	IF @spA5name = 'DescrizioniTD'
	BEGIN
		IF @aupoc_cida = '1'
		BEGIN
			SELECT 
				autdt_codice_pk
				,autdt_codice
				,autdt_descrizione
				,autdt_descrizione_lunga
			FROM 
				tb_autdt_tipoditta_ct
		END
		ELSE	-- @aupoc_cida = '2'
		BEGIN
			SELECT 
				autd2_codice_pk
				,autd2_codice
				,autd2_descrizione
				,autd2_descrizione_lunga
			FROM 
				tb_autd2_tipoditta2_ct
		END
	END
	ELSE	-- Exec della SP degli Agricoli sul DB DBANAUAG
	BEGIN
		DECLARE @esecuzione as varchar(70)
		
		--set @esecuzione = 'DBANAUAG.dbo.' + @spA5name
		
		SELECT @esecuzione = ausys_valore
		FROM   dbo.tb_ausys_sistema
		WHERE (ausys_parametro = 'AUC_5A')
		
		set @esecuzione += @spA5name
		
		EXEC @esecuzione @aupoc_cida
	END

	
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100

END



