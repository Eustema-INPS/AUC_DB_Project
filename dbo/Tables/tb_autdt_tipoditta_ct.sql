CREATE TABLE [dbo].[tb_autdt_tipoditta_ct] (
    [autdt_codice_pk]         INT           IDENTITY (1, 1) NOT NULL,
    [autdt_codice]            VARCHAR (2)   NOT NULL,
    [autdt_descrizione]       VARCHAR (100) NULL,
    [autdt_descrizione_lunga] VARCHAR (300) NULL,
    [autdt_ordinamento]       INT           NULL,
    [autdt_data_modifica]     DATETIME      NULL,
    [autdt_descr_utente]      VARCHAR (50)  NULL,
    [autdt_codice_pk_db2]     INT           NULL,
    CONSTRAINT [PK_tb_autdt] PRIMARY KEY CLUSTERED ([autdt_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_autdt_autdt] UNIQUE NONCLUSTERED ([autdt_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

