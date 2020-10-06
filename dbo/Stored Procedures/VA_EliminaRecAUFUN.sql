








-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  24/05/2018
-- Description:		Elimina il record selezionato dalla tabella [tb_aufun_funz_sistema]
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_EliminaRecAUFUN]


@Cod int


AS
BEGIN
	SET NOCOUNT ON;


DELETE FROM [AUC].[dbo].[tb_aufun_funz_sistema]

WHERE [aufun_codice_pk] = @Cod




END









