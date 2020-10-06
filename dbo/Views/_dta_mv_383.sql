﻿CREATE VIEW [dbo].[_dta_mv_383] WITH SCHEMABINDING AS SELECT  [dbo].[tb_aupoc_pos_contr].[aupoc_auspc_codice_pk] as _col_1,  [dbo].[tb_aupoc_pos_contr].[aupoc_codice_pk] as _col_2,  [dbo].[tb_aupoc_pos_contr].[aupoc_ausca_codice_pk] as _col_3,  [dbo].[tb_aupoc_pos_contr].[aupoc_autia_codice_pk] as _col_4,  [dbo].[tb_aupoc_pos_contr].[aupoc_posizione] as _col_5,  [dbo].[tb_aupoc_pos_contr].[aupoc_contro_codice] as _col_6,  [dbo].[tb_aupoc_pos_contr].[aupoc_denom_posiz_contr] as _col_7,  [dbo].[tb_ausin_sedi_inps_ct].[ausin_codice_sede] as _col_8,  [dbo].[tb_aurea_area_gestione].[aurea_descrizione] as _col_9,  count_big(*) as _col_10 FROM  [dbo].[tb_aurea_area_gestione],  [dbo].[tb_ausin_sedi_inps_ct],  [dbo].[tb_aupoc_pos_contr]   WHERE  [dbo].[tb_aurea_area_gestione].[aurea_codice_pk] = [dbo].[tb_aupoc_pos_contr].[aupoc_aurea_codice_pk]  AND  [dbo].[tb_ausin_sedi_inps_ct].[ausin_codice_pk] = [dbo].[tb_aupoc_pos_contr].[aupoc_ausin_codice_pk]  GROUP BY  [dbo].[tb_aupoc_pos_contr].[aupoc_auspc_codice_pk],  [dbo].[tb_aupoc_pos_contr].[aupoc_codice_pk],  [dbo].[tb_aupoc_pos_contr].[aupoc_ausca_codice_pk],  [dbo].[tb_aupoc_pos_contr].[aupoc_autia_codice_pk],  [dbo].[tb_aupoc_pos_contr].[aupoc_posizione],  [dbo].[tb_aupoc_pos_contr].[aupoc_contro_codice],  [dbo].[tb_aupoc_pos_contr].[aupoc_denom_posiz_contr],  [dbo].[tb_ausin_sedi_inps_ct].[ausin_codice_sede],  [dbo].[tb_aurea_area_gestione].[aurea_descrizione]  