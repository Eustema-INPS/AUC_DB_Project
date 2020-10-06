



-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/06/2018
-- Description: codici AUATE presenti in AUSCA.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_RecordinAupco]
@codAuate as int,
@AnRif as int
 
AS
BEGIN

	SET NOCOUNT ON;
	
declare @tb as varchar(500)
declare @str as varchar(500)

SELECT top 1 @tb = CASE (@AnRif) 

WHEN 1991 THEN 'WHERE aupco_auate_1991_codice_pk = '

WHEN 2002 THEN 'WHERE aupco_auate_2002_codice_pk = ' 

WHEN 2007 THEN 'WHERE aupco_auate_2007_codice_pk = '

END

set @str= 'select * from TB_AUPCO_PERIODO_CONTR ' + @tb + CONVERT(varchar, @codAuate)

	exec(@str)

END








