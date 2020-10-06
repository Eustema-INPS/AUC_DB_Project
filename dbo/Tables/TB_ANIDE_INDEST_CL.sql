﻿CREATE TABLE [dbo].[TB_ANIDE_INDEST_CL] (
    [ANIDE_SEQ_INDEST_PK]           BIGINT        NOT NULL,
    [ANIDE_DESCR_LINE1]             VARCHAR (200) NOT NULL,
    [ANIDE_DESCR_LINE2]             VARCHAR (200) NULL,
    [ANIDE_DESCR_CITTA]             VARCHAR (100) NULL,
    [ANIDE_DESCR_STATE_PROV_REGION] VARCHAR (100) NULL,
    [ANIDE_DATA_INIZ]               DATE          NOT NULL,
    [ANIDE_DATA_FINE]               DATE          NOT NULL,
    [ANIDE_COD_ZIP_POSTALCODE]      VARCHAR (50)  NULL,
    [ANIDE_BDLC_ID_VA]              BIGINT        NOT NULL,
    [ANIDE_COD_UTENTE]              VARCHAR (16)  NOT NULL,
    [ANIDE_DATA_AGGIORN]            DATE          NOT NULL,
    [ANIDE_COD_APPL]                VARCHAR (2)   NOT NULL,
    [ANIDE_DATA_SISTEMA]            DATE          NULL,
    CONSTRAINT [PK_TB_ANIDE_INDEST_CL] PRIMARY KEY CLUSTERED ([ANIDE_SEQ_INDEST_PK] ASC)
);
