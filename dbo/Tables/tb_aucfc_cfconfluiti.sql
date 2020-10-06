CREATE TABLE [dbo].[tb_aucfc_cfconfluiti] (
    [aucfc_codice_PK]         INT          IDENTITY (1, 1) NOT NULL,
    [aucfc_ausca_codice_PK]   INT          NOT NULL,
    [aucfc_codice_gestione]   VARCHAR (50) NULL,
    [aucfc_cf]                VARCHAR (16) NULL,
    [aucfc_stato]             VARCHAR (20) NULL,
    [aucfc_motivo_cessazione] VARCHAR (60) NULL,
    [aucfc_data_inizio]       DATETIME     NULL,
    [aucfc_data_fine]         DATETIME     NULL,
    [aucfc_cf_confluenza]     VARCHAR (16) NULL,
    [aucfc_data_modifica]     DATETIME     CONSTRAINT [DF_TB_AUCFC_CFCONFLUITI_AUCFC_DATA_MODIFICA] DEFAULT (getdate()) NULL,
    [aucfc_descr_utente]      VARCHAR (50) NULL,
    [aucfc_rec_del]           VARCHAR (1)  NULL,
    [aucfc_data_del]          DATETIME     NULL
);

