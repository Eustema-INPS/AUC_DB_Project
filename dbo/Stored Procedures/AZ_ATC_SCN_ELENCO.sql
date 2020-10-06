-- =============================================
-- Author:		Stefano Panuccio
-- Modifica date: 2017.08.16
-- Description:	AI3116 - Gestione Ateco Soggetto Contribuente
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ATC_SCN_ELENCO] 
	@codiceAzienda int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	SELECT  
		auata_codice_pk as DB_AuataCodicePK,
		auata_classificazione_ateco as DB_Anno,
		auata_cod_att_output as DB_Ateco,
		auata_descr_attivita as DB_Attivita,
		auata_cod_importanza as DB_CodImportanza,
		auata_importanza as DB_Importanza,
		CONVERT(date, auata_dt_inizio, 103) as DB_DataInizio,
		CONVERT(date, auata_dt_fine, 103) as DB_DataFine,
		CONVERT(date, auata_dt_riferimento, 103) as DB_DataRiferimento
		
	FROM
	tb_ausca_sog_contr_az
	INNER JOIN tb_auata_ateco_ausca ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_auata_ateco_ausca.auata_ausca_codice_pk
	WHERE ausca_codice_pk = @codiceAzienda
	ORDER BY auata_classificazione_ateco DESC,auata_cod_importanza ASC

	--AND ( @codAzienda IS NULL OR tb_ausca_sog_contr_az.ausca_codice_pk = @codAzienda )

END
