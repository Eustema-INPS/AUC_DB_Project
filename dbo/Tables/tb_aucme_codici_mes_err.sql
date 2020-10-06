CREATE TABLE [dbo].[tb_aucme_codici_mes_err] (
    [aucme_codice_pk]       INT           NOT NULL,
    [aucme_tipo_occorrenza] VARCHAR (1)   NULL,
    [aucme_descr_breve]     VARCHAR (50)  NULL,
    [aucme_descr_lunga]     VARCHAR (200) NULL,
    [aucme_data_modifica]   DATETIME      NULL,
    [aucme_descr_utente]    VARCHAR (50)  NULL,
    [aucme_codice_pk_db2]   INT           NULL,
    CONSTRAINT [PK_tb_aucme] PRIMARY KEY CLUSTERED ([aucme_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aucme_aucme] UNIQUE NONCLUSTERED ([aucme_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

