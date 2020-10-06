CREATE TABLE [dbo].[st_aupgc_iscritte_casse_inpdap] (
    [aupgc_identificativo]         VARCHAR (10) NULL,
    [aupgc_progressivo]            VARCHAR (5)  NULL,
    [aupgc_cf]                     VARCHAR (16) NULL,
    [aupgc_cassa]                  VARCHAR (3)  NULL,
    [aupgc_data_inizio_iscrizione] DATETIME     NULL,
    [aupgc_data_fine_iscrizione]   DATETIME     NULL,
    [aupgc_tipo_iscr]              VARCHAR (1)  NULL,
    [aupgc_desc_tipo_iscr]         VARCHAR (20) NULL
);

