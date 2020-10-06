







-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  20/10/2017
-- Description:		Elimina il record selezionato dalla tabella "tb_aurss_rel_sog_sog"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_EliminaRecAURSS]


@CodAz int

/*@utente varchar (50)*/

AS
BEGIN
	SET NOCOUNT ON;


DELETE FROM [AUC].[dbo].[tb_aurss_rel_sog_sog]

WHERE [aurss_codice_pk] = @CodAz




END






