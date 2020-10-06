




-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  10/09/2018
-- Description:		inserisce i dati della tabella "tb_aucme_codici_mes_err"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_LeggiAUCME]


AS
BEGIN
	SET NOCOUNT ON;

select top 1 max(aucme_codice_pk)  from TB_AUCME_CODICI_MES_ERR
END


