﻿CREATE TABLE [dbo].[tb_INFO_Scarti_AURSS] (
    [St_aurss_codice_pk]                  BIGINT        NULL,
    [St_aurss_ausca_codice_pk]            INT           NULL,
    [St_aurss_ausco_codice_pk]            INT           NULL,
    [St_aurss_autis_codice_pk]            INT           NULL,
    [St_aurss_aussu_codice_pk]            INT           NULL,
    [St_Data_IscrizioneLibroSoci]         DATE          NULL,
    [St_aurss_data_di_fine_validità]      DATE          NULL,
    [St_aurss_data_Iscrizione]            DATE          NULL,
    [St_aurss_data_Nomina]                DATE          NULL,
    [St_aurss_data_FineCarica]            DATE          NULL,
    [St_aurss_data_AttoNomina]            DATE          NULL,
    [St_aurss_note]                       VARCHAR (200) NULL,
    [St_aurss_RappresentanteLegale]       VARCHAR (1)   NULL,
    [St_aurss_CodicefiscaleAzienda]       VARCHAR (16)  NULL,
    [St_aurss_CodicefiscaleSoggetto]      VARCHAR (16)  NULL,
    [St_aurss_CodiceCarica]               VARCHAR (3)   NULL,
    [St_aurss_Carica]                     VARCHAR (50)  NULL,
    [St_aurss_ProgressivoCarica]          VARCHAR (999) NULL,
    [St_aurss_Filename]                   VARCHAR (999) NULL,
    [St_aurss_data_domandafile]           VARCHAR (999) NULL,
    [St_aurss_TipologiaFile]              VARCHAR (999) NULL,
    [St_aurss_MatricolaGestioneAziende]   VARCHAR (999) NULL,
    [St_aurss_NomeFileVisuraOriginale]    VARCHAR (999) NULL,
    [St_aurss_NomeOriginale_Prov1]        VARCHAR (999) NULL,
    [St_aurss_NomeOriginale_Anno]         VARCHAR (999) NULL,
    [St_aurss_NomeOriginale_Progressivo1] VARCHAR (999) NULL,
    [St_aurss_NomeOriginale_Visura]       VARCHAR (999) NULL,
    [St_aurss_NomeOriginale_Prov2]        VARCHAR (999) NULL,
    [St_aurss_NomeOriginale_NumREA]       VARCHAR (999) NULL,
    [St_aurss_FLAG]                       TINYINT       NULL,
    [St_aurss_PRESENTE]                   CHAR (1)      NULL,
    [St_aurss_data_modifica]              DATETIME      NULL,
    [St_aurss_descr_utente]               VARCHAR (50)  NULL,
    [ErrorNum]                            VARCHAR (MAX) NULL,
    [ErrorDescription]                    VARCHAR (MAX) NULL
);

