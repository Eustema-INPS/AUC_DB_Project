-- =============================================
-- Author:		Emanuela
-- Create date: 2019.01.08
-- Description:	Stored per caricare i dettagli dei CF Collegati
-- =============================================

CREATE PROCEDURE [dbo].[VA_DettaglioCFColl] 
	@cod int
AS
BEGIN

	SET NOCOUNT ON;
	
	SELECT        AUIAC_CODICE_PK, AUIAC_CHIAVE_AUC, AUIAC_CODICE_FISCALE_COLLEGATO, AUIAC_CHIAVE_ARCA_COLLEGATO, AUIAC_DATA_INSERIMENTO
FROM            TB_AUIAC_INTERFACCIA_ARCA_COLLEGATO
WHERE      AUIAC_CODICE_PK  = CONVERT(bigint, @cod)
END