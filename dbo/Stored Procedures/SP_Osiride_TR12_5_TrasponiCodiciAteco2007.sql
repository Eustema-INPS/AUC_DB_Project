
CREATE PROCEDURE [dbo].[SP_Osiride_TR12_5_TrasponiCodiciAteco2007] @codice_fiscale VARCHAR(16)
AS
BEGIN
		SET NOCOUNT ON;

		Declare @InnerCursor AS CURSOR ;
	
		Declare @CodiceIstat_2007 As Varchar(6);
		Declare @CodiceImportanza_2007 As Varchar(1);
		Declare @DataInizio_2007 As char(8);
		Declare @DataFine_2007 char(8);
		
		Declare	@Riga int;

		SET @InnerCursor = CURSOR FOR

		SELECT  
			ROW_NUMBER() OVER(ORDER BY [auata_ausca_codice_fiscale] ASC) AS Row# ,
			[auata_cod_att_output] as CodiceIstat_2007,
			[auata_cod_importanza] as CodiceImportanza_2007,
			CASE Convert(varchar(8),[auata_dt_inizio],112) WHEN '19000101' THEN Space(8) ELSE Convert(varchar(8),[auata_dt_inizio],112) END As DataInizio_2007 ,
			CASE Convert(varchar(8),[auata_dt_fine],112) WHEN '29991231' THEN Space(8) ELSE Convert(varchar(8),[auata_dt_fine],112) END As DataFine_2007
		FROM tb_auata_ateco_ausca  
		WHERE auata_classificazione_ateco = '2007'
		AND auata_ausca_codice_fiscale = @codice_fiscale 

		OPEN @InnerCursor;
		FETCH NEXT FROM @InnerCursor INTO @Riga,
										  @CodiceIstat_2007, 
										  @CodiceImportanza_2007, 
										  @DataInizio_2007, 
										  @DataFine_2007 ;	
	
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--PRINT 'Riga : ' + convert(varchar(10),@Riga) + '-' + @codice_fiscale;
				IF @Riga = 1 
					Begin
						--Print 'Colonna 1 '
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_01 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_01 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_01  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_01  = @DataFine_2007 							
						WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL  = '0000';
					End

				IF @Riga = 2  
					Begin
						--Print 'Colonna 2 '	
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_02 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_02 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_02  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_02  = @DataFine_2007 								
						WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL  = '0000';
					End					
				IF @Riga = 3  
					Begin
						--Print 'Colonna 3 '
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_03 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_03 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_03  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_03  = @DataFine_2007 														
						WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL  = '0000';						
					End
				IF @Riga = 4  
					Begin
						--Print 'Colonna 4 '
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_04 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_04 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_04  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_04  = @DataFine_2007 
						WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL  = '0000';						
					End
				IF @Riga = 5  
					Begin
						--Print 'Colonna 5 '
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_05 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_05 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_05  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_05  = @DataFine_2007 
						WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL  = '0000';					
					End
				IF @Riga = 6  
					Begin
						--Print 'Colonna 6 '
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_06 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_06 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_06  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_06  = @DataFine_2007  							
						WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL  = '0000';
					
					End
				IF @Riga = 7  
					Begin
						--Print 'Colonna 7 '
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_07 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_07 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_07  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_07  = @DataFine_2007  								
						WHERE AUT12_R12_CODICE_FISCALE = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL = '0000';					
					End
				IF @Riga = 8  
					Begin
						--Print 'Colonna 8 '
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_08 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_08 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_08  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_08  = @DataFine_2007  								
						WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL  = '0000';					
					End
				IF @Riga = 9  
					Begin
						--Print 'Colonna 9 '
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_09 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_09 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_09  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_09  = @DataFine_2007  	
						WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL  = '0000';					
					End
				IF @Riga = 10 
					Begin
						--Print 'Colonna 10'
						UPDATE TB_AUT12_OSIRIDE_TR12
						SET AUT12_R12_COD_ISTAT_2007_10 = @CodiceIstat_2007 , 
							AUT12_R12_COD_IMPORT_ATT_2007_10 = @CodiceImportanza_2007 , 
							AUT12_R12_DATA_INIZIO_2007_10  = @DataInizio_2007 , 
							AUT12_R12_DATA_CESSAZ_2007_10  = @DataFine_2007  	
						WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
						AND   AUT12_R12_PROGRESSIVO_UL  = '0000';					
					End

			FETCH NEXT FROM @InnerCursor INTO @Riga,
										  @CodiceIstat_2007, 
										  @CodiceImportanza_2007, 
										  @DataInizio_2007, 
										  @DataFine_2007 ;	
		END
 
	CLOSE @InnerCursor;
	DEALLOCATE @InnerCursor;
		
END
