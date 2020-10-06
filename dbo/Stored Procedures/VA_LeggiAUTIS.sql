




-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:   29/03/2019
-- Description:		cerca l'id della carica nella tabella "tb_autis_tipo_sog_col_ct"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_LeggiAUTIS]
@codCar as varchar(3)

AS
BEGIN
	SET NOCOUNT ON;

select top 1 max(autis_codice_pk)  from   tb_autis_tipo_sog_col_ct where autis_codice_carica = @codCar
END



