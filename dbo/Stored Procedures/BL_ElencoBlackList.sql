
-- =============================================
-- Author:		Vincenzo Pinto
-- =============================================

-- ==================================================================
-- Modificata da:  Quirino
-- Data modifica:  20/06/2013
-- Description:		Aggiunta delle eventuali informazioni da AUSCA
-- ==================================================================
CREATE PROCEDURE [dbo].[BL_ElencoBlackList]
AS
BEGIN

-- modifica Quirino 20/06/2013  INIZIO
--SELECT [CF] as DB_CodFis
--       FROM [AUC].[dbo].[Import_BlackList_POC]
--       order by CF asc
	SELECT 
		CF					AS DB_CodFis, 
		ausca_denominazione	AS DB_DenominazioneAUSCA
	FROM 
		Import_BlackList_POC LEFT OUTER JOIN
		tb_ausca_sog_contr_az ON 
			Import_BlackList_POC.CF = tb_ausca_sog_contr_az.ausca_codice_fiscale
	ORDER BY 
		CF, ausca_denominazione


	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100
-- modifica Quirino 20/06/2013  FINE

END


