CREATE TABLE [dbo].[tb_autid_tipo_del_ct] (
    [autid_codice_pk]     INT          IDENTITY (1, 1) NOT NULL,
    [autid_tipo_delegato] VARCHAR (50) NULL,
    [autid_descr]         VARCHAR (50) NULL,
    [autid_ordinamento]   INT          NULL,
    [autid_data_modifica] DATETIME     NULL,
    [autid_descr_utente]  VARCHAR (50) NULL,
    [autid_codice_pk_db2] INT          NULL,
    CONSTRAINT [PK_tb_autid] PRIMARY KEY CLUSTERED ([autid_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_autid_autid] UNIQUE NONCLUSTERED ([autid_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

