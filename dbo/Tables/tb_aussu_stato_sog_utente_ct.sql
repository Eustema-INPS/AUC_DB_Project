CREATE TABLE [dbo].[tb_aussu_stato_sog_utente_ct] (
    [aussu_codice_pk]     INT          IDENTITY (1, 1) NOT NULL,
    [aussu_descr]         VARCHAR (50) NULL,
    [aussu_ordinamento]   INT          NULL,
    [aussu_data_modifica] DATETIME     NULL,
    [aussu_descr_utente]  VARCHAR (50) NULL,
    [aussu_codice_pk_db2] INT          NULL,
    CONSTRAINT [PK_tb_aussu] PRIMARY KEY CLUSTERED ([aussu_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aussu_aussu] UNIQUE NONCLUSTERED ([aussu_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

