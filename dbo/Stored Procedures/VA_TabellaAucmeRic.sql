


-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  10/09/2018
-- Description:		Elenco dati Tabella TB_AUCME_CODICI_MESS_ERR 
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaAucmeRic]
@codiceTab as int,
@codErr varchar(50)

AS
BEGIN


	SET NOCOUNT ON;
	

	IF RTRIM(@codErr) = ''
	BEGIN
		SET @codErr = '%%'
	END	
	
	
		select * from TB_AUCME_CODICI_MES_ERR 
		where aucme_codice_pk  LIKE '%' + LTRIM(rtrim(@codErr)) + '%' 
	   
	
END




