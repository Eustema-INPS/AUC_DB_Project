CREATE TABLE [dbo].[tb_autia_tipo_accentr_ct] (
    [autia_codice_pk]     INT           IDENTITY (1, 1) NOT NULL,
    [autia_codice]        VARCHAR (2)   NOT NULL,
    [autia_descrizione]   VARCHAR (200) NULL,
    [autia_ordinamento]   INT           NULL,
    [autia_data_modifica] DATETIME      NULL,
    [autia_descr_utente]  VARCHAR (50)  NULL,
    [autia_codice_pk_db2] INT           NULL,
    CONSTRAINT [PK_tb_autia] PRIMARY KEY CLUSTERED ([autia_codice_pk] ASC, [autia_codice] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_autia_autia] UNIQUE NONCLUSTERED ([autia_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

