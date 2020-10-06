﻿CREATE VIEW [dbo].[_dta_mv_468] AS SELECT  [dbo].[tb_aupoc_pos_contr].[aupoc_posizione] as _col_1,  [dbo].[tb_aupoc_pos_contr].[aupoc_codice_pk] as _col_2,  [dbo].[tb_aupoc_pos_contr].[aupoc_contro_codice] as _col_3,  [dbo].[tb_aupoc_pos_contr].[aupoc_data_inizio_attivita] as _col_4,  [dbo].[tb_aupoc_pos_contr].[aupoc_denom_posiz_contr] as _col_5,  [dbo].[tb_aupoc_pos_contr].[aupoc_cod_prov_istat] as _col_6,  [dbo].[tb_aupoc_pos_contr].[aupoc_cod_comune_istat] as _col_7,  [dbo].[tb_aupoc_pos_contr].[aupoc_prog_azienda_agr] as _col_8,  [dbo].[tb_aupoc_pos_contr].[aupoc_data_domanda_iscr] as _col_9,  [dbo].[tb_aupoc_pos_contr].[aupoc_cod_sede_INPS] as _col_10,  [dbo].[tb_aupoc_pos_contr].[aupoc_attivita_dichiarata] as _col_11,  [dbo].[tb_aupoc_pos_contr].[aupoc_data_modifica] as _col_12,  [dbo].[tb_aupoc_pos_contr].[aupoc_descr_utente] as _col_13,  [dbo].[tb_aupoc_pos_contr].[aupoc_ateco] as _col_14,  [dbo].[tb_aupoc_pos_contr].[aupoc_aurea_codice_pk] as _col_15,  [dbo].[tb_aupoc_pos_contr].[aupoc_aucom_codice] as _col_16,  [dbo].[tb_aupoc_pos_contr].[aupoc_cf_confluito] as _col_17,  [dbo].[tb_aupoc_pos_contr].[aupoc_codice_categoria] as _col_18,  [dbo].[tb_aupoc_pos_contr].[aupoc_codice_gruppo] as _col_19,  [dbo].[tb_aupoc_pos_contr].[aupoc_id_confluito] as _col_20,  [dbo].[tb_aupoc_pos_contr].[aupoc_id_sin] as _col_21,  [dbo].[tb_aupoc_pos_contr].[aupoc_progressivo_confluito] as _col_22,  [dbo].[tb_aupoc_pos_contr].[aupoc_data_ultimo_stato] as _col_23,  [dbo].[tb_aupoc_pos_contr].[aupoc_descr_stato_GS] as _col_24,  [dbo].[tb_ausca_sog_contr_az].[ausca_denominazione] as _col_25,  [dbo].[tb_ausca_sog_contr_az].[ausca_codice_fiscale] as _col_26,  [dbo].[tb_ausca_sog_contr_az].[ausca_PEC] as _col_27,  [dbo].[tb_auspc_stato_pos_contr_ct].[auspc_codice] as _col_28,  [dbo].[tb_auspc_stato_pos_contr_ct].[auspc_descr] as _col_29,  [dbo].[tb_ausin_sedi_inps_ct].[ausin_descr] as _col_30,  [dbo].[tb_aupoc_pos_contr].[aupoc_autdt_codice_pk] as _col_31,  [dbo].[tb_aupoc_pos_contr].[aupoc_autd2_codice_pk] as _col_32,  [dbo].[tb_aupoc_pos_contr].[aupoc_autia_codice_pk] as _col_33,  [dbo].[tb_ausca_sog_contr_az].[ausca_aungi_codice_pk] as _col_34,  [dbo].[tb_aupoc_pos_contr].[aupoc_auate_2007_codice_pk] as _col_35,  [dbo].[tb_aupoc_pos_contr].[aupoc_tipo_posizione] as _col_36,  [dbo].[tb_ausin_sedi_inps_ct].[ausin_codice_regione] as _col_37,  [dbo].[tb_ausin_sedi_inps_ct].[ausin_codice_sede] as _col_38,  [dbo].[tb_ausin_sedi_inps_ct].[ausin_codice_pk] as _col_39 FROM  [dbo].[tb_auspc_stato_pos_contr_ct],  [dbo].[tb_ausin_sedi_inps_ct],  [dbo].[tb_ausca_sog_contr_az],  [dbo].[tb_aupoc_pos_contr]   WHERE  [dbo].[tb_ausin_sedi_inps_ct].[ausin_codice_regione] = [dbo].[tb_aupoc_pos_contr].[aupoc_cod_sede_INPS]  AND  [dbo].[tb_ausca_sog_contr_az].[ausca_codice_pk] = [dbo].[tb_aupoc_pos_contr].[aupoc_ausca_codice_pk]  AND  [dbo].[tb_auspc_stato_pos_contr_ct].[auspc_codice_pk] = [dbo].[tb_aupoc_pos_contr].[aupoc_auspc_codice_pk]  
