





-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/06/2018
-- Description:		Elenco dati Tabella da Gestire.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaAusysRic]
--@codiceTab as int,
@paramet varchar(50),
@tipovis varchar(1)

AS
BEGIN


	SET NOCOUNT ON;
	

	IF RTRIM(@paramet) = ''
	BEGIN
		SET @paramet = '%%'
	END	
	
	IF  RTRIM(@tipovis) = 'C'
		select * from TB_AUSYS_SISTEMA 
		where ausys_parametro LIKE '%' + LTRIM(rtrim(@paramet)) + '%' 
	   
	IF  RTRIM(@tipovis) = 'S'
		select * from TB_AUSSS_SISTEMA_STORICO 
		where ausys_parametro LIKE '%' + LTRIM(rtrim(@paramet)) + '%'  

END






