﻿CREATE TABLE [dbo].[TI_BDZE_ISCRIZEN_CL] (
    [BDZE_ID_VA]            BIGINT       NULL,
    [BDZE_BDCS_EDI_VR]      BIGINT       NULL,
    [BDZE_BDPI_EDI_VR]      BIGINT       NULL,
    [BDZE_BDSO_EDI_VR]      BIGINT       NULL,
    [BDZE_DATAFINE_VB]      DATE         NULL,
    [BDZE_DATAINI_VB]       DATE         NULL,
    [BDZE_DATARICH_VB]      DATE         NULL,
    [BDZE_MODREC_VB]        DATE         NULL,
    [BDZE_UTENTE_VB]        VARCHAR (40) NULL,
    [BDZE_BDST_ERI_VR]      BIGINT       NULL,
    [BDZE_BDPI_ID_VA]       BIGINT       NULL,
    [BDZE_BDPI_CODTISCR_VB] VARCHAR (3)  NULL,
    [BDZE_BDPI_DESCRTI_VB]  VARCHAR (30) NULL,
    [BDZE_AUC_AUSCA_PK]     INT          NULL,
    [BDZE_CODICE_PK]        BIGINT       IDENTITY (1, 1) NOT NULL,
    [BDZE_DATA_MODIFICA]    DATETIME     NULL,
    [BDZE_DESCR_UTENTE]     VARCHAR (50) NULL
);

