CREATE TABLE [dbo].[tb_auref_rel_entita_funz] (
    [auref_codice_pk]            INT          IDENTITY (1, 1) NOT NULL,
    [auref_aufun_codice_pk]      INT          NULL,
    [auref_auten_codice_pk]      INT          NULL,
    [auref_codice_entita_rif]    INT          NULL,
    [auref_data_inizio_validita] DATETIME     NULL,
    [auref_data_fine_validita]   DATETIME     NULL,
    [auref_data_modifica]        DATETIME     NULL,
    [auref_descr_utente]         VARCHAR (50) NULL,
    [auref_codice_pk_db2]        INT          NULL,
    CONSTRAINT [PK_tb_auruf] PRIMARY KEY CLUSTERED ([auref_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_auruf_aufun] FOREIGN KEY ([auref_aufun_codice_pk]) REFERENCES [dbo].[tb_aufun_funz_sistema] ([aufun_codice_pk]),
    CONSTRAINT [UQ_auref_auref] UNIQUE NONCLUSTERED ([auref_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

