-- =============================================
-- Author:		Stefano Panuccio
-- Modifica date: 2017.08.09
-- Description:	AI3116 - Dettaglio fallimento del soggetto collegato
-- =============================================
CREATE PROCEDURE [dbo].[AZ_FAL_SC_DETTAGLIO] 
	@codFallimento int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	SELECT     
		aufal_codice_pk as DB_AufalCodicePK,
		aufal_p_fallimento as DB_ProgressivoFallimento,
		aufal_prov_tribunale as DB_ProvinciaTribunale,
		aufal_tribunale as DB_Tribunale,
		aufal_n_fallimento as DB_NumeroFallimento,
		CONVERT(date, aufal_dt_sentenza, 103) as DB_DataFallimento,
		aufal_n_sentenza as DB_NumeroSentenza,
		CONVERT(date, aufal_dt_sentenza, 103) as DB_DataSentenza,
		aufal_c_organo_giud as DB_CodOrganoGiudiziario,
		aufal_curatore as DB_CuratoreFallimentare,
		aufal_cognome as DB_CognomeCausa,
		aufal_nome as DB_NomeCausa,
		CONVERT(date, aufal_dt_nascita, 103) as DB_DataNascita
	
	FROM
		tb_aufal_fallimento 
		
	WHERE aufal_codice_pk = @codFallimento

END
