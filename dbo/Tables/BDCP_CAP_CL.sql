﻿CREATE TABLE [dbo].[BDCP_CAP_CL] (
    [BDCP_ID_VA]       BIGINT      NOT NULL,
    [BDCP_CAP_VB]      VARCHAR (5) NOT NULL,
    [BDCP_DATAFINE_VB] DATE        NULL,
    [BDCP_DATAINI_VB]  DATE        NOT NULL,
    [BDCP_PROV_VB]     VARCHAR (2) NULL,
    [BDCP_MODREC_VB]   DATE        NULL,
    CONSTRAINT [PK_BDCP_CAP_CL] PRIMARY KEY CLUSTERED ([BDCP_ID_VA] ASC)
);

