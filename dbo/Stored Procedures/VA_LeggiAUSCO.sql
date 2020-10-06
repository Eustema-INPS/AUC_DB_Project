




-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:   29/03/2019
-- Description:		cerca l'id dell'ultimo record inserito nella tabella "tb_ausco_sog_contr_col"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_LeggiAUSCO]
@cf as varchar(16)

AS
BEGIN
	SET NOCOUNT ON;

select top 1 max(ausco_codice_pk)  from tb_ausco_sog_contr_col where ausco_codice_fiscale = @cf
END



