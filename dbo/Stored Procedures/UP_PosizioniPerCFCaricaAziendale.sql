

CREATE PROCEDURE [dbo].[UP_PosizioniPerCFCaricaAziendale] 
	@cf varchar(16),
	@ListCodCarica MatricoleList READONLY
AS
SET NOCOUNT ON;

BEGIN

SELECT ausca_codice_fiscale CFAzienda, aupoc_posizione Posizione,
 autis_codice_carica codice_carica, autis_descr descrizione_carica,
 aurss_data_inizio_validita data_inizio_validita, aurss_data_di_fine_validita data_fine_validita
 from tb_aurss_rel_sog_sog 
 join tb_ausca_sog_contr_az 
    on aurss_ausca_codice_pk = ausca_codice_pk
  join tb_ausco_sog_contr_col 
    on aurss_ausco_codice_pk = ausco_codice_pk
 join tb_autis_tipo_sog_col_ct  
    on aurss_autis_codice_pk = autis_codice_pk
 join @ListCodCarica c on autis_codice_carica = c.Matricola
 join tb_aupoc_pos_contr
    on aupoc_ausca_codice_pk = ausca_codice_pk
 where ausco_codice_fiscale = @cf and getdate() between aurss_data_inizio_validita and aurss_data_di_fine_validita
 AND dbo.tb_aupoc_pos_contr.aupoc_aurea_codice_pk = 1

 UNION 

 select ausca_codice_fiscale CFAzienda, aupoc_posizione Posizione,
 autis_codice_carica codice_carica, autis_descr descrizione_carica,
 aursp_data_inizio_validita data_inizio_validita, aursp_data_di_fine_validita data_fine_validita
 from dbo.tb_aursp_rel_sog_pos  
 join dbo.tb_aupoc_pos_contr 
    on aursp_aupoc_codice_pk = aupoc_codice_pk
  join dbo.tb_ausco_sog_contr_col  
    on aursp_ausco_codice_pk = ausco_codice_pk
 join tb_autis_tipo_sog_col_ct  
    on aursp_autis_codice_pk = autis_codice_pk
 join @ListCodCarica c on autis_codice_carica = c.Matricola
 join dbo.tb_ausca_sog_contr_az 
    on aupoc_ausca_codice_pk = ausca_codice_pk
 where ausco_codice_fiscale = @cf and getdate() between aursp_data_inizio_validita and aursp_data_di_fine_validita
 AND dbo.tb_aupoc_pos_contr.aupoc_aurea_codice_pk = 1
END
