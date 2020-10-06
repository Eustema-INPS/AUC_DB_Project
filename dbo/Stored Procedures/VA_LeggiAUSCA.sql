




-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:   29/03/2019
-- Description:		cerca l'id dell'ultimo record inserito nella tabella "tb_ausca_sog_contr_az"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_LeggiAUSCA]
@cf as varchar(16)

AS
BEGIN
	SET NOCOUNT ON;

select top 1 max(ausca_codice_pk)  from tb_ausca_sog_contr_az where ausca_codice_fiscale = @cf
END



