﻿CREATE TABLE [dbo].[TB_ANPGC_PERSGIUCAP_CL] (
    [ANPGC_BDSO_ID_VA_PK] BIGINT       NOT NULL,
    [ANPGC_BDCP_ID_VA_PK] BIGINT       NOT NULL,
    [ANPGC_DATA_INIZ_PK]  DATE         NOT NULL,
    [ANPGC_DATA_FINE]     DATE         CONSTRAINT [DF_TB_ANPGC_PERSGIUCAP_CL_ANPGC_DATA_FINE] DEFAULT (CONVERT([date],'9999-12-31')) NOT NULL,
    [ANPGC_FLAG_TIPOPG]   CHAR (1)     NOT NULL,
    [ANPGC_COD_UTENTE]    VARCHAR (16) NOT NULL,
    [ANPGC_DATA_AGGIORN]  DATE         DEFAULT (getdate()) NOT NULL,
    [ANPGC_COD_APPL]      VARCHAR (2)  NOT NULL,
    [ANPGC_DATA_SISTEMA]  DATE         NULL,
    CONSTRAINT [PK_ANPGC_PERSGIUCAP] PRIMARY KEY CLUSTERED ([ANPGC_BDSO_ID_VA_PK] ASC, [ANPGC_BDCP_ID_VA_PK] ASC, [ANPGC_DATA_INIZ_PK] ASC),
    CONSTRAINT [CK1_ANPGC_DATE_INIZ_FINE] CHECK ([ANPGC_DATA_FINE]>=[ANPGC_DATA_INIZ_PK])
);

