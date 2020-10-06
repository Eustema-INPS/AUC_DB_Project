﻿CREATE TABLE [dbo].[TI_ANMPG_MAILPGIU_CL] (
    [ANMPG_BDSO_ID_VA_PK]      BIGINT        NULL,
    [ANMPG_PRG_MAIL_PK]        INT           NULL,
    [ANMPG_DATA_INIZ]          DATE          NULL,
    [ANMPG_DATA_FINE]          DATE          NULL,
    [ANMPG_ANTCO_COD_TCONTATT] VARCHAR (100) NULL,
    [ANMPG_MAIL_PERSGIU]       VARCHAR (100) NULL,
    [ANMPG_COD_UTENTE]         VARCHAR (16)  NULL,
    [ANMPG_DATA_AGGIORN]       DATE          NULL,
    [ANMPG_COD_APPL]           VARCHAR (2)   NULL,
    [ANMPG_DATA_SISTEMA]       DATE          NULL,
    [ANMPG_FLAG_PEC]           VARCHAR (1)   NULL,
    [ANMPG_AUC_AUSCA_PK]       INT           NULL,
    [ANMPG_CODICE_PK]          BIGINT        IDENTITY (1, 1) NOT NULL,
    [ANMPG_DATA_MODIFICA]      DATETIME      NULL,
    [ANMPG_DESCR_UTENTE]       VARCHAR (50)  NULL
);
