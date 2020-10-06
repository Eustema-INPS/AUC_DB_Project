CREATE TABLE [dbo].[tb_aucsc_cod_stat_contr_ct] (
    [aucsc_codice_pk]     INT          IDENTITY (1, 1) NOT NULL,
    [aucsc_codice]        VARCHAR (5)  NULL,
    [aucsc_settore]       VARCHAR (80) NULL,
    [aucsc_classe]        VARCHAR (80) NULL,
    [aucsc_categoria]     VARCHAR (80) NULL,
    [aucsc_data_modifica] DATETIME     NULL,
    [aucsc_descr_utente]  VARCHAR (50) NULL,
    [aucsc_codice_pk_db2] INT          NULL,
    CONSTRAINT [PK_tb_aucsc] PRIMARY KEY CLUSTERED ([aucsc_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aucsc_aucsc] UNIQUE NONCLUSTERED ([aucsc_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

