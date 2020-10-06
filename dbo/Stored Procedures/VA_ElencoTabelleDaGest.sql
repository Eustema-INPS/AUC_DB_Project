


-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  14/03/2018
-- Description:		Elenco dati Tabelle da Gestire. Tabella utilizzata "tb_autbr_tabelle_riferimento"
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_ElencoTabelleDaGest]
AS
BEGIN


	SET NOCOUNT ON;

	
	SELECT 
		Autbr_codice_pk AS DB_Codice,
		Autbr_nome_tabella		AS DB_NomeTab,
		Autbr_flag_visualizzazione 	AS DB_VisualizzaT,
		Autbr_flag_modfica		AS DB_ModificaT,
		Autbr_flag_cancellazione	AS DB_CancellaT,
		Autbr_flag_gestibile 		AS DB_TdaGest,
		Autbr_tipo_tabella	 		AS DB_TipoTab,
		CONVERT(varchar(10), Autbr_data_modifica, 103) AS DB_DataModifica,
		Autbr_descr_utente		AS DB_DescrUtente
	FROM 
		TB_AUTBR_TABELLE_RIFERIMENTO
	WHERE Autbr_flag_gestibile='S'
	ORDER BY 
		Autbr_nome_tabella	asc

	
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100


END



