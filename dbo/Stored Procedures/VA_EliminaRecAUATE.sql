








-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  24/05/2018
-- Description:		Elimina il record selezionato dalla tabella [tb_auate_cod_ateco_ct]
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_EliminaRecAUATE]


@Cod int


AS
BEGIN
	SET NOCOUNT ON;


DELETE FROM [AUC].[dbo].[tb_auate_cod_ateco_ct]

WHERE [auate_codice_pk] = @Cod




END









