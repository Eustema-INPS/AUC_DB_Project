﻿CREATE TABLE [dbo].[tb_aupco_periodo_contr] (
    [aupco_codice_pk]            BIGINT        IDENTITY (1, 1) NOT NULL,
    [aupco_aupoc_codice_pk]      INT           NULL,
    [aupco_auate_codice_pk]      INT           NULL,
    [aupco_data_inizio_validita] DATETIME      NULL,
    [aupco_data_fine_validita]   DATETIME      NULL,
    [aupco_data_scad_autor]      DATETIME      NULL,
    [aupco_giorni_proroga]       INT           NULL,
    [aupco_cod_stat_contr]       VARCHAR (5)   NULL,
    [aupco_codici_autor]         VARCHAR (60)  NULL,
    [aupco_lavoratori_autonomi]  INT           NULL,
    [aupco_inserimento]          VARCHAR (50)  NULL,
    [aupco_ateco_91]             VARCHAR (100) NULL,
    [aupco_flag_operativo]       INT           NULL,
    [aupco_aucsc_codice_pk]      INT           NULL,
    [aupco_data_modifica]        DATETIME      NULL,
    [aupco_descr_utente]         VARCHAR (50)  NULL,
    [aupco_codice_pk_db2]        BIGINT        NULL,
    [aupco_auate_1991_codice_pk] INT           NULL,
    [aupco_auate_2002_codice_pk] INT           NULL,
    [aupco_auate_2007_codice_pk] INT           NULL,
    [aupco_rec_del]              VARCHAR (1)   NULL,
    [aupco_data_del]             DATETIME      NULL,
    CONSTRAINT [PK_tb_aupco] PRIMARY KEY CLUSTERED ([aupco_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_aupco_aucsc] FOREIGN KEY ([aupco_aucsc_codice_pk]) REFERENCES [dbo].[tb_aucsc_cod_stat_contr_ct] ([aucsc_codice_pk]),
    CONSTRAINT [FK_aupco_aupoc] FOREIGN KEY ([aupco_aupoc_codice_pk]) REFERENCES [dbo].[tb_aupoc_pos_contr] ([aupoc_codice_pk]),
    CONSTRAINT [UQ_aupco_aupco] UNIQUE NONCLUSTERED ([aupco_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

