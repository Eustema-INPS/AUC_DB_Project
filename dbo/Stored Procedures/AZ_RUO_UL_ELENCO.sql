-- =============================================
-- Author:		Stefano Panuccio
-- Modifica date: 2017.08.16
-- Description:	AI3116 - Gestione Ruoli Unità Locale
-- =============================================
CREATE PROCEDURE [dbo].[AZ_RUO_UL_ELENCO] 
	@codUnita int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	SELECT  
		auaru_codice_pk as DB_AuaraCodicePK,
		auaru_c_tipo as DB_CodTipo,
		auaru_tipo as DB_Tipo,
		auaru_c_forma as DB_CodForma,
		auaru_forma as DB_Forma,
		auaru_n_ruolo as DB_Numero,
		auaru_ruolo_provincia as DB_Provincia,
		auaru_c_ente_rilascio as DB_CodEnteRilascio,
		auaru_ente_rilascio as DB_EnteRilascio,
		CONVERT(date, auaru_dt_iscrizione, 103) as DB_DataIscrizione,
		CONVERT(date, auaru_dt_domanda, 103) as DB_DataDomanda,
		CONVERT(date, auaru_dt_delibera, 103) as DB_DataDelibera,
		CONVERT(date, auaru_dt_cessazione, 103) as DB_DataCessazione,
		auaru_c_causale as DB_CodCausale
		
	FROM
	tb_auulo_unita_locale
	INNER JOIN tb_auaru_arl_auulo ON tb_auaru_arl_auulo.auaru_auulo_codice_pk = tb_auulo_unita_locale.auulo_codice_pk
	WHERE auulo_codice_pk = @codUnita
	ORDER BY auaru_c_tipo,auaru_n_ruolo ASC

	

END
