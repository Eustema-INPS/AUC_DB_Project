﻿CREATE TABLE [dbo].[TB_AUDOP_DETTAGLIO_OPERAZIONI] (
    [AUDOP_CODICE_PK]    BIGINT       IDENTITY (1, 1) NOT NULL,
    [AUOPE_CODICE_PK]    INT          NULL,
    [AUDOP_TIPO_DATO]    VARCHAR (30) NULL,
    [AUDOP_DATO]         VARCHAR (16) NULL,
    [AUDOP_DATA_UPLOAD]  DATETIME     NULL,
    [AUDOP_UTENTE]       VARCHAR (50) NULL,
    [AUDOP_AUREP_CODICE] INT          NULL
);
