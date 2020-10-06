CREATE TABLE [dbo].[TI_ANCOT_COMPTERR_CL] (
    [ANCOT_BDSO_ID_VA_PK]          BIGINT       NULL,
    [ANCOT_ANTCT_COD_TIPCOMTER_PK] VARCHAR (50) NULL,
    [ANCOT_BDLC_ID_VA_PK]          BIGINT       NULL,
    [ANCOT_DATA_INIZ_PK]           DATE         NULL,
    [ANCOT_DATA_FINE]              DATE         NULL,
    [ANCOT_COD_UTENTE]             VARCHAR (16) NULL,
    [ANCOT_DATA_AGGIORN]           DATE         NULL,
    [ANCOT_COD_APPL]               VARCHAR (2)  NULL,
    [ANCOT_DATA_SISTEMA]           DATE         NULL,
    [ANCOT_AUC_AUSCA_PK]           INT          NULL,
    [ANCOT_CODICE_PK]              BIGINT       IDENTITY (1, 1) NOT NULL,
    [ANCOT_DATA_MODIFICA]          DATETIME     NULL,
    [ANCOT_DESCR_UTENTE]           VARCHAR (50) NULL
);

