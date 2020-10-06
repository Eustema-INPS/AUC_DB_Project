-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 28.05.2013
-- Description:	Stored Procedure per caricare le casse inpdap afferenti al codice aupoc specifico
-- =============================================

CREATE PROCEDURE [dbo].[AZ_ElencoCasseInpdap]
	@codicePosizione int
AS
BEGIN

SELECT 
  tb_aupoc_pos_contr.aupoc_codice_pk
, tb_aupoc_pos_contr.aupoc_posizione
, tb_aupoc_pos_contr.aupoc_denom_posiz_contr
, convert (varchar(10),tb_auica_iscritte_casse.auica_data_inizio,103)  as DB_DataInizio
, convert (varchar(10),tb_auica_iscritte_casse.auica_data_fine,103) as DB_DataFine
, tb_auica_iscritte_casse.auica_cassa
, tb_aucas_casse_inpdap.aucas_codice as DB_CodiceCassa
, tb_aucas_casse_inpdap.aucas_codice_pk
, tb_aucas_casse_inpdap.aucas_descrizione_brevre
, tb_aucas_casse_inpdap.aucas_descrizione as Db_DescCassa
FROM tb_aupoc_pos_contr INNER JOIN tb_auica_iscritte_casse ON 
     tb_aupoc_pos_contr.aupoc_codice_pk = tb_auica_iscritte_casse.auica_aupoc_codice_pk INNER JOIN tb_aucas_casse_inpdap ON 
     tb_auica_iscritte_casse.auica_aucas_codice_pk = tb_aucas_casse_inpdap.aucas_codice_pk
WHERE 
(tb_aupoc_pos_contr.aupoc_codice_pk=@codicePosizione)
order by tb_aucas_casse_inpdap.aucas_codice 

END
