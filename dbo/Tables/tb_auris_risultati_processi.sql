CREATE TABLE [dbo].[tb_auris_risultati_processi] (
    [auris_codice_pk]       INT           IDENTITY (1, 1) NOT NULL,
    [auris_auese_codice_pk] INT           NULL,
    [auris_tipo_risultato]  INT           NULL,
    [auris_nome_file]       VARCHAR (200) NULL,
    [auris_data_modifica]   DATETIME      NULL,
    [auris_descr_utente]    VARCHAR (50)  NULL,
    [auris_codice_pk_db2]   INT           NULL,
    CONSTRAINT [PK_tb_auris] PRIMARY KEY CLUSTERED ([auris_codice_pk] ASC),
    CONSTRAINT [FK_auris_auese] FOREIGN KEY ([auris_auese_codice_pk]) REFERENCES [dbo].[tb_auese_esec_processo] ([auese_codice_pk]),
    CONSTRAINT [UQ_auris_auris] UNIQUE NONCLUSTERED ([auris_codice_pk] ASC)
);

