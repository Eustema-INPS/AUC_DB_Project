-- =============================================
-- Author:		Stefano Panuccio
-- Modifica date: 2017.08.16
-- Description:	AI3116 - Gestione Ateco Unità Locale
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ATC_UL_ELENCO] 
	@codUnita int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	SELECT
		auatu_codice_pk as DB_AuatuCodicePK,
		auatu_classificazione_ateco as DB_Anno,
		auatu_cod_att_output as DB_Ateco,
		auatu_descr_attivita as DB_Attivita,
		auatu_cod_importanza as DB_CodImportanza,
		auatu_importanza as DB_Importanza,
		CONVERT(date, auatu_dt_inizio, 103) as DB_DataInizio,
		CONVERT(date, auatu_dt_fine, 103) as DB_DataFine,
		CONVERT(date, auatu_dt_riferimento, 103) as DB_DataRiferimento
		
	FROM
	tb_auulo_unita_locale
	INNER JOIN tb_auatu_ateco_auulo ON tb_auatu_ateco_auulo.auatu_auulo_codice_pk = tb_auulo_unita_locale.auulo_codice_pk
	WHERE auulo_codice_pk = @codUnita
	ORDER BY auatu_classificazione_ateco DESC,auatu_cod_importanza ASC

	

END
