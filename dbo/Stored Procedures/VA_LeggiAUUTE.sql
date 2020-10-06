





-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:   29/03/2019
-- Description:		cerca l'id del record corrispondente alla descrizione utente nella tabella " tb_auute_ute_sistema"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_LeggiAUUTE]
@descrU as varchar(50)

AS
BEGIN
	SET NOCOUNT ON;

select top 1 max(auute_codice_pk)  from  tb_auute_ute_sistema where auute_utenza = @descrU
END




