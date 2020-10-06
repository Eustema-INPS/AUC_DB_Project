CREATE TABLE [dbo].[tb_auapp_appl] (
    [auapp_codice_pk]               INT           IDENTITY (1, 1) NOT NULL,
    [auapp_descr]                   VARCHAR (50)  NULL,
    [auapp_aussu_codice_pk]         INT           NULL,
    [auapp_app_name]                VARCHAR (50)  NULL,
    [auapp_data_inizio_operativita] DATETIME      NULL,
    [auapp_data_fine_operativita]   DATETIME      NULL,
    [auapp_flag_abilitato]          VARCHAR (1)   NULL,
    [auapp_flag_internet]           INT           NULL,
    [auapp_note]                    VARCHAR (200) NULL,
    [auapp_data_modifica]           DATETIME      NULL,
    [auapp_descr_utente]            VARCHAR (50)  NULL,
    [auapp_modalita_gestione]       VARCHAR (5)   NULL,
    [auapp_codice_pk_db2]           INT           NULL,
    [auapp_area_applicazione]       VARCHAR (10)  NULL,
    [auapp_aurea_codice_pk]         INT           NULL,
    CONSTRAINT [PK_tb_auapp] PRIMARY KEY CLUSTERED ([auapp_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_auapp_aussu] FOREIGN KEY ([auapp_aussu_codice_pk]) REFERENCES [dbo].[tb_aussu_stato_sog_utente_ct] ([aussu_codice_pk]),
    CONSTRAINT [UQ_auapp_auapp] UNIQUE NONCLUSTERED ([auapp_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

