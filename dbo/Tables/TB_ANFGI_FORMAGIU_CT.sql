﻿CREATE TABLE [dbo].[TB_ANFGI_FORMAGIU_CT] (
    [ANFGI_COD_FORMAGIUR_PK]      VARCHAR (3)   NOT NULL,
    [ANFGI_DESCL_FORMAGIUR]       VARCHAR (200) NOT NULL,
    [ANFGI_DESCB_FORMAGIUR]       VARCHAR (20)  NULL,
    [ANFGI_DATA_INIZ]             DATE          NOT NULL,
    [ANFGI_DATA_FINE]             DATE          NOT NULL,
    [ANFGI_FLAG_RESIDEN]          VARCHAR (1)   NOT NULL,
    [ANFGI_FLAG_ESPOSIZ]          VARCHAR (1)   NOT NULL,
    [ANFGI_NUMB_ORDINAM]          INT           NOT NULL,
    [ANFGI_COD_UTENTE]            VARCHAR (16)  NOT NULL,
    [ANFGI_DATA_AGGIORN]          DATE          NOT NULL,
    [ANFGI_COD_APPL]              VARCHAR (2)   NOT NULL,
    [ANFGI_AUC_CODICE_PK]         BIGINT        IDENTITY (1, 1) NOT NULL,
    [ANFGI_AUC_DATA_INSERIMENTO]  DATETIME      CONSTRAINT [DF_TB_ANFGI_FORMAGIU_CT_ANFGI_AUC_DATA_INSERIMENTO] DEFAULT (getdate()) NULL,
    [ANFGI_AUC_STATO_LAVORAZIONE] INT           CONSTRAINT [DF_TB_ANFGI_FORMAGIU_CT_ANFGI_AUC_STATO_LAVORAZIONE] DEFAULT ((0)) NULL,
    [ANFGI_AUC_PRESENTE]          INT           CONSTRAINT [DF_TB_ANFGI_FORMAGIU_CT_ANFGI_AUC_PRESENTE] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_TB_ANFGI_FORMAGIU_CT] PRIMARY KEY CLUSTERED ([ANFGI_COD_FORMAGIUR_PK] ASC),
    CONSTRAINT [CK1_ANFGI_FLAG_RESIDEN] CHECK ([ANFGI_FLAG_RESIDEN]='N' OR [ANFGI_FLAG_RESIDEN]='S'),
    CONSTRAINT [CK1_ANFGI_FORMAGIU_FLG_RESIDEN] CHECK ([ANFGI_FLAG_RESIDEN]='N' OR [ANFGI_FLAG_RESIDEN]='S'),
    CONSTRAINT [CK1_ANFGI_FORMGIUR_FLG_ESPOSIZ] CHECK ([ANFGI_FLAG_ESPOSIZ]='N' OR [ANFGI_FLAG_ESPOSIZ]='S'),
    CONSTRAINT [CK2_ANFGI_FLAG_ESPOSIZ] CHECK ([ANFGI_FLAG_ESPOSIZ]='N' OR [ANFGI_FLAG_ESPOSIZ]='S'),
    CONSTRAINT [CK3_ANFGI_DATE_INIZ_FINE] CHECK ([ANFGI_DATA_FINE]>=[ANFGI_DATA_INIZ])
);

