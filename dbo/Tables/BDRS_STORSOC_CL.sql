﻿CREATE TABLE [dbo].[BDRS_STORSOC_CL] (
    [BDRS_ID_VA]                 BIGINT       IDENTITY (500000, 1) NOT NULL,
    [BDRS_BDNG_EDI_VR]           BIGINT       NULL,
    [BDRS_BDSO_RIF_VR]           BIGINT       NULL,
    [BDRS_BDTS_APP_VR]           BIGINT       NULL,
    [BDRS_CODFISC_VB]            VARCHAR (11) NULL,
    [BDRS_CONTGESC_VB]           VARCHAR (1)  NULL,
    [BDRS_FLAG_OBBLDMA]          VARCHAR (1)  NULL,
    [BDRS_DATAFIN_VB]            DATE         NULL,
    [BDRS_DATAINI_VB]            DATE         NULL,
    [BDRS_DATAVAR_VB]            DATE         NULL,
    [BDRS_DENOM_VB]              VARCHAR (60) NULL,
    [BDRS_PIVA_VB]               VARCHAR (11) NULL,
    [BDRS_MODREC_VB]             DATETIME     NULL,
    [BDRS_PROGRESS_VB]           VARCHAR (5)  NULL,
    [BDRS_CERTIF_VB]             DATE         NULL,
    [BDRS_FLGOPZ_VB]             VARCHAR (1)  NULL,
    [BDRS_UTENTE_VB]             VARCHAR (40) CONSTRAINT [DF_BDRS_STORSOC_CL_BDRS_UTENTE_VB] DEFAULT ('Default NSI') NOT NULL,
    [BDRS_BDST_ERI_VR]           BIGINT       NULL,
    [BDRS_MAINIDMA_VB]           VARCHAR (6)  NULL,
    [BDRS_MAFINDMA_VB]           VARCHAR (6)  NULL,
    [BDRS_AUC_CODICE_PK]         BIGINT       NULL,
    [BDRS_AUC_DATA_INSERIMENTO]  DATETIME     CONSTRAINT [DF_BDRS_STORSOC_CL_BDRS_AUC_DATA_INSERIMENTO] DEFAULT (getdate()) NULL,
    [BDRS_AUC_STATO_LAVORAZIONE] INT          CONSTRAINT [DF_BDRS_STORSOC_CL_BDRS_AUC_STATO_LAVORAZIONE] DEFAULT ((0)) NULL,
    [BDRS_AUC_CF_EDI_PK]         VARCHAR (16) NULL,
    [BDRS_AUC_CF_RIF_PK]         VARCHAR (16) NULL,
    [BDRS_AUC_CF_APP_PK]         VARCHAR (16) NULL,
    [BDRS_AUC_AUSCA_EDI_PK]      INT          CONSTRAINT [DF_BDRS_STORSOC_CL_BDRS_AUC_AUSCA_EDI_PK] DEFAULT ((0)) NULL,
    [BDRS_AUC_AUSCA_RIF_PK]      INT          CONSTRAINT [DF_BDRS_STORSOC_CL_BDRS_AUC_AUSCA_RIF_PK] DEFAULT ((0)) NULL,
    [BDRS_AUC_AUSCA_APP_PK]      INT          CONSTRAINT [DF_BDRS_STORSOC_CL_BDRS_AUC_AUSCA_APP_PK] DEFAULT ((0)) NULL,
    [BDRS_AUC_PRESENTE]          INT          CONSTRAINT [DF_BDRS_STORSOC_CL_BDRS_AUC_PRESENTE] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_BDRS_STORSOC_CL] PRIMARY KEY CLUSTERED ([BDRS_ID_VA] ASC),
    CONSTRAINT [BDRS_CONTGESC_VB_CK] CHECK ([BDRS_CONTGESC_VB]='N' OR [BDRS_CONTGESC_VB]='S'),
    CONSTRAINT [FK_BDRS_BDSO_RIF_VR] FOREIGN KEY ([BDRS_BDSO_RIF_VR]) REFERENCES [dbo].[BDSO_SOCIETA_CL] ([BDSO_ID_VA]),
    CONSTRAINT [FK_BDRS_BDTS_APP_VR] FOREIGN KEY ([BDRS_BDTS_APP_VR]) REFERENCES [dbo].[BDTS_TIPOSOC_CT] ([BDTS_ID_VA])
);

