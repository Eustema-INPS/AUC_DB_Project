




-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  11/06/2018
-- Description: codici AUATE presenti in AUPOC.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_RecordAusinAupoc]
@codAusin as int

AS
BEGIN

	SET NOCOUNT ON;

--select * from TB_AUPOC_POS_CONTR WHERE aupoc_ausin_codice_pk like'%' + CONVERT(varchar, @codAusin) + '%'
select * from TB_AUPOC_POS_CONTR WHERE aupoc_ausin_codice_pk = CONVERT(varchar, @codAusin)

END








