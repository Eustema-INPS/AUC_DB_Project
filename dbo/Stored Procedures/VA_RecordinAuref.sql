



-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/06/2018
-- Description: codici AUFUN presenti in AUREF.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_RecordinAuref]
@codAufun as int
 
AS
BEGIN

	SET NOCOUNT ON;

select * from TB_AUREF_REL_ENTITA_FUNZ WHERE auref_aufun_codice_pk like'%' + CONVERT(varchar, @codAufun) + '%'


END








