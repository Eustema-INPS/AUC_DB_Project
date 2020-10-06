-- =============================================
-- Author:		Stefano Panuccio
-- Modifica date: 2017.08.16
-- Description:	AI3116 - Gestione Ruoli Soggetto Contribuente
-- =============================================
CREATE PROCEDURE [dbo].[AZ_RUO_SCN_ELENCO] 
	@codiceAzienda int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	SELECT  
		auara_codice_pk as DB_AuaraCodicePK,
		auara_c_tipo as DB_CodTipo,
		auara_tipo as DB_Tipo,
		auara_c_forma as DB_CodForma,
		auara_forma as DB_Forma,
		auara_n_ruolo as DB_Numero,
		auara_ruolo_provincia as DB_Provincia,
		auara_c_ente_rilascio as DB_CodEnteRilascio,
		auara_ente_rilascio as DB_EnteRilascio,
		CONVERT(date, auara_dt_iscrizione, 103) as DB_DataIscrizione,
		CONVERT(date, auara_dt_domanda, 103) as DB_DataDomanda,
		CONVERT(date, auara_dt_delibera, 103) as DB_DataDelibera,
		CONVERT(date, auara_dt_cessazione, 103) as DB_DataCessazione,
		auara_c_causale as DB_CodCausale
		
	FROM
	tb_ausca_sog_contr_az
	INNER JOIN tb_auara_arl_ausca ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_auara_arl_ausca.auara_ausca_codice_pk
	WHERE ausca_codice_pk = @codiceAzienda
	ORDER BY auara_c_tipo,auara_n_ruolo ASC



END
