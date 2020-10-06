





-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/06/2018
-- Description:		Elenco dati Tabella da Gestire.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaAulovRic]
@cf varchar(16),
@tiporc varchar(1),
@data varchar(10),
@utente varchar(50)

AS
BEGIN


	SET NOCOUNT ON;
	

	IF RTRIM(@tiporc) = '0'
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
	END	


	IF RTRIM(@data) = '' 
		select * from TB_AULOV_ACCESSO_VISURE
		where aulov_codfisc_soggetto LIKE '%' + LTRIM(rtrim(@cf)) + '%'   
		and aulov_tipo_ricerca LIKE '%' + LTRIM(rtrim(@tiporc)) + '%'   		
		and aulov_descr_utente LIKE '%' + LTRIM(rtrim(@utente)) + '%' 
 
	IF RTRIM(@data) <> '' 
		select * from TB_AULOV_ACCESSO_VISURE
		where aulov_codfisc_soggetto LIKE '%' + LTRIM(rtrim(@cf)) + '%'   
		and aulov_tipo_ricerca LIKE '%' + LTRIM(rtrim(@tiporc)) + '%'   
		and DATEADD(dd, DATEDIFF(dd, 0, aulov_data_modifica), 0) = Convert(DateTime,@data + ' 00:00',103)
		and aulov_descr_utente LIKE '%' + LTRIM(rtrim(@utente)) + '%'  



END






