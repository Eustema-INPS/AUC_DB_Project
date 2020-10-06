

CREATE PROCEDURE [dbo].[UP_ANTIFRODE_CAMERACOMMERCIO] 
	@codicefiscale varchar(16)
AS
BEGIN
	SET NOCOUNT ON;
   
	SELECT [AUSVI_AUSCA_CODICE_PK]
      
	FROM  [dbo].[TB_AUSVI_VISURA_SOGGETTO]
  
	WHERE	ausvi_codice_fiscale = @codicefiscale
END
