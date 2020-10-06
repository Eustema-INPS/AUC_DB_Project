-- =============================================
-- Author:		Italo Paioletti
-- Create date: 16/10/2012
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[BA_StoricoVariazioni_AUVAR]
	
AS
BEGIN
	
		SET NOCOUNT ON;

		DECLARE @Ausca_pk int;		

		DECLARE AUSCA_AUVAR_cursor CURSOR FOR 

		SELECT tb_ausca_sog_contr_az.ausca_codice_pk
		FROM tb_aucfi_cod_fiscale INNER JOIN Import_ausca_sog_contr_azienda ON 
			 tb_aucfi_cod_fiscale.aucfi_codice_fiscale = Import_ausca_sog_contr_azienda.St_ausca_codice_fiscale INNER JOIN tb_ausca_sog_contr_az ON 
			 tb_aucfi_cod_fiscale.aucfi_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk
		WHERE (Import_ausca_sog_contr_azienda.St_ausca_FLAG IS NULL) 
		AND (tb_aucfi_cod_fiscale.aucfi_data_inizio_validita <= GETDATE()) 
		AND (tb_aucfi_cod_fiscale.aucfi_data_fine_validita IS NULL);

		OPEN AUSCA_AUVAR_cursor

		FETCH NEXT FROM AUSCA_AUVAR_cursor INTO @Ausca_pk

		WHILE @@FETCH_STATUS = 0
			BEGIN		
				-- Ricostruzione dello Storico
				EXEC [dbo].[AZ_1_Sincronizza] @Ausca_pk, 1,2
				
				FETCH NEXT FROM AUSCA_AUVAR_cursor INTO @Ausca_pk
			END 

		CLOSE AUSCA_AUVAR_cursor;
		DEALLOCATE AUSCA_AUVAR_cursor;
	
END
