CREATE TABLE [dbo].[tb_auraz_report_azst] (
    [auraz_codice_pk]              BIGINT        IDENTITY (1, 1) NOT NULL,
    [auraz_codice_modello]         VARCHAR (10)  NULL,
    [auraz_guid_trasmissione]      VARCHAR (50)  NULL,
    [auraz_azregion]               INT           NULL,
    [auraz_azstapro]               INT           NULL,
    [auraz_azstazon]               INT           NULL,
    [auraz_gi]                     INT           NULL,
    [auraz_perv1]                  INT           NULL,
    [auraz_perv2]                  INT           NULL,
    [auraz_defa]                   INT           NULL,
    [auraz_defr1]                  INT           NULL,
    [auraz_defr2]                  INT           NULL,
    [auraz_data_modifica]          DATETIME      CONSTRAINT [DF_tb_auraz_report_azst_auraz_data_modifica2] DEFAULT (getdate()) NULL,
    [auraz_descr_utente]           VARCHAR (50)  NULL,
    [Auraz_stato]                  INT           CONSTRAINT [DF_tb_auraz_report_azst_Auraz_stato2] DEFAULT ((0)) NULL,
    [Auraz_esito_elab_codice]      VARCHAR (10)  NULL,
    [Auraz_esito_elab_descrizione] VARCHAR (MAX) NULL,
    [Auraz_data_inizio]            DATE          NULL,
    [Auraz_data_fine]              DATE          NULL,
    CONSTRAINT [PK_tb_auraz2] PRIMARY KEY CLUSTERED ([auraz_codice_pk] ASC),
    CONSTRAINT [UQ_auraz_auraz2] UNIQUE NONCLUSTERED ([auraz_codice_pk] ASC)
);

