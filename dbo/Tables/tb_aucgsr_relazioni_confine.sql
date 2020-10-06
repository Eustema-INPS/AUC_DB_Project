CREATE TABLE [dbo].[tb_aucgsr_relazioni_confine] (
    [aucgsr_ausca_codice_fiscale]        VARCHAR (16)  NULL,
    [aucgsr_ausco_codice_fiscale]        VARCHAR (16)  NULL,
    [aucgsr_ausca_codice_pk]             INT           NULL,
    [aucgsr_ausco_codice_pk]             INT           NULL,
    [aucgsr_aurss_codice_pk]             INT           NULL,
    [aucgsr_aurrs_data_inizio_validita]  DATE          NULL,
    [aucgsr_aurss_data_di_fine_validita] DATE          NULL,
    [aucgsr_auc_data_modifica]           DATETIME      CONSTRAINT [DF_tb_aucgsr_aurss_gestione_separata_auc_data_modifica] DEFAULT (getdate()) NULL,
    [aucgsr_GS_data_modifica]            DATETIME      CONSTRAINT [DF_tb_aucgsr_aurss_gestione_separata_GS_data_modifica] DEFAULT (getdate()) NULL,
    [aucgsr_esito_ultima_modifica_auc]   INT           NULL,
    [aucgsr_esito_ultima_modifica_GS]    INT           NULL,
    [aucgsr_autis_codice_carica]         VARCHAR (3)   NULL,
    [aucgsr_autis_descr]                 VARCHAR (100) NULL,
    [aucgsr_autis_codice_pk]             INT           NULL,
    [aucgsr_tipologia_fonte]             VARCHAR (100) NULL,
    [aucgsr_descrizione_fonte]           VARCHAR (100) NULL,
    [aucgsr_AUC_flag_operativo_01]       INT           NULL,
    [aucgsr_AUC_flag_operativo_02]       INT           NULL,
    [aucgsr_GS_flag_operativo_01]        INT           NULL,
    [aucgsr_GS_flag_operativo_02]        INT           NULL,
    [aucgsr_aurss_provenienza]           VARCHAR (30)  NULL
);

