CREATE PROCEDURE [dbo].[SP_Osiride_TR14_4_Output] 
	@CodiceFiscale VARCHAR(16) ,
	@AuuloCodicePk BigInt 	
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[TB_AUT99_OSIRIDE_OUT]	
	SELECT
	 ISNULL([AUT14_R14_TIPO],SPACE(2))                                  
	+ISNULL([AUT14_R14_PROV_CCIAA],SPACE(2))                            
	+ISNULL([AUT14_R14_NUM_IREA],SPACE(9))                     
	+ISNULL([AUT14_R14_PROGRESSIVO_UL],SPACE(4))                        
	+ISNULL([AUT14_R14_TIPO_RUOLO],SPACE(2))                            
	+ISNULL([AUT14_R14_FORMA_RUOLO],SPACE(1))                           
	+ISNULL([AUT14_R14_NUM_RUOLO],SPACE(7))                             
	+ISNULL([AUT14_R14_DATA_DOM_ISCRIZ],SPACE(8))                       
	+ISNULL([AUT14_R14_DATA_DELIBERA_ISCRIZ],SPACE(8))                  
	+ISNULL([AUT14_R14_DATA_INIZ_ATT],SPACE(8))                         
	+ISNULL([AUT14_R14_DATA_DOM_CESS],SPACE(8))                         
	+ISNULL([AUT14_R14_DATA_DELIBERA_CESS],SPACE(8))                    
	+ISNULL([AUT14_R14_DATA_EFF_CESS],SPACE(8))                         
	+ISNULL([AUT14_R14_COD_CAUSALE_CESS],SPACE(2))    
	+ISNULL([AUT14_R14_FILLER],SPACE(1524))                                                                               
	FROM [dbo].[TB_AUT14_OSIRIDE_TR14]	
	WHERE (Isnull(AUT14_R14_NUM_RUOLO,'XXXXXXX') <> 'XXXXXXX' AND ltrim(rtrim(AUT14_R14_NUM_RUOLO)) <> '')
	AND AUT14_R14_CODICE_FISCALE = @CodiceFiscale
	AND   AUT14_R14_AUULO_CODICE_PK = @AuuloCodicePk
END
