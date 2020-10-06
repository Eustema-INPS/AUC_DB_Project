
CREATE PROCEDURE [dbo].[SP_Osiride_TR12_52_ProgressivoUL] @codice_fiscale VARCHAR(16)
AS
BEGIN
		SET NOCOUNT ON;

		Declare @InnerCursor AS CURSOR ;
		Declare	@Riga int;
		DECLARE @KeyAulo As Bigint;

		SET @InnerCursor = CURSOR FOR		

		SELECT ROW_NUMBER() OVER(ORDER BY [aut12_r12_codice_fiscale] ASC) AS Row# ,[aut12_r12_auulo_codice_pk] 
		FROM [AUC].[dbo].[TB_AUT12_BIS]
		WHERE [aut12_r12_codice_fiscale] = @codice_fiscale 

		OPEN @InnerCursor;
		FETCH NEXT FROM @InnerCursor INTO @Riga, @KeyAulo ;	
	
		WHILE @@FETCH_STATUS = 0
		BEGIN
			Begin
				UPDATE [dbo].[TB_AUT12_BIS]
				SET [AUT12_R12_PROGRESSIVO_NEW_UL] = @Riga 													
				WHERE [aut12_r12_codice_fiscale]   = @codice_fiscale 
				AND   [aut12_r12_auulo_codice_pk]  = @KeyAulo;
			End				
			FETCH NEXT FROM @InnerCursor INTO @Riga, @KeyAulo ;	
		END
 
 		UPDATE TB_AUT12_OSIRIDE_TR12
		SET AUT12_R12_PROGRESSIVO_NEW_UL = right(  '0000' + ltrim(rtrim(TB_AUT12_BIS.AUT12_R12_PROGRESSIVO_NEW_UL)) ,4)
		FROM TB_AUT12_BIS INNER JOIN TB_AUT12_OSIRIDE_TR12 ON 
			 TB_AUT12_BIS.aut12_r12_codice_fiscale = TB_AUT12_OSIRIDE_TR12.aut12_r12_codice_fiscale AND 
			 TB_AUT12_BIS.aut12_r12_auulo_codice_pk = TB_AUT12_OSIRIDE_TR12.aut12_r12_auulo_codice_pk
		WHERE TB_AUT12_OSIRIDE_TR12.aut12_r12_codice_fiscale   = @codice_fiscale 
		--AND   TB_AUT12_OSIRIDE_TR12.aut12_r12_auulo_codice_pk  = @KeyAulo;
				
	CLOSE @InnerCursor;
	DEALLOCATE @InnerCursor;


END
