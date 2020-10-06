CREATE TABLE [dbo].[TI_ANRPG_RUOLIPG_CL] (
    [ANRPG_BDSO_ID_VA_PK]           BIGINT       NULL,
    [ANRPG_ANTRL_COD_TIPRUOLOPG_PK] VARCHAR (3)  NULL,
    [ANRPG_DATA_INIZ_PK]            DATE         NULL,
    [ANRPG_DATA_FINE]               DATE         NULL,
    [ANRPG_COD_UTENTE]              VARCHAR (16) NULL,
    [ANRPG_DATA_AGGIORN]            DATE         NULL,
    [ANRPG_COD_APPL]                VARCHAR (2)  NULL,
    [ANRPG_DATA_SISTEMA]            DATE         NULL,
    [ANRPG_ANMCR_COD_MOTCHIRUPG]    VARCHAR (1)  NULL,
    [ANRPG_AUC_AUSCA_PK]            INT          NULL,
    [ANRPG_CODICE_PK]               BIGINT       IDENTITY (1, 1) NOT NULL,
    [ANRPG_DATA_MODIFICA]           DATETIME     NULL,
    [ANRPG_DESCR_UTENTE]            VARCHAR (50) NULL
);

