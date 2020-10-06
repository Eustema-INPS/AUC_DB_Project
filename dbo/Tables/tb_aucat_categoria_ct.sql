CREATE TABLE [dbo].[tb_aucat_categoria_ct] (
    [aucat_codice_pk]     INT           IDENTITY (1, 1) NOT NULL,
    [aucat_descr]         VARCHAR (100) NULL,
    [aucat_data_modifica] DATETIME      NULL,
    [aucat_descr_utente]  VARCHAR (50)  NULL,
    [aucat_codice_pk_db2] INT           NULL,
    [aucat_codice]        VARCHAR (3)   NULL,
    CONSTRAINT [PK_tb_aucat] PRIMARY KEY CLUSTERED ([aucat_codice_pk] ASC),
    CONSTRAINT [UQ_aucat_aucat] UNIQUE NONCLUSTERED ([aucat_codice_pk] ASC)
);

