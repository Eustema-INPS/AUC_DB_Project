







-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  24/05/2018
-- Description:		Elimina il record selezionato dalla tabella [tb_ausin_sedi_inps_ct]
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_EliminaRecAUSIN]


@Cod int


AS
BEGIN
	SET NOCOUNT ON;


DELETE FROM [AUC].[dbo].[tb_ausin_sedi_inps_ct]

WHERE [ausin_codice_pk] = @Cod




END








