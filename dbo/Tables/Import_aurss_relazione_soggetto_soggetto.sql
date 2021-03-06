﻿CREATE TABLE [dbo].[Import_aurss_relazione_soggetto_soggetto] (
    [St_aurss_codice_pk]                  BIGINT        NULL,
    [St_aurss_ausca_codice_pk]            INT           NULL,
    [St_aurss_ausco_codice_pk]            INT           NULL,
    [St_aurss_autis_codice_pk]            INT           CONSTRAINT [DF_Import_aurss_relazione_soggetto_soggetto_St_aurss_autis_codice_pk] DEFAULT ((100)) NULL,
    [St_aurss_aussu_codice_pk]            INT           NULL,
    [St_Data_IscrizioneLibroSoci]         DATE          NULL,
    [St_aurss_data_di_fine_validità]      DATE          NULL,
    [St_aurss_data_Iscrizione]            DATE          NULL,
    [St_aurss_data_Nomina]                DATE          NULL,
    [St_aurss_data_FineCarica]            DATE          NULL,
    [St_aurss_data_AttoNomina]            DATE          NULL,
    [St_aurss_note]                       VARCHAR (200) NULL,
    [St_aurss_RappresentanteLegale]       VARCHAR (1)   CONSTRAINT [DF_Import_aurss_relazione_soggetto_soggetto_St_aurss_RappresentanteLegale] DEFAULT ('N') NULL,
    [St_aurss_CodicefiscaleAzienda]       VARCHAR (16)  NULL,
    [St_aurss_CodicefiscaleSoggetto]      VARCHAR (16)  NULL,
    [St_aurss_CodiceCarica]               VARCHAR (3)   NULL,
    [St_aurss_Carica]                     VARCHAR (50)  NULL,
    [St_aurss_ProgressivoCarica]          VARCHAR (4)   NULL,
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
    [St_aurss_RapprLegale_INFO]           VARCHAR (1)   CONSTRAINT [DF_Import_aurss_relazione_soggetto_soggetto_St_aurss_RapprLegale_INFO] DEFAULT ('N') NULL,
    [St_aurss_grado_RL]                   INT           CONSTRAINT [DF_Import_aurss_relazione_soggetto_soggetto_St_aurss_grado] DEFAULT ((0)) NULL,
    [St_aurss_Data_Inizio_Validita]       DATE          NULL,
    [st_aurss_prog_pers]                  VARCHAR (4)   NULL,
    [st_aurss_cap_agire]                  VARCHAR (2)   NULL,
    [st_aurss_flag_se_elettore]           VARCHAR (1)   NULL,
    [st_aurss_potere_firma]               VARCHAR (1)   NULL,
    [st_aurss_quote_partec]               VARCHAR (15)  NULL,
    [st_aurss_perce_partec]               VARCHAR (4)   NULL,
    [st_aurss_quote_partec_e]             VARCHAR (17)  NULL,
    [st_aurss_quota_c_valuta]             VARCHAR (3)   NULL,
    [st_aurss_cod_durata_carica]          VARCHAR (2)   NULL,
    [st_aurss_anni_ese_carica]            VARCHAR (2)   NULL,
    [st_aurss_data_pres_carica]           VARCHAR (8)   NULL
);

