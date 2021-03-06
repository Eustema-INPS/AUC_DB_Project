﻿CREATE TABLE [dbo].[tb_INFO_Scarti_AUCON] (
    [aucon_codice_pk]                 BIGINT        NULL,
    [aucon_ausca_codice_pk]           INT           NULL,
    [aucon_f_presenza_info]           VARCHAR (1)   NULL,
    [aucon_codice_fiscale]            VARCHAR (16)  NULL,
    [aucon_data_iscrizione]           DATE          NULL,
    [aucon_tribunale]                 VARCHAR (100) NULL,
    [aucon_num_registrazione]         VARCHAR (20)  NULL,
    [aucon_data_registrazione]        DATE          NULL,
    [aucon_localita_uff_registro]     VARCHAR (50)  NULL,
    [aucon_prov_uff_registro]         VARCHAR (2)   NULL,
    [aucon_cciaa_fuori_provincia]     VARCHAR (2)   NULL,
    [aucon_codice_liquidazione]       VARCHAR (5)   NULL,
    [aucon_descr_liquidazione]        VARCHAR (50)  NULL,
    [aucon_data_iscrizione_procedura] DATE          NULL,
    [aucon_codice_atto]               VARCHAR (5)   NULL,
    [aucon_descrizione_atto]          VARCHAR (50)  NULL,
    [aucon_FLAG]                      TINYINT       NULL,
    [aucon_PRESENTE]                  CHAR (1)      NULL,
    [aucon_data_modifica]             DATETIME      NULL,
    [aucon_descr_utente]              VARCHAR (50)  NULL,
    [ErrorNum]                        VARCHAR (MAX) NULL,
    [ErrorDescription]                VARCHAR (MAX) NULL
);

