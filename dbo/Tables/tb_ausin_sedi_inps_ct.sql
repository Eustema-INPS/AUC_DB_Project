CREATE TABLE [dbo].[tb_ausin_sedi_inps_ct] (
    [ausin_codice_pk]           INT           IDENTITY (1, 1) NOT NULL,
    [ausin_codice_sede]         VARCHAR (4)   NULL,
    [ausin_descr]               VARCHAR (30)  NULL,
    [ausin_codice_regione]      VARCHAR (2)   NULL,
    [ausin_descrizione_regione] VARCHAR (100) NULL,
    [ausin_ordinamento]         INT           NULL,
    [ausin_data_modifica]       DATETIME      NULL,
    [ausin_descr_utente]        VARCHAR (50)  NULL,
    [ausin_codice_pk_db2]       INT           NULL,
    CONSTRAINT [PK_tb_ausin] PRIMARY KEY CLUSTERED ([ausin_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_tb_ausin] UNIQUE NONCLUSTERED ([ausin_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

