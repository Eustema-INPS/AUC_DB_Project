





-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/06/2018
-- Description:		Elenco dati Tabella da Gestire.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaAusinRic]
--@codiceTab as int,
@codiceS varchar(4),
@tipovis varchar(1)

AS
BEGIN


	SET NOCOUNT ON;
	

	IF RTRIM(@codiceS) = ''
	BEGIN
		SET @codiceS = '%%'
	END	
	
	IF  RTRIM(@tipovis) = 'C'
		select * from TB_AUSIN_SEDI_INPS_CT 
		where ausin_codice_sede LIKE '%' + LTRIM(rtrim(@codiceS)) + '%' 
	   
IF  RTRIM(@tipovis) = 'S'
		select * from TB_AUSIS_AUSIN_STORICO 
		where ausin_codice_sede LIKE '%' + LTRIM(rtrim(@codiceS)) + '%' 	 

END






