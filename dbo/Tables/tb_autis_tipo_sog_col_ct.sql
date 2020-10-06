CREATE TABLE [dbo].[tb_autis_tipo_sog_col_ct] (
    [autis_codice_pk]     INT          IDENTITY (1, 1) NOT NULL,
    [autis_codice_carica] VARCHAR (3)  NULL,
    [autis_descr]         VARCHAR (50) NULL,
    [autis_ordinamento]   INT          NULL,
    [autis_data_modifica] DATETIME     NULL,
    [autis_descr_utente]  VARCHAR (50) NULL,
    [autis_codice_pk_db2] INT          NULL,
    [autis_grado_RL]      INT          NULL,
    CONSTRAINT [PK_tb_autis] PRIMARY KEY CLUSTERED ([autis_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_autis_autis] UNIQUE NONCLUSTERED ([autis_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

