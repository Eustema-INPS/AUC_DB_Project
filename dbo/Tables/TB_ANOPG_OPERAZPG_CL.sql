﻿CREATE TABLE [dbo].[TB_ANOPG_OPERAZPG_CL] (
    [ANOPG_SEQ_OPERAZPG_PK]       BIGINT       IDENTITY (30000, 1) NOT NULL,
    [ANOPG_ANTOG_COD_TOPERPG]     VARCHAR (3)  NOT NULL,
    [ANOPG_DATA_DECORRENZA]       DATE         NOT NULL,
    [ANOPG_COD_UTENTE]            VARCHAR (16) NOT NULL,
    [ANOPG_DATA_AGGIORN]          DATE         NOT NULL,
    [ANOPG_COD_APPL]              VARCHAR (2)  NOT NULL,
    [ANOPG_DATA_SISTEMA]          DATETIME     NULL,
    [ANOPG_AUC_CODICE_PK]         BIGINT       NULL,
    [ANOPG_AUC_DATA_INSERIMENTO]  DATETIME     CONSTRAINT [DF_TB_ANOPG_OPERAZPG_CL_ANOPG_AUC_DATA_INSERIMENTO] DEFAULT (getdate()) NULL,
    [ANOPG_AUC_STATO_LAVORAZIONE] INT          CONSTRAINT [DF_TB_ANOPG_OPERAZPG_CL_ANOPG_AUC_STATO_LAVORAZIONE] DEFAULT ((0)) NULL,
    [ANOPG_AUC_PRESENTE]          INT          CONSTRAINT [DF_TB_ANOPG_OPERAZPG_CL_ANOPG_AUC_PRESENTE] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ANOPG_OPERAZPG] PRIMARY KEY CLUSTERED ([ANOPG_SEQ_OPERAZPG_PK] ASC),
    CONSTRAINT [FK1_ANOPG_ANTOG] FOREIGN KEY ([ANOPG_ANTOG_COD_TOPERPG]) REFERENCES [dbo].[TB_ANTOG_TOPERPG_CT] ([ANTOG_COD_TOPERPG_PK])
);

