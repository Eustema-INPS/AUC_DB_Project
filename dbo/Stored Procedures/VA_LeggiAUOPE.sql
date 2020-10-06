



-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  14/05/2018
-- Description:		inserisce i dati della tabella "tb_auope"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_LeggiAUOPE]


AS
BEGIN
	SET NOCOUNT ON;

select top 1 max(auope_codice_pk)  from TB_AUOPE_OPERAZIONI
END

