






-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  19/04/2018
-- Description:		Elimina il record selezionato dalla tabella [tb_ausys_sistema]
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_EliminaRecAUSYS]


@Cod int


AS
BEGIN
	SET NOCOUNT ON;


DELETE FROM [AUC].[dbo].[tb_ausys_sistema]

WHERE [ausys_codice_pk] = @Cod




END







