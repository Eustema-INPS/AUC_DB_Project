﻿CREATE TABLE [dbo].[TI_BDRS_STORSOC_CL] (
    [BDRS_ID_VA]            BIGINT       NULL,
    [BDRS_BDNG_EDI_VR]      BIGINT       NULL,
    [BDRS_BDSO_RIF_VR]      BIGINT       NULL,
    [BDRS_BDTS_APP_VR]      BIGINT       NULL,
    [BDRS_CODFISC_VB]       VARCHAR (11) NULL,
    [BDRS_CONTGESC_VB]      VARCHAR (1)  NULL,
    [BDRS_FLAG_OBBLDMA]     VARCHAR (1)  NULL,
    [BDRS_DATAFIN_VB]       DATE         NULL,
    [BDRS_DATAINI_VB]       DATE         NULL,
    [BDRS_DATAVAR_VB]       DATE         NULL,
    [BDRS_DENOM_VB]         VARCHAR (60) NULL,
    [BDRS_PIVA_VB]          VARCHAR (11) NULL,
    [BDRS_MODREC_VB]        DATE         NULL,
    [BDRS_PROGRESS_VB]      VARCHAR (5)  NULL,
    [BDRS_CERTIF_VB]        DATE         NULL,
    [BDRS_FLGOPZ_VB]        VARCHAR (1)  NULL,
    [BDRS_UTENTE_VB]        VARCHAR (40) NULL,
    [BDRS_BDST_ERI_VR]      BIGINT       NULL,
    [BDRS_MAINIDMA_VB]      VARCHAR (6)  NULL,
    [BDRS_MAFINDMA_VB]      VARCHAR (6)  NULL,
    [BDRS_AUC_AUSCA_EDI_PK] INT          NULL,
    [BDRS_AUC_AUSCA_RIF_PK] INT          NULL,
    [BDRS_AUC_AUSCA_APP_PK] INT          NULL,
    [BDRS_CODICE_PK]        BIGINT       IDENTITY (1, 1) NOT NULL,
    [BDRS_DATA_MODIFICA]    DATETIME     NULL,
    [BDRS_DESCR_UTENTE]     VARCHAR (50) NULL
);

