﻿CREATE TABLE [dbo].[BDSU_SEDEUFFI_CT] (
    [BDSU_ID_VA]       BIGINT       NOT NULL,
    [BDSU_CODICE_VB]   VARCHAR (15) NULL,
    [BDSU_DESCRIZ_VB]  VARCHAR (60) NULL,
    [BDSU_PROV_VB]     VARCHAR (2)  NULL,
    [BDSU_UNIORG_VB]   VARCHAR (3)  NULL,
    [BDSU_MODREC_VB]   DATE         NULL,
    [BDSU_BDSU_EDI_VR] BIGINT       NULL,
    [BDSU_INDIRIZ_VB]  VARCHAR (60) NULL,
    [BDSU_CAP_VB]      VARCHAR (5)  NULL,
    [BDSU_COMUNE_VB]   VARCHAR (45) NULL,
    [BDSU_DATAINI_VB]  DATE         NOT NULL,
    [BDSU_DATAFIN_VB]  DATE         NULL,
    [BDSU_NSI_VB]      VARCHAR (1)  NOT NULL,
    [BDSU_BDUF_ERI_VR] BIGINT       NULL,
    [BDSU_TELEF_VB]    VARCHAR (26) NULL,
    [BDSU_FAX_VB]      VARCHAR (26) NULL,
    CONSTRAINT [PK_BDSU_SEDEUFFI_CT] PRIMARY KEY CLUSTERED ([BDSU_ID_VA] ASC)
);

