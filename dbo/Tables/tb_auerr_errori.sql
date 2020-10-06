CREATE TABLE [dbo].[tb_auerr_errori] (
    [auerr_codice_pk]       INT           IDENTITY (1, 1) NOT NULL,
    [auerr_aucme_codice_pk] INT           NULL,
    [auerr_tipo_contesto]   VARCHAR (1)   NULL,
    [auerr_attore]          VARCHAR (50)  NULL,
    [auerr_data_errore]     DATETIME      NULL,
    [auerr_descr_breve]     VARCHAR (50)  NULL,
    [auerr_descr_lunga]     VARCHAR (200) NULL,
    [auerr_data_modifica]   DATETIME      NULL,
    [auerr_descr_utente]    VARCHAR (50)  NULL,
    [auerr_codice_pk_db2]   INT           NULL,
    CONSTRAINT [PK_tb_auerr] PRIMARY KEY CLUSTERED ([auerr_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_auerr_aucme] FOREIGN KEY ([auerr_aucme_codice_pk]) REFERENCES [dbo].[tb_aucme_codici_mes_err] ([aucme_codice_pk]),
    CONSTRAINT [UQ_auerr_auerr] UNIQUE NONCLUSTERED ([auerr_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

