CREATE TABLE [dbo].[TB_AUERE_ELENCO_REPORT] (
    [auere_codice_pk]        INT           NOT NULL,
    [auere_descrizione]      VARCHAR (100) NULL,
    [auere_flag_gestibile]   VARCHAR (1)   NULL,
    [auere_data_modifica]    DATETIME      NULL,
    [auere_descr_utente]     VARCHAR (50)  NULL,
    [auere_stored_procedure] VARCHAR (100) NULL
);

