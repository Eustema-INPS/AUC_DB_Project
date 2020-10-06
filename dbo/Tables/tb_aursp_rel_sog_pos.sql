﻿CREATE TABLE [dbo].[tb_aursp_rel_sog_pos] (
    [aursp_codice_pk]             BIGINT        IDENTITY (1, 1) NOT NULL,
    [aursp_aupoc_codice_pk]       INT           NULL,
    [aursp_ausco_codice_pk]       INT           NULL,
    [aursp_aussu_codice_pk]       INT           NULL,
    [aursp_autis_codice_pk]       INT           NULL,
    [aursp_data_inizio_validita]  DATETIME      NULL,
    [aursp_data_di_fine_validita] DATETIME      NULL,
    [aursp_note]                  VARCHAR (200) NULL,
    [aursp_rappresentante_legale] VARCHAR (1)   NULL,
    [aursp_data_modifica]         DATETIME      NULL,
    [aursp_descr_utente]          VARCHAR (50)  NULL,
    [aursp_codice_pk_db2]         BIGINT        NULL,
    [aursp_rec_del]               VARCHAR (1)   NULL,
    [aursp_data_del]              DATETIME      NULL,
    [aursp_cert_auten_cod_pk]     INT           NULL,
    [aursp_cert_cod_entita_rif]   INT           NULL,
    [aursp_cert_data_modifica]    DATETIME      NULL,
    [aursp_auten_codice_pk]       INT           NULL,
    [aursp_codice_entita_rif]     INT           NULL,
    [aursp_tipo_soggetto]         VARCHAR (2)   NULL,
    [aursp_data_domanda]          DATETIME      NULL,
    [aursp_tipo_domanda]          VARCHAR (5)   NULL,
    CONSTRAINT [PK_tb_aursp] PRIMARY KEY CLUSTERED ([aursp_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_aursp_aupoc] FOREIGN KEY ([aursp_aupoc_codice_pk]) REFERENCES [dbo].[tb_aupoc_pos_contr] ([aupoc_codice_pk]),
    CONSTRAINT [FK_aursp_ausco] FOREIGN KEY ([aursp_ausco_codice_pk]) REFERENCES [dbo].[tb_ausco_sog_contr_col] ([ausco_codice_pk]),
    CONSTRAINT [FK_aursp_aussu] FOREIGN KEY ([aursp_aussu_codice_pk]) REFERENCES [dbo].[tb_aussu_stato_sog_utente_ct] ([aussu_codice_pk]),
    CONSTRAINT [FK_aursp_autis] FOREIGN KEY ([aursp_autis_codice_pk]) REFERENCES [dbo].[tb_autis_tipo_sog_col_ct] ([autis_codice_pk]),
    CONSTRAINT [UQ_aursp_aursp] UNIQUE NONCLUSTERED ([aursp_codice_pk] ASC) WITH (FILLFACTOR = 90)
);
