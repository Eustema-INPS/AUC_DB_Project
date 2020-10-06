CREATE TABLE [dbo].[tb_auute_ute_sistema] (
    [auute_codice_pk]            INT           IDENTITY (1, 1) NOT NULL,
    [auute_aussu_codice_pk]      INT           NULL,
    [auute_auruo_codice_pk]      INT           NULL,
    [auute_cognome]              VARCHAR (50)  NULL,
    [auute_nome]                 VARCHAR (50)  NULL,
    [auute_data_inizio_validita] DATETIME      NULL,
    [auute_data_fine_validita]   DATETIME      NULL,
    [auute_note]                 VARCHAR (200) NULL,
    [auute_utenza]               VARCHAR (50)  NULL,
    [auute_flag_abilitato]       VARCHAR (1)   NULL,
    [auute_data_modifica]        DATETIME      NULL,
    [auute_descr_utente]         VARCHAR (50)  NULL,
    [auute_codice_pk_db2]        INT           NULL,
    [auute_area_utente]          VARCHAR (10)  NULL,
    CONSTRAINT [PK_tb_auute] PRIMARY KEY CLUSTERED ([auute_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_auute_auruo] FOREIGN KEY ([auute_auruo_codice_pk]) REFERENCES [dbo].[tb_auruo_ruolo] ([auruo_codice_pk]),
    CONSTRAINT [FK_auute_aussu] FOREIGN KEY ([auute_aussu_codice_pk]) REFERENCES [dbo].[tb_aussu_stato_sog_utente_ct] ([aussu_codice_pk]),
    CONSTRAINT [UQ_auute_auute] UNIQUE NONCLUSTERED ([auute_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

