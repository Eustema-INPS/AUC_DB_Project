CREATE TABLE [dbo].[tb_auruo_ruolo] (
    [auruo_codice_pk]     INT           NOT NULL,
    [auruo_descr]         VARCHAR (50)  NULL,
    [auruo_note]          VARCHAR (200) NULL,
    [auruo_data_modifica] DATETIME      NULL,
    [auruo_descr_utente]  VARCHAR (50)  NULL,
    [auruo_codice_pk_db2] INT           NULL,
    CONSTRAINT [PK_tb_auruo] PRIMARY KEY CLUSTERED ([auruo_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_auruo_auruo] UNIQUE NONCLUSTERED ([auruo_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

