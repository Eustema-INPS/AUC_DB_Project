CREATE TABLE [dbo].[tb_auese_esec_processo] (
    [auese_codice_pk]       INT          IDENTITY (1, 1) NOT NULL,
    [auese_aupro_codice_pk] INT          NULL,
    [auese_data_esecuzione] DATETIME     NULL,
    [auese_esito]           INT          NULL,
    [auese_data_modifica]   DATETIME     NULL,
    [auese_descr_utente]    VARCHAR (50) NULL,
    [auese_codice_pk_db2]   INT          NULL,
    CONSTRAINT [PK_tb_auese] PRIMARY KEY CLUSTERED ([auese_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_auese_aupro] FOREIGN KEY ([auese_aupro_codice_pk]) REFERENCES [dbo].[tb_aupro_processi_batch] ([aupro_codice_pk]),
    CONSTRAINT [UQ_auese_auese] UNIQUE NONCLUSTERED ([auese_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

