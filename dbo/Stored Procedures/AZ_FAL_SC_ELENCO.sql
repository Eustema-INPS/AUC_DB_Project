-- =============================================
-- Author:		Stefano Panuccio
-- Modifica date: 2017.08.09
-- Description:	AI3116 - Fallimenti del soggetto collegato
-- =============================================
CREATE PROCEDURE [dbo].[AZ_FAL_SC_ELENCO] 
	@codSoggetto int,
	@codAzienda int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	SELECT     
		aufal_codice_pk as DB_AufalCodicePK,
		aufal_p_fallimento as DB_ProgressivoFallimento,
		CONVERT(date, aufal_dt_sentenza, 103) as DB_DataFallimento,
		aufal_prov_tribunale as DB_ProvinciaTribunale,
		aufal_tribunale as DB_Tribunale
	FROM
		tb_ausco_sog_contr_col 
		INNER JOIN tb_aufal_fallimento ON tb_aufal_fallimento.aufal_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk
		
	WHERE ausco_codice_pk = @codSoggetto 

	--AND ( @codAzienda IS NULL OR tb_ausca_sog_contr_az.ausca_codice_pk = @codAzienda )

END
