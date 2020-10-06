







-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/07/2018
-- Description:		Dettaglio dati Tabella   TB_AUSSI_STORICO_INDIRIZZO
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_DettaglioStoricoIndirizzi]

@cod  varchar(20) --as int


AS
BEGIN


	SET NOCOUNT ON;
	

	/*IF RTRIM(@tiporc) = '0'
	BEGIN
		SET @tiporc = '%%'
	END	


	IF RTRIM(@utente) = ''
	BEGIN
		SET @utente = '%%'
	END	


	IF RTRIM(@cf) = ''
	BEGIN
		SET @cf = '%%'
	END	*/


	
		select * from    TB_AUSSI_STORICO_INDIRIZZO
		where AUSSI_CODICE_PK=@cod



END








