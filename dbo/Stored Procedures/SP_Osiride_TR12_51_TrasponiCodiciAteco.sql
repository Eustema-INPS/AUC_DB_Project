
CREATE PROCEDURE [dbo].[SP_Osiride_TR12_51_TrasponiCodiciAteco] @codice_fiscale VARCHAR(16)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @InnerCursor AS CURSOR ;
	DECLARE @AULOCursor AS CURSOR ;
	
	DECLARE @AuatuAuuloCodicePk As int;
	
	DECLARE @CodiceIstat_2002 As Varchar(6);
	DECLARE @CodiceImportanza_2002 As Varchar(1);
	DECLARE @DataInizio_2002 As char(8);
	DECLARE @DataFine_2002 As char(8);
	DECLARE @FKAulo As int;

	DECLARE	@Riga int;
	
	SET @AULOCursor = CURSOR FOR

	SELECT [auatu_auulo_codice_pk]
    FROM [dbo].[tb_auatu_ateco_auulo]
	WHERE auatu_ausca_codice_fiscale = @codice_fiscale 
	AND auatu_classificazione_ateco = '2002'
	GROUP BY auatu_auulo_codice_pk;

	OPEN @AULOCursor;
	FETCH NEXT FROM @AULOCursor INTO @AuatuAuuloCodicePk;
	
	-- Ciclare per auatu_auulo_codice_pk 
	-- Va fatto per tutti e 4 gli atechi trasposti
	-- Controllare anche i ruoli 13 e 14
	WHILE @@FETCH_STATUS = 0		
	BEGIN	
		SET @InnerCursor = CURSOR FOR

		SELECT ROW_NUMBER() OVER(ORDER BY [auatu_ausca_codice_fiscale] ASC) AS Row# ,
			auatu_cod_att_output as CodiceIstat_2002,
			auatu_cod_importanza as CodiceImportanza_2002,			
			CASE Convert(varchar(8),auatu_dt_inizio,112) WHEN '19000101' THEN Space(8) ELSE Convert(varchar(8),auatu_dt_inizio,112) END As DataInizio_2002 ,
			CASE Convert(varchar(8),auatu_dt_fine,112) WHEN '29991231' THEN Space(8) ELSE Convert(varchar(8),auatu_dt_fine,112) END As DataFine_2002 ,
			auatu_auulo_codice_pk
		FROM tb_auatu_ateco_auulo INNER JOIN TB_AUT12_OSIRIDE_TR12 ON 
			 auatu_ausca_codice_fiscale = @codice_fiscale 
		AND	auatu_classificazione_ateco = '2002'
		AND	aut12_r12_auulo_codice_pk = @AuatuAuuloCodicePk
	    AND auatu_auulo_codice_pk = @AuatuAuuloCodicePk;

		OPEN @InnerCursor;
		FETCH NEXT FROM @InnerCursor 
		INTO @Riga,
			 @CodiceIstat_2002, 
			 @CodiceImportanza_2002, 
			 @DataInizio_2002, 
			 @DataFine_2002 ,
			 @FKAulo;		

		WHILE @@FETCH_STATUS = 0
		BEGIN
			--PRINT 'Riga : ' + convert(varchar(10),@Riga) + '-' + @codice_fiscale;
			IF @Riga = 1 
				Begin
					--Print 'Colonna 1 '
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_01 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_01 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_01  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_01  = @DataFine_2002 							
					WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
					AND   aut12_r12_auulo_codice_pk = @FKAulo;
				End
			IF @Riga = 2  
				Begin
					--Print 'Colonna 2 '	
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_02 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_02 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_02  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_02  = @DataFine_2002 								
					WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
					AND   aut12_r12_auulo_codice_pk = @FKAulo;
				End					
			IF @Riga = 3  
				Begin
					--Print 'Colonna 3 '
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_03 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_03 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_03  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_03  = @DataFine_2002 							
					WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
					AND   aut12_r12_auulo_codice_pk = @FKAulo;						
				End
			IF @Riga = 4  
				Begin
					--Print 'Colonna 4 '
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_04 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_04 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_04  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_04  = @DataFine_2002 	 
					WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
					AND aut12_r12_auulo_codice_pk = @FKAulo;						
				End
			IF @Riga = 5  
				Begin
					--Print 'Colonna 5 '
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_05 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_05 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_05  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_05  = @DataFine_2002
					WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
					AND aut12_r12_auulo_codice_pk = @FKAulo;					
				End
			IF @Riga = 6  
				Begin
					--Print 'Colonna 6 '
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_06 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_06 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_06  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_06  = @DataFine_2002  							
					WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
					AND aut12_r12_auulo_codice_pk = @FKAulo;					
				End
			IF @Riga = 7  
				Begin
					--Print 'Colonna 7 '
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_07 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_07 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_07  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_07  = @DataFine_2002 								
					WHERE AUT12_R12_CODICE_FISCALE = @codice_fiscale 
					AND aut12_r12_auulo_codice_pk = @FKAulo;					
				End
			IF @Riga = 8  
				Begin
					--Print 'Colonna 8 '
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_08 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_08 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_08  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_08  = @DataFine_2002  								
					WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
					AND aut12_r12_auulo_codice_pk = @FKAulo;				
				End
			IF @Riga = 9  
				Begin
					--Print 'Colonna 9 '
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_09 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_09 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_09  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_09  = @DataFine_2002  	
					WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
					AND aut12_r12_auulo_codice_pk = @FKAulo;					
				End
			IF @Riga = 10 
				Begin
					--Print 'Colonna 10'
					UPDATE TB_AUT12_OSIRIDE_TR12
					SET AUT12_R12_COD_ISTAT_2002_10 = @CodiceIstat_2002 , 
						AUT12_R12_COD_IMPORT_ATT_10 = @CodiceImportanza_2002 , 
						AUT12_R12_DATA_INIZ_ATT_10  = @DataInizio_2002 , 
						AUT12_R12_DATA_CESS_ATT_10  = @DataFine_2002 
					WHERE AUT12_R12_CODICE_FISCALE  = @codice_fiscale 
					AND aut12_r12_auulo_codice_pk = @FKAulo;					
				End

			FETCH NEXT FROM @InnerCursor 
				INTO @Riga,
					@CodiceIstat_2002, 
					@CodiceImportanza_2002, 
					@DataInizio_2002, 
					@DataFine_2002 ,
					@FKAulo;	
		END

		CLOSE @InnerCursor;
		DEALLOCATE @InnerCursor;

		--PRINT 'Codice Fiscale [ ' + @codice_fiscale + ' ] Unita Locale [' + convert(varchar(20),@AuatuAuuloCodicePk) + ' ] '
		FETCH NEXT FROM @AULOCursor INTO @AuatuAuuloCodicePk;
	END 
	
	CLOSE @AULOCursor;
	DEALLOCATE @AULOCursor;

END
