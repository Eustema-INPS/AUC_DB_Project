﻿CREATE TABLE [dbo].[BDPI_TIPOISCR_CT] (
    [BDPI_ID_VA]       BIGINT       NOT NULL,
    [BDPI_CODTISCR_VB] VARCHAR (3)  NULL,
    [BDPI_DESCRTI_VB]  VARCHAR (30) NULL,
    [BDPI_MODREC_VB]   DATE         NULL,
    [BDPI_DATAINI_VB]  DATE         CONSTRAINT [DF_BDPI_TIPOISCR_CT_BDPI_DATAINI_VB] DEFAULT (CONVERT([date],'9999-12-31')) NOT NULL,
    [BDPI_DATAFIN_VB]  DATE         NULL,
    [BDPI_NSI_VB]      VARCHAR (1)  NOT NULL,
    CONSTRAINT [PK_BDPI_TIPOISCR_CT] PRIMARY KEY CLUSTERED ([BDPI_ID_VA] ASC),
    CONSTRAINT [BDPI_NSI_CK] CHECK ([BDPI_NSI_VB]='N' OR [BDPI_NSI_VB]='S')
);

