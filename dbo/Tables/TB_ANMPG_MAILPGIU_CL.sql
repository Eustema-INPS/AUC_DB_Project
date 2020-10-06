﻿CREATE TABLE [dbo].[TB_ANMPG_MAILPGIU_CL] (
    [ANMPG_BDSO_ID_VA_PK]         BIGINT        NOT NULL,
    [ANMPG_PRG_MAIL_PK]           INT           NOT NULL,
    [ANMPG_DATA_INIZ]             DATE          NOT NULL,
    [ANMPG_DATA_FINE]             DATE          NOT NULL,
    [ANMPG_ANTCO_COD_TCONTATT]    VARCHAR (3)   NOT NULL,
    [ANMPG_MAIL_PERSGIU]          VARCHAR (100) NOT NULL,
    [ANMPG_COD_UTENTE]            VARCHAR (16)  NOT NULL,
    [ANMPG_DATA_AGGIORN]          DATE          NOT NULL,
    [ANMPG_COD_APPL]              VARCHAR (2)   NOT NULL,
    [ANMPG_DATA_SISTEMA]          DATETIME      NULL,
    [ANMPG_FLAG_PEC]              VARCHAR (1)   NOT NULL,
    [ANMPG_AUC_CODICE_PK]         BIGINT        IDENTITY (1, 1) NOT NULL,
    [ANMPG_AUC_DATA_INSERIMENTO]  DATETIME      CONSTRAINT [DF_TB_ANMPG_MAILPGIU_CL_ANMPG_AUC_DATA_INSERIMENTO] DEFAULT (getdate()) NULL,
    [ANMPG_AUC_STATO_LAVORAZIONE] INT           CONSTRAINT [DF_TB_ANMPG_MAILPGIU_CL_ANMPG_AUC_STATO_LAVORAZIONE] DEFAULT ((0)) NULL,
    [ANMPG_AUC_CF_PK]             VARCHAR (16)  NULL,
    [ANMPG_AUC_AUSCA_PK]          INT           NULL,
    [ANMPG_AUC_PRESENTE]          INT           CONSTRAINT [DF_TB_ANMPG_MAILPGIU_CL_ANMPG_AUC_PRESENTE] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ANMPG_MAILPGIU] PRIMARY KEY CLUSTERED ([ANMPG_BDSO_ID_VA_PK] ASC, [ANMPG_PRG_MAIL_PK] ASC),
    CONSTRAINT [CK1_ANMPG_DATE_INIZ_FINE] CHECK ([ANMPG_DATA_FINE]>=[ANMPG_DATA_INIZ]),
    CONSTRAINT [CK2_ANMPG_FLAG_PEC_DOM] CHECK ([ANMPG_FLAG_PEC]='S' OR [ANMPG_FLAG_PEC]='N'),
    CONSTRAINT [FK1_ANMPG_BDSO] FOREIGN KEY ([ANMPG_BDSO_ID_VA_PK]) REFERENCES [dbo].[BDSO_SOCIETA_CL] ([BDSO_ID_VA]),
    CONSTRAINT [FK2_ANMPG_ANTCO] FOREIGN KEY ([ANMPG_ANTCO_COD_TCONTATT]) REFERENCES [dbo].[TB_ANTCO_TCONTATT_CT] ([ANTCO_COD_TCONTATT_PK])
);

