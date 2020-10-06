CREATE TABLE [dbo].[tb_aulog_log_storico_20190515] (
    [aulog_codice_pk]       BIGINT        NULL,
    [aulog_aucme_codice_pk] INT           NULL,
    [aulog_tipo_contesto]   VARCHAR (1)   NULL,
    [aulog_nome_attore]     VARCHAR (50)  NULL,
    [aulog_data_log]        DATETIME      NULL,
    [aulog_descr_breve]     VARCHAR (50)  NULL,
    [aulog_descr_lunga]     VARCHAR (200) NULL,
    [aulog_data_modifica]   DATETIME      NULL,
    [aulog_descr_utente]    VARCHAR (50)  NULL,
    [aulog_codice_pk_db2]   INT           NULL,
    [AULOG_DESCRMAX]        VARCHAR (800) NULL
);

