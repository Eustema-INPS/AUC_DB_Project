﻿CREATE PROCEDURE [dbo].[SP_Osiride_TR09_2_TrasponiCariche] 
	@Azienda  VARCHAR(16),
	@Soggetto VARCHAR(16)
AS
BEGIN
		SET NOCOUNT ON;

		Declare @InnerCursor AS CURSOR ;
	
		Declare @ProgCarica As Varchar(8);
		Declare @CodCarica As Varchar(4);
		Declare @DataInizio As Varchar(8);
		Declare @DataFine As Varchar(8);
		Declare @CodDurata As Varchar(2);
		Declare @AnniEseCar As Varchar(2);
		Declare @DataPreseCar As Varchar(2);
		
		Declare	@Riga int;

		SET @InnerCursor = CURSOR FOR
		SELECT ROW_NUMBER() OVER(ORDER BY [AUT09_R9_CODICE_FISCALE],[AUT09_R9_COD_FISC] ASC) AS Row#
			   ,ltrim(rtrim([AUT09_R9_CODICE_FISCALE])) As CFAzienda
			   ,ltrim(rtrim([AUT09_R9_COD_FISC])) As CFSoggetto
			   ,CASE Isnull(AUT09_R9_PROG_CARICA_01,'0000') WHEN '0000' THEN '0000' ELSE right('0000' + ltrim(rtrim(AUT09_R9_PROG_CARICA_01)),4) END As AUT09_R9_PROG_CARICA_01
			   ,[AUT09_R9_COD_CARICA_01]
			   ,[AUT09_R9_DATA_INIZ_CAR_01]
			   ,[AUT09_R9_DATA_FINE_CAR_01]
			   ,[AUT09_R9_COD_DURA_CAR_01]
			   ,[AUT09_R9_ANNI_ESE_CAR_01]
			   ,[AUT09_R9_DATA_PRES_CAR_01]
		FROM TB_AUT99_OSIRIDE_LISTA_CARICHE
		WHERE 1 = 1
		AND [AUT09_R9_CODICE_FISCALE] = @Azienda 
		AND [AUT09_R9_COD_FISC] = @Soggetto ;

		OPEN @InnerCursor;
		FETCH NEXT FROM @InnerCursor INTO @Riga, @Azienda, @Soggetto, @ProgCarica, @CodCarica, 
										  @DataInizio, @DataFine, @CodDurata, @AnniEseCar, @DataPreseCar ;
	
		WHILE @@FETCH_STATUS = 0
		BEGIN
			--PRINT 'Riga : ' + convert(varchar(10),@Riga) + '-' + @Azienda + '-' + @Soggetto + '-' + @ProgCarica  + '-' +  @CodCarica;
			IF @Riga = 1 
				Begin
				--Print 'Colonna 1 '
					UPDATE TB_AUT09_OSIRIDE_TR09
					SET AUT09_R9_PROG_CARICA_01   = CASE Isnull(@ProgCarica,'0000') WHEN '0000' THEN '0000' ELSE right('0000' + ltrim(rtrim(@ProgCarica)),4) END ,						
						AUT09_R9_COD_CARICA_01    = @CodCarica , 
						AUT09_R9_DATA_INIZ_CAR_01 = @DataInizio , 
						AUT09_R9_DATA_FINE_CAR_01 = @DataFine , 
						AUT09_R9_COD_DURA_CAR_01  = @CodDurata , 
						AUT09_R9_ANNI_ESE_CAR_01  = CASE isnull(@AnniEseCar,'00') WHEN '00' THEN '00' ELSE right('00'+ @AnniEseCar,2) END , 
						AUT09_R9_DATA_PRES_CAR_01 = @DataPreseCar
					WHERE AUT09_R9_CODICE_FISCALE = @Azienda 
					AND AUT09_R9_COD_FISC = @Soggetto
				End

			IF @Riga = 2  
				Begin
					--Print 'Colonna 2 '
					UPDATE TB_AUT09_OSIRIDE_TR09
					SET AUT09_R9_PROG_CARICA_02   = CASE Isnull(@ProgCarica,'0000') WHEN '0000' THEN '0000' ELSE right('0000' + ltrim(rtrim(@ProgCarica)),4) END ,
						AUT09_R9_COD_CARICA_02    = @CodCarica , 
						AUT09_R9_DATA_INIZ_CAR_02 = @DataInizio , 
						AUT09_R9_DATA_FINE_CAR_02 = @DataFine , 
						AUT09_R9_COD_DURA_CAR_02  = @CodDurata , 
						AUT09_R9_ANNI_ESE_CAR_02  = CASE isnull(@AnniEseCar,'00') WHEN '00' THEN '00' ELSE right('00'+@AnniEseCar,2) END , 
						AUT09_R9_DATA_PRES_CAR_02 = @DataPreseCar
					WHERE AUT09_R9_CODICE_FISCALE = @Azienda 
					AND AUT09_R9_COD_FISC = @Soggetto
				End
			IF @Riga = 3  
				Begin
					--Print 'Colonna 3 '
					UPDATE TB_AUT09_OSIRIDE_TR09
					SET AUT09_R9_PROG_CARICA_03   = CASE Isnull(@ProgCarica,'0000') WHEN '0000' THEN '0000' ELSE right('0000' + ltrim(rtrim(@ProgCarica)),4) END , 
						AUT09_R9_COD_CARICA_03    = @CodCarica , 
						AUT09_R9_DATA_INIZ_CAR_03 = @DataInizio , 
						AUT09_R9_DATA_FINE_CAR_03 = @DataFine , 
						AUT09_R9_COD_DURA_CAR_03  = @CodDurata , 
						AUT09_R9_ANNI_ESE_CAR_03  = CASE isnull(@AnniEseCar,'00') WHEN '00' THEN '00' ELSE right('00'+@AnniEseCar,2) END , 
						AUT09_R9_DATA_PRES_CAR_03 = @DataPreseCar
					WHERE AUT09_R9_CODICE_FISCALE = @Azienda 
					AND AUT09_R9_COD_FISC = @Soggetto
				End
			IF @Riga = 4  
				Begin
					--Print 'Colonna 4 '
					UPDATE TB_AUT09_OSIRIDE_TR09
					SET AUT09_R9_PROG_CARICA_04   = CASE Isnull(@ProgCarica,'0000') WHEN '0000' THEN '0000' ELSE right('0000' + ltrim(rtrim(@ProgCarica)),4) END ,
						AUT09_R9_COD_CARICA_04    = @CodCarica , 
						AUT09_R9_DATA_INIZ_CAR_04 = @DataInizio , 
						AUT09_R9_DATA_FINE_CAR_04 = @DataFine , 
						AUT09_R9_COD_DURA_CAR_04  = @CodDurata , 
						AUT09_R9_ANNI_ESE_CAR_04  = CASE isnull(@AnniEseCar,'00') WHEN '00' THEN '00' ELSE right('00'+@AnniEseCar,2) END , 
						AUT09_R9_DATA_PRES_CAR_04 = @DataPreseCar
					WHERE AUT09_R9_CODICE_FISCALE = @Azienda 
					AND AUT09_R9_COD_FISC = @Soggetto
				End
			IF @Riga = 5  
				Begin
					--Print 'Colonna 5 '
					UPDATE TB_AUT09_OSIRIDE_TR09
					SET AUT09_R9_PROG_CARICA_05   = CASE Isnull(@ProgCarica,'0000') WHEN '0000' THEN '0000' ELSE right('0000' + ltrim(rtrim(@ProgCarica)),4) END ,
						AUT09_R9_COD_CARICA_05    = @CodCarica , 
						AUT09_R9_DATA_INIZ_CAR_05 = @DataInizio , 
						AUT09_R9_DATA_FINE_CAR_05 = @DataFine , 
						AUT09_R9_COD_DURA_CAR_05  = @CodDurata , 
						AUT09_R9_ANNI_ESE_CAR_05  = CASE isnull(@AnniEseCar,'00') WHEN '00' THEN '00' ELSE right('00'+@AnniEseCar,2) END , 
						AUT09_R9_DATA_PRES_CAR_05 = @DataPreseCar
					WHERE AUT09_R9_CODICE_FISCALE = @Azienda 
					AND AUT09_R9_COD_FISC = @Soggetto
				End
			FETCH NEXT FROM @InnerCursor INTO @Riga, @Azienda, @Soggetto, @ProgCarica, @CodCarica, 
										      @DataInizio, @DataFine, @CodDurata, @AnniEseCar, @DataPreseCar ;
	
		END
 
	CLOSE @InnerCursor;
	DEALLOCATE @InnerCursor;
		
END
