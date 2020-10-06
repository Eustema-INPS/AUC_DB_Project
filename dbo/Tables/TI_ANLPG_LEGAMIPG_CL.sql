CREATE TABLE [dbo].[TI_ANLPG_LEGAMIPG_CL] (
    [ANLPG_BDSO_ID_VA_RLD_PK]        BIGINT       NULL,
    [ANLPG_BDSO_ID_VA_RLA_PK]        BIGINT       NULL,
    [ANLPG_ANTLP_COD_TIPLEGAMEPG_PK] VARCHAR (2)  NULL,
    [ANLPG_DATA_INIZ_PK]             DATE         NULL,
    [ANLPG_DATA_FINE]                DATE         NULL,
    [ANLPG_COD_UTENTE]               VARCHAR (16) NULL,
    [ANLPG_DATA_AGGIORN]             DATE         NULL,
    [ANLPG_COD_APPL]                 VARCHAR (2)  NULL,
    [ANLPG_DATA_SISTEMA]             DATE         NULL,
    [ANLPG_AUC_AUSCA_RLD_PK]         INT          NULL,
    [ANLPG_AUC_AUSCA_RLA_PK]         INT          NULL,
    [ANLPG_CODICE_PK]                BIGINT       IDENTITY (1, 1) NOT NULL,
    [ANLPG_DATA_MODIFICA]            DATETIME     NULL,
    [ANLPG_DESCR_UTENTE]             VARCHAR (50) NULL
);

