


-- =============================================
-- Author:		Paletta
-- =============================================

-- =========================================================================================================
-- Data modifica:  23/09/2019
-- Description:		visualizza "TB_AUSDP_STORICO_DENOM_POSIZIONE" 
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_EstrazioneStoricoDenominazione]
 @codop as int
AS
BEGIN


	SET NOCOUNT ON;
	
	SELECT [ausdp_codice_pk]
	, [ausdp_posizione]
	,[ausdp_aupoc_codice_pk]
	,[ausdp_denom_precedente]
	,[ausdp_denom_attuale]
	,[ausdp_data_modifica_aupoc]
	,[ausdp_data_modifica_dmag]
	,[ausdp_data_modifica]
	,[ausdp_descr_utente] 
	,[ausdp_motivo] 
	FROM [TB_AUSDP_STORICO_DENOM_POSIZIONE] 
WHERE ([ausdp_aupoc_codice_pk] = @codop) ORDER BY [ausdp_data_modifica] DESC

	



END



