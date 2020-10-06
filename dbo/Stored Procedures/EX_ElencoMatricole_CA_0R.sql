

CREATE PROCEDURE [dbo].[EX_ElencoMatricole_CA_0R]
  @DataElaborazione AS date
AS
BEGIN
  SET NOCOUNT ON;

SELECT
    tb_aupoc_pos_contr.aupoc_posizione as Matricola
FROM  tb_aupoc_pos_contr WITH (READUNCOMMITTED)
    INNER JOIN tb_aupco_periodo_contr WITH (READUNCOMMITTED) ON
        aupco_aupoc_codice_pk = aupoc_codice_pk  AND @DataElaborazione BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita 
		AND aupco_codici_autor LIKE '%0R%' --AUPCO
END
