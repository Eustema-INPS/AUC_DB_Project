﻿CREATE TABLE [dbo].[BDSO_SOCIETA_CL] (
    [BDSO_ID_VA]                     BIGINT        IDENTITY (200000, 1) NOT NULL,
    [BDSO_BDNG_EDI_VR]               BIGINT        NULL,
    [BDSO_BDTS_APP_VR]               BIGINT        NOT NULL,
    [BDSO_CODFISC_VB]                VARCHAR (11)  NOT NULL,
    [BDSO_CONTGESC_VB]               VARCHAR (1)   NULL,
    [BDSO_DATAFIN_VB]                DATE          NULL,
    [BDSO_DATAINI_VB]                DATE          NOT NULL,
    [BDSO_DENOM_VB]                  VARCHAR (60)  NOT NULL,
    [BDSO_FLGOPZ_VB]                 VARCHAR (1)   NULL,
    [BDSO_PIVA_VB]                   VARCHAR (11)  NULL,
    [BDSO_TIMELOCK_VB]               DATE          NULL,
    [BDSO_MODREC_VB]                 DATETIME      NULL,
    [BDSO_CERTIF_VB]                 DATE          NULL,
    [BDSO_PROGRESS_VB]               VARCHAR (5)   CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_PROGRESS_VB] DEFAULT ('00000') NOT NULL,
    [BDSO_IDBDSO_VR]                 BIGINT        NULL,
    [BDSO_BDST_ERI_VR]               BIGINT        NOT NULL,
    [BDSO_UTENTE_VB]                 VARCHAR (40)  CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_UTENTE_VB] DEFAULT ('Default NSI') NOT NULL,
    [BDSO_DTVAR_VB]                  DATE          NOT NULL,
    [BDSO_BDSO_REC_VR]               BIGINT        NULL,
    [BDSO_FLSOSIMP_VB]               VARCHAR (1)   CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_FLSOSIMP_VB] DEFAULT ('N') NOT NULL,
    [BDSO_FLAPPART_VB]               VARCHAR (1)   CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_FLAPPART_VB] DEFAULT ('N') NOT NULL,
    [BDSO_FLSEDSER_VB]               VARCHAR (1)   CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_FLSEDSER_VB] DEFAULT ('N') NOT NULL,
    [BDSO_FLVERSAN_VB]               VARCHAR (1)   CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_FLVERSAN_VB] DEFAULT ('N') NOT NULL,
    [BDSO_DTFCOMPE_VB]               DATE          NULL,
    [BDSO_ANATE_APP_VR]              VARCHAR (5)   NULL,
    [BDSO_ANFGI_APP_VR]              VARCHAR (3)   NULL,
    [BDSO_CERTISCR_VB]               DATE          NULL,
    [BDSO_MAINIDMA_VB]               VARCHAR (6)   NULL,
    [BDSO_CODINPS_VB]                VARCHAR (15)  NULL,
    [BDSO_DENOMB_VB]                 VARCHAR (44)  NULL,
    [BDSO_FLGECCOMP_VB]              VARCHAR (1)   CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_FLGECCOMP_VB] DEFAULT ('N') NOT NULL,
    [BDSO_BDSO_VIG_VR]               BIGINT        NULL,
    [BDSO_FLGERR_VB]                 VARCHAR (1)   CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_FLGERR_VB] DEFAULT ('N') NOT NULL,
    [BDSO_MAFINDMA_VB]               VARCHAR (6)   NULL,
    [BDSO_ANTLI_COD_TIPLIQUID]       VARCHAR (2)   NULL,
    [BDSO_DATA_LIQUID]               DATE          NULL,
    [BDSO_DATA_BLOCCOPA]             DATE          NULL,
    [BDSO_DATA_INIZGESCEN]           DATE          NULL,
    [BDSO_DATA_FINEGESCEN]           DATE          NULL,
    [BDSO_AUC_CODICE_PK]             BIGINT        NULL,
    [BDSO_AUC_DATA_INSERIMENTO]      DATETIME      CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_AUC_DATA_INSERIMENTO] DEFAULT (getdate()) NULL,
    [BDSO_AUC_STATO_LAVORAZIONE]     INT           CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_AUC_STATO_LAVORAZIONE] DEFAULT ((0)) NULL,
    [BDSO_AUC_AUSCA_PK]              INT           NULL,
    [BDSO_AUC_PRESENTE]              INT           CONSTRAINT [DF_BDSO_SOCIETA_CL_BDSO_AUC_PRESENTE] DEFAULT ((0)) NULL,
    [BDSO_POSIZIONE]                 VARCHAR (50)  NULL,
    [BDSO_AUC_PRESENTE_AUPOC]        INT           NULL,
    [BDSO_AUC_AUPOC_PK]              INT           NULL,
    [BDSO_AUC_STATO_POSIZIONE]       INT           NULL,
    [BDSO_AUC_AUSIN_CODICE_PK]       INT           NULL,
    [BDSO_AUC_CF_CONFLUITO]          VARCHAR (16)  NULL,
    [BDSO_AUC_PROGRESSIVO_CONFLUITO] VARCHAR (5)   NULL,
    [BDSO_AUC_PEC]                   VARCHAR (162) NULL,
    [BDSO_AUC_FORMAG]                VARCHAR (50)  NULL,
    [BDSO_AUC_NATURAG]               VARCHAR (50)  NULL,
    [BDSO_AUC_AUNGI]                 INT           NULL,
    [BDSO_FLAG_ECC_PUNICO]           VARCHAR (1)   NULL,
    [BDSO_DTFCOMPEMIL_VB]            DATE          NULL,
    [BDSO_CODICE_STRUT_INPDAP]       VARCHAR (20)  NULL,
    [BDSO_CODICE_STRUT_INPS]         VARCHAR (20)  NULL,
    [BDSO_TOPONIMO]                  VARCHAR (100) NULL,
    [BDSO_COMPLEMENTO]               VARCHAR (200) NULL,
    [BDSO_DESCRIZIONE]               VARCHAR (200) NULL,
    [BDSO_CIVICO]                    VARCHAR (100) NULL,
    [BDSO_FRAZIONE]                  VARCHAR (100) NULL,
    [BDSO_LOCALITA]                  VARCHAR (100) NULL,
    [BDSO_CAP]                       VARCHAR (50)  NULL,
    [BDSO_SIGLA_PROVINCIA]           VARCHAR (100) NULL,
    CONSTRAINT [PK_BDSO_SOCIETA_CL] PRIMARY KEY CLUSTERED ([BDSO_ID_VA] ASC),
    CONSTRAINT [BDSO_CONTGESC_CK] CHECK ([BDSO_CONTGESC_VB]='N' OR [BDSO_CONTGESC_VB]='S'),
    CONSTRAINT [BDSO_FLAPPART_CK] CHECK ([BDSO_FLAPPART_VB]='N' OR [BDSO_FLAPPART_VB]='S'),
    CONSTRAINT [BDSO_FLGECCOMP_CK] CHECK ([BDSO_FLGECCOMP_VB]='N' OR [BDSO_FLGECCOMP_VB]='S'),
    CONSTRAINT [BDSO_FLGERR_CK] CHECK ([BDSO_FLGERR_VB]='N' OR [BDSO_FLGERR_VB]='S'),
    CONSTRAINT [BDSO_FLGOPZ_CK] CHECK ([BDSO_FLGOPZ_VB]='S' OR [BDSO_FLGOPZ_VB]=NULL),
    CONSTRAINT [BDSO_FLSEDSER_CK] CHECK ([BDSO_FLSEDSER_VB]='N' OR [BDSO_FLSEDSER_VB]='S'),
    CONSTRAINT [BDSO_FLSOSIMP_CK] CHECK ([BDSO_FLSOSIMP_VB]='N' OR [BDSO_FLSOSIMP_VB]='S'),
    CONSTRAINT [BDSO_FLVERSAN_CK] CHECK ([BDSO_FLVERSAN_VB]='N' OR [BDSO_FLVERSAN_VB]='S'),
    CONSTRAINT [FK_BDSO_BDNG_EDI_VR] FOREIGN KEY ([BDSO_BDNG_EDI_VR]) REFERENCES [dbo].[BDNG_NATGIUR_CT] ([BDNG_ID_VA]),
    CONSTRAINT [FK_BDSO_BDSO_IDBDSO_VR] FOREIGN KEY ([BDSO_IDBDSO_VR]) REFERENCES [dbo].[BDSO_SOCIETA_CL] ([BDSO_ID_VA]),
    CONSTRAINT [FK_BDSO_BDSO_REC_VR] FOREIGN KEY ([BDSO_BDSO_REC_VR]) REFERENCES [dbo].[BDSO_SOCIETA_CL] ([BDSO_ID_VA]),
    CONSTRAINT [FK_BDSO_BDSO_VIG_VR] FOREIGN KEY ([BDSO_BDSO_VIG_VR]) REFERENCES [dbo].[BDSO_SOCIETA_CL] ([BDSO_ID_VA]),
    CONSTRAINT [FK_BDSO_BDTS_APP_VR] FOREIGN KEY ([BDSO_BDTS_APP_VR]) REFERENCES [dbo].[BDTS_TIPOSOC_CT] ([BDTS_ID_VA]),
    CONSTRAINT [FK1_BDSO_ANFGI] FOREIGN KEY ([BDSO_ANFGI_APP_VR]) REFERENCES [dbo].[TB_ANFGI_FORMAGIU_CT] ([ANFGI_COD_FORMAGIUR_PK])
);

