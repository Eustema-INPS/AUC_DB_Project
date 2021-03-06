﻿CREATE TABLE [dbo].[TI_ANFGI_FORMAGIU_CT] (
    [ANFGI_COD_FORMAGIUR_PK] VARCHAR (3)   NULL,
    [ANFGI_DESCL_FORMAGIUR]  VARCHAR (200) NULL,
    [ANFGI_DESCB_FORMAGIUR]  VARCHAR (20)  NULL,
    [ANFGI_DATA_INIZ]        DATE          NULL,
    [ANFGI_DATA_FINE]        DATE          NULL,
    [ANFGI_FLAG_RESIDEN]     VARCHAR (1)   NULL,
    [ANFGI_FLAG_ESPOSIZ]     VARCHAR (1)   NULL,
    [ANFGI_NUMB_ORDINAM]     INT           NULL,
    [ANFGI_COD_UTENTE]       VARCHAR (16)  NULL,
    [ANFGI_DATA_AGGIORN]     DATE          NULL,
    [ANFGI_COD_APPL]         VARCHAR (2)   NULL,
    [ANFGI_CODICE_PK]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [ANFGI_DATA_MODIFICA]    DATETIME      NULL,
    [ANFGI_DESCR_UTENTE]     VARCHAR (50)  NULL
);

