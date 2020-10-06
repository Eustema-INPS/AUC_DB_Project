CREATE TABLE [dbo].[tb_aupcs_periodo_contr_storico] (
    [aupcs_codice_pk]            BIGINT        IDENTITY (1, 1) NOT NULL,
    [aupcs_aupoc_codice_pk]      INT           NULL,
    [aupcs_data_modifica]        DATETIME      NULL,
    [aupcs_data_inizio_validita] DATETIME      NULL,
    [aupcs_data_fine_validita]   DATETIME      NULL,
    [aupcs_data_scad_autor]      DATETIME      NULL,
    [aupcs_giorni_proroga]       INT           NULL,
    [aupcs_cod_stat_contr]       VARCHAR (5)   NULL,
    [aupcs_codici_autor]         VARCHAR (60)  NULL,
    [aupcs_lavoratori_autonomi]  INT           NULL,
    [aupcs_inserimento]          VARCHAR (50)  NULL,
    [aupcs_ateco_91]             VARCHAR (100) NULL,
    [aupcs_auate_1991_codice_pk] INT           NULL,
    [aupcs_auate_2002_codice_pk] INT           NULL,
    [aupcs_auate_2007_codice_pk] INT           NULL,
    [aupcs_descr_utente]         VARCHAR (50)  NULL,
    CONSTRAINT [PK_tb_aupcs] PRIMARY KEY CLUSTERED ([aupcs_codice_pk] ASC),
    CONSTRAINT [FK_aupcs_aupoc] FOREIGN KEY ([aupcs_aupoc_codice_pk]) REFERENCES [dbo].[tb_aupoc_pos_contr] ([aupoc_codice_pk]),
    CONSTRAINT [UQ_aupcs_aupcs] UNIQUE NONCLUSTERED ([aupcs_codice_pk] ASC)
);

