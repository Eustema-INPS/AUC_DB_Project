




-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/06/2018
-- Description:		Elenco dati Tabella da Gestire.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaAuateRic]
--@codiceTab as int,
@codiceCo varchar(200),
@annoRi as int,
@tipovis varchar(1)

AS
BEGIN


	SET NOCOUNT ON;
	

	IF RTRIM(@codiceCo) = ''
	BEGIN
		SET @codiceCo = '%%'
	END	
	
IF  RTRIM(@tipovis) = 'C'

	IF RTRIM(@annoRi)<> '0' 
		select * from TB_AUATE_COD_ATECO_CT 
		where auate_cod_ateco_complessivo LIKE '%' + LTRIM(rtrim(@codiceCo)) + '%'   
		and Convert(varchar, auate_anno_riferimento) = @annoRi  
	ELSE
		select * from TB_AUATE_COD_ATECO_CT 
		where auate_cod_ateco_complessivo LIKE '%' + LTRIM(rtrim(@codiceCo)) + '%'   

	 IF  RTRIM(@tipovis) = 'S'

	IF RTRIM(@annoRi)<> '0' 
		select * from TB_AUACS_ATECO_STORICO
		where auate_cod_ateco_complessivo LIKE '%' + LTRIM(rtrim(@codiceCo)) + '%'   
		and Convert(varchar, auate_anno_riferimento) = @annoRi  
	ELSE
		select * from TB_AUACS_ATECO_STORICO 
		where auate_cod_ateco_complessivo LIKE '%' + LTRIM(rtrim(@codiceCo)) + '%'   
	
	 

END





