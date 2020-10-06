





-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/06/2018
-- Description:		Elenco dati Tabella da Gestire.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaAucauRic]
@codiceTab as int,
@codice varchar(2)

AS
BEGIN


	SET NOCOUNT ON;
	

	IF RTRIM(@codice) = ''
	BEGIN
		SET @codice = '%%'
	END	
	
	
		select * from TB_AUCAU_COD_AUTOR_CT 
		where aucau_codice LIKE '%' + LTRIM(rtrim(@codice)) + '%' 
	   
	 

END






