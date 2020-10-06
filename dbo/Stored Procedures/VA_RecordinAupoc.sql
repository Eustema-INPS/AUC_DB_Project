



-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/06/2018
-- Description: codici AUATE presenti in AUPOC.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_RecordinAupoc]
@codAuate as int,
@AnRif as int
 
AS
BEGIN

	SET NOCOUNT ON;
	
declare @tb as varchar(500)
declare @str as varchar(500)

SELECT top 1 @tb = CASE (@AnRif) 

WHEN 1991 THEN 'WHERE aupoc_auate_1991_codice_pk = '

WHEN 2002 THEN 'WHERE aupoc_auate_2002_codice_pk = ' 

WHEN 2007 THEN 'WHERE aupoc_auate_2007_codice_pk = '

END

set @str= 'select * from TB_AUPOC_POS_CONTR ' + @tb + CONVERT(varchar, @codAuate)

	exec(@str)

END








