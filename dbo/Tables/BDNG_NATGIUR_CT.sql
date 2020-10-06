﻿CREATE TABLE [dbo].[BDNG_NATGIUR_CT] (
    [BDNG_ID_VA]                 BIGINT       IDENTITY (700, 1) NOT NULL,
    [BDNG_CODICE_VB]             VARCHAR (6)  NULL,
    [BDNG_DESCRIZ_VB]            VARCHAR (60) NULL,
    [BDNG_MODREC_VB]             DATETIME     NULL,
    [BDNG_NSI_VB]                VARCHAR (1)  CONSTRAINT [DF_BDNG_NATGIUR_CT_BDNG_NSI_VB] DEFAULT ('S') NOT NULL,
    [BDNG_BDRG_ERI_VR]           BIGINT       NULL,
    [BDNG_DATAINI_VB]            DATE         CONSTRAINT [DF_BDNG_NATGIUR_CT_BDNG_DATAINI_VB] DEFAULT (CONVERT([date],'1948-01-01')) NOT NULL,
    [BDNG_DATAFIN_VB]            DATE         NULL,
    [BDNG_FLGOBBL_VB]            VARCHAR (1)  CONSTRAINT [DF_BDNG_NATGIUR_CT_BDNG_FLGOBBL_VB] DEFAULT ('N') NOT NULL,
    [BDNG_FLAG_DATABLOCPA]       VARCHAR (1)  CONSTRAINT [DF_BDNG_NATGIUR_CT_BDNG_FLAG_DATABLOCPA] DEFAULT ('N') NOT NULL,
    [BDNG_FLAG_DATA_AMM_CEN]     VARCHAR (1)  CONSTRAINT [DF_BDNG_NATGIUR_CT_BDNG_FLAG_DATA_AMM_CEN] DEFAULT ('N') NULL,
    [BDNG_AUC_CODICE_PK]         BIGINT       NULL,
    [BDNG_AUC_DATA_INSERIMENTO]  DATETIME     CONSTRAINT [DF_BDNG_NATGIUR_CT_BDNG_AUC_DATA_INSERIMENTO] DEFAULT (getdate()) NULL,
    [BDNG_AUC_STATO_LAVORAZIONE] INT          CONSTRAINT [DF_BDNG_NATGIUR_CT_BDNG_AUC_STATO_LAVORAZIONE] DEFAULT ((0)) NULL,
    [BDNG_AUC_PRESENTE]          INT          CONSTRAINT [DF_BDNG_NATGIUR_CT_BDNG_AUC_PRESENTE] DEFAULT ((0)) NULL,
    [BDNG_FLAG_AMM_PUB]          VARCHAR (1)  NULL,
    [BDNG_ANCNG_COD_CLASS]       VARCHAR (1)  NULL,
    CONSTRAINT [PK_BDNG_NATGIUR_CT] PRIMARY KEY CLUSTERED ([BDNG_ID_VA] ASC),
    CONSTRAINT [BDNG_FLGOBBL_CK] CHECK ([BDNG_FLGOBBL_VB]='N' OR [BDNG_FLGOBBL_VB]='S'),
    CONSTRAINT [FK_BDNG_BDRG_ERI_VR] FOREIGN KEY ([BDNG_BDRG_ERI_VR]) REFERENCES [dbo].[BDRG_RGNATGIU_CT] ([BDRG_ID_VA]),
    CONSTRAINT [FK1_BDNG_ANCNG] FOREIGN KEY ([BDNG_ANCNG_COD_CLASS]) REFERENCES [dbo].[TB_ANCNG_CLASSNG_CT] ([ANCNG_COD_CLASS_PK])
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Codice natura giuridica', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BDNG_NATGIUR_CT', @level2type = N'COLUMN', @level2name = N'BDNG_CODICE_VB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indica la categoria della platea della pubblica amministrazione (valori ammessi: P - Platea pubblica amministrazione, O - Organi costituzionali)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'BDNG_NATGIUR_CT', @level2type = N'COLUMN', @level2name = N'BDNG_ANCNG_COD_CLASS';

