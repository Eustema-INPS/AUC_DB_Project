


-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  27/08/2018
-- Description:		Estrazione CF a partire da POSIZIONE
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_EstrazioneCF]

@codop int


AS
BEGIN


	SET NOCOUNT ON;
	
	
SELECT        tb_aupoc_pos_contr.aupoc_posizione as Posizione, tb_ausca_sog_contr_az.ausca_codice_fiscale as Codice_Fiscale
FROM            tb_ausca_sog_contr_az INNER JOIN
                         tb_aupoc_pos_contr ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk RIGHT OUTER JOIN
                         TB_AUDOP_DETTAGLIO_OPERAZIONI ON tb_aupoc_pos_contr.aupoc_posizione = TB_AUDOP_DETTAGLIO_OPERAZIONI.AUDOP_DATO
WHERE        (TB_AUDOP_DETTAGLIO_OPERAZIONI.AUOPE_CODICE_PK = @codop) AND aupoc_aurea_codice_pk = 1 AND AUSCA_CODICE_PK > 2


	
END




