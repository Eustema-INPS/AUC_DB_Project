





-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  14/06/2018
-- Description:		Elenco dati Tabella da Gestire.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaAufunRic]
--@codiceTab as int,
@funzione varchar(50),
@tipovis varchar(1)


AS
BEGIN


	SET NOCOUNT ON;
	

	IF RTRIM(@funzione) = ''
	BEGIN
		SET @funzione = '%%'
	END	
	
	IF  RTRIM(@tipovis) = 'C'
		select * from TB_AUFUN_FUNZ_SISTEMA 
		where aufun_funzione LIKE '%' + LTRIM(rtrim(@funzione)) + '%'   
	
	IF  RTRIM(@tipovis) = 'S'
		select * from TB_AUFZS_FUNZIONI_STORICO 
		where aufun_funzione LIKE '%' + LTRIM(rtrim(@funzione)) + '%'   	 

END



