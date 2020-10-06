﻿CREATE VIEW [dbo].[_dta_mv_202] WITH SCHEMABINDING AS SELECT  [dbo].[tb_aupoc_pos_contr].[aupoc_codice_pk] as _col_1,  [dbo].[tb_aupoc_pos_contr].[aupoc_aurea_codice_pk] as _col_2,  [dbo].[tb_aupoc_pos_contr].[aupoc_ausca_codice_pk] as _col_3,  [dbo].[tb_aupoc_pos_contr].[aupoc_ausin_codice_pk] as _col_4,  [dbo].[tb_aupoc_pos_contr].[aupoc_autia_codice_pk] as _col_5,  [dbo].[tb_aupco_periodo_contr].[aupco_codice_pk] as _col_6,  [dbo].[tb_aupco_periodo_contr].[aupco_auate_2007_codice_pk] as _col_7,  [dbo].[tb_aupoc_pos_contr].[aupoc_contro_codice] as _col_8,  [dbo].[tb_aupoc_pos_contr].[aupoc_posizione] as _col_9,  [dbo].[tb_aupoc_pos_contr].[aupoc_denom_posiz_contr] as _col_10,  [dbo].[tb_aupco_periodo_contr].[aupco_cod_stat_contr] as _col_11,  [dbo].[tb_aupco_periodo_contr].[aupco_codici_autor] as _col_12,  [dbo].[tb_auspc_stato_pos_contr_ct].[auspc_codice] as _col_13,  count_big(*) as _col_14 FROM  [dbo].[tb_aupco_periodo_contr],  [dbo].[tb_auspc_stato_pos_contr_ct],  [dbo].[tb_aupoc_pos_contr]   WHERE  [dbo].[tb_auspc_stato_pos_contr_ct].[auspc_codice_pk] = [dbo].[tb_aupoc_pos_contr].[aupoc_auspc_codice_pk]  AND  [dbo].[tb_aupco_periodo_contr].[aupco_aupoc_codice_pk] = [dbo].[tb_aupoc_pos_contr].[aupoc_codice_pk]  GROUP BY  [dbo].[tb_aupoc_pos_contr].[aupoc_codice_pk],  [dbo].[tb_aupoc_pos_contr].[aupoc_aurea_codice_pk],  [dbo].[tb_aupoc_pos_contr].[aupoc_ausca_codice_pk],  [dbo].[tb_aupoc_pos_contr].[aupoc_ausin_codice_pk],  [dbo].[tb_aupoc_pos_contr].[aupoc_autia_codice_pk],  [dbo].[tb_aupco_periodo_contr].[aupco_codice_pk],  [dbo].[tb_aupco_periodo_contr].[aupco_auate_2007_codice_pk],  [dbo].[tb_aupoc_pos_contr].[aupoc_contro_codice],  [dbo].[tb_aupoc_pos_contr].[aupoc_posizione],  [dbo].[tb_aupoc_pos_contr].[aupoc_denom_posiz_contr],  [dbo].[tb_aupco_periodo_contr].[aupco_cod_stat_contr],  [dbo].[tb_aupco_periodo_contr].[aupco_codici_autor],  [dbo].[tb_auspc_stato_pos_contr_ct].[auspc_codice]  
