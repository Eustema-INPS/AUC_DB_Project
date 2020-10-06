CREATE TABLE [dbo].[tb_aurea_area_gestione] (
    [aurea_codice_pk]     INT          IDENTITY (1, 1) NOT NULL,
    [aurea_descrizione]   VARCHAR (50) NULL,
    [aurea_codice_pk_db2] INT          NULL,
    [aurea_data_modifica] DATETIME     NULL,
    [aurea_descr_utente]  VARCHAR (50) NULL,
    CONSTRAINT [PK_tb_aurea] PRIMARY KEY CLUSTERED ([aurea_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_tb_aurea_aurea] UNIQUE NONCLUSTERED ([aurea_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

