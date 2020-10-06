CREATE TABLE [dbo].[tb_auten_tipo_entita_ct] (
    [auten_codice_pk]     INT          IDENTITY (1, 1) NOT NULL,
    [auten_descr]         VARCHAR (50) NULL,
    [auten_ordinamento]   INT          NULL,
    [auten_data_modifica] DATETIME     NULL,
    [auten_descr_utente]  VARCHAR (50) NULL,
    [auten_codice_pk_db2] INT          NULL,
    CONSTRAINT [PK_tb_auten] PRIMARY KEY CLUSTERED ([auten_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_auten_auten] UNIQUE NONCLUSTERED ([auten_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

