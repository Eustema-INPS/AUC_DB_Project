






-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  27/08/2018
-- Description:		Estrazione posizione a partire da cf
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_EstrazionePosizione]

@codop int


AS
BEGIN


	SET NOCOUNT ON;
	
	
SELECT        TB_AUDOP_DETTAGLIO_OPERAZIONI.AUDOP_DATO as Codice_Fiscale, tb_aupoc_pos_contr.aupoc_posizione as Posizione, aurea_descrizione as Provenienza

FROM            tb_aupoc_pos_contr INNER JOIN
                         tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk RIGHT OUTER JOIN
                         TB_AUDOP_DETTAGLIO_OPERAZIONI ON tb_ausca_sog_contr_az.ausca_codice_fiscale = TB_AUDOP_DETTAGLIO_OPERAZIONI.AUDOP_DATO
						 RIGHT OUTER JOIN tb_aurea_area_gestione on aupoc_aurea_codice_pk = aurea_codice_pk
WHERE        (TB_AUDOP_DETTAGLIO_OPERAZIONI.AUOPE_CODICE_PK = @codop) AND AUSCA_CODICE_PK > 2


END




