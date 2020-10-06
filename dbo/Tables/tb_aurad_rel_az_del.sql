CREATE TABLE [dbo].[tb_aurad_rel_az_del] (
    [aurad_codice_pk]            INT           IDENTITY (1, 1) NOT NULL,
    [aurad_aupoc_codice_pk]      INT           NULL,
    [aurad_audel_codice_pk]      INT           NULL,
    [aurad_autid_codice_pk]      INT           NULL,
    [aurad_aussu_codice_pk]      INT           NULL,
    [aurad_data_inizio_validita] DATETIME      NULL,
    [aurad_data_fine_validita]   DATETIME      NULL,
    [aurad_note]                 VARCHAR (200) NULL,
    [aurad_flag_operativo]       INT           NULL,
    [aurad_data_modifica]        DATETIME      NULL,
    [aurad_descr_utente]         VARCHAR (50)  NULL,
    [aurad_codice_pk_db2]        INT           NULL,
    CONSTRAINT [PK_tb_aurad] PRIMARY KEY CLUSTERED ([aurad_codice_pk] ASC),
    CONSTRAINT [FK_aurad_aupoc] FOREIGN KEY ([aurad_aupoc_codice_pk]) REFERENCES [dbo].[tb_aupoc_pos_contr] ([aupoc_codice_pk]),
    CONSTRAINT [FK_aurad_aussu] FOREIGN KEY ([aurad_aussu_codice_pk]) REFERENCES [dbo].[tb_aussu_stato_sog_utente_ct] ([aussu_codice_pk]),
    CONSTRAINT [UQ_aurad_aurad] UNIQUE NONCLUSTERED ([aurad_codice_pk] ASC)
);

