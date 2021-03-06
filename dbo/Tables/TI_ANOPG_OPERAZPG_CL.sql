﻿CREATE TABLE [dbo].[TI_ANOPG_OPERAZPG_CL] (
    [ANOPG_SEQ_OPERAZPG_PK]   BIGINT       NULL,
    [ANOPG_ANTOG_COD_TOPERPG] VARCHAR (3)  NULL,
    [ANOPG_DATA_DECORRENZA]   DATE         NULL,
    [ANOPG_COD_UTENTE]        VARCHAR (16) NULL,
    [ANOPG_DATA_AGGIORN]      DATE         NULL,
    [ANOPG_COD_APPL]          VARCHAR (2)  NULL,
    [ANOPG_DATA_SISTEMA]      DATE         NULL,
    [ANOPG_CODICE_PK]         BIGINT       IDENTITY (1, 1) NOT NULL,
    [ANOPG_DATA_MODIFICA]     DATETIME     NULL,
    [ANOPG_DESCR_UTENTE]      VARCHAR (50) NULL
);

