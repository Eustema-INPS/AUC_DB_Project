CREATE TABLE [dbo].[tb_auece_ente_cert] (
    [auece_codice_pk]       INT           IDENTITY (1, 1) NOT NULL,
    [auece_descr]           VARCHAR (50)  NULL,
    [auece_note]            VARCHAR (200) NULL,
    [auece_data_modifica]   DATETIME      NULL,
    [auece_descr_utente]    VARCHAR (50)  NULL,
    [auece_codice_pk_db2]   INT           NULL,
    [auece_aurea_codice_pk] INT           NULL,
    CONSTRAINT [PK_tb_auece] PRIMARY KEY CLUSTERED ([auece_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_auece_auece] UNIQUE NONCLUSTERED ([auece_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

