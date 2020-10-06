CREATE TABLE [dbo].[tb_aucau_cod_autor_ct] (
    [aucau_codice_pk]     INT           IDENTITY (1, 1) NOT NULL,
    [aucau_codice]        VARCHAR (2)   NULL,
    [aucau_data_inizio]   DATETIME      NULL,
    [aucau_data_fine]     DATETIME      NULL,
    [aucau_descrizione]   VARCHAR (255) NULL,
    [aucau_data_modifica] DATETIME      NULL,
    [aucau_descr_utente]  VARCHAR (50)  NULL,
    [aucau_codice_pk_db2] INT           NULL,
    [aucau_rec_del]       VARCHAR (1)   NULL,
    [aucau_data_del]      DATETIME      NULL,
    CONSTRAINT [PK_tb_aucau] PRIMARY KEY CLUSTERED ([aucau_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aucau_aucau] UNIQUE NONCLUSTERED ([aucau_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

