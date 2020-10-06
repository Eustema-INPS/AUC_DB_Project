CREATE TABLE [dbo].[tb_aulog_log] (
    [aulog_codice_pk]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [aulog_aucme_codice_pk] INT           NULL,
    [aulog_tipo_contesto]   VARCHAR (1)   NULL,
    [aulog_nome_attore]     VARCHAR (50)  NULL,
    [aulog_data_log]        DATETIME      NULL,
    [aulog_descr_breve]     VARCHAR (50)  NULL,
    [aulog_descr_lunga]     VARCHAR (200) NULL,
    [aulog_data_modifica]   DATETIME      NULL,
    [aulog_descr_utente]    VARCHAR (50)  NULL,
    [aulog_codice_pk_db2]   INT           NULL,
    [AULOG_DESCRMAX]        VARCHAR (800) NULL,
    CONSTRAINT [PK_tb_aulog] PRIMARY KEY CLUSTERED ([aulog_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aulog_aulog] UNIQUE NONCLUSTERED ([aulog_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

