-- =============================================
-- Author:		Italo Paioletti
-- Create date: 18/09/2012
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[BA_ControCodiceAusca]
	
AS
BEGIN
	
		SET NOCOUNT ON;

		DECLARE @Ausca_pk int;

		PRINT '-------- Generazione del Controcodice per AUSCA --------';

		DECLARE AUSCA_CTRCOD_cursor CURSOR FOR 
			SELECT ausca_codice_pk
			FROM [dbo].[tb_ausca_sog_contr_az]
			WHERE ausca_contro_codice is null;

		OPEN AUSCA_CTRCOD_cursor

		FETCH NEXT FROM AUSCA_CTRCOD_cursor INTO @Ausca_pk

		WHILE @@FETCH_STATUS = 0
			BEGIN
							
				-- Calcolo del Controcodice
				EXEC [dbo].[AZ_VALIDA_CC] @Ausca_pk, 'AUSCA'
				
				-- Ricostruzione dello Storico
				EXEC [dbo].[AZ_1_Sincronizza] @Ausca_pk, 1,2
				
				FETCH NEXT FROM AUSCA_CTRCOD_cursor INTO @Ausca_pk
			END 

		CLOSE AUSCA_CTRCOD_cursor;
		DEALLOCATE AUSCA_CTRCOD_cursor;
	
END
