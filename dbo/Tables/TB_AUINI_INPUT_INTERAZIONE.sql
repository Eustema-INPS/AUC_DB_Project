CREATE TABLE [dbo].[TB_AUINI_INPUT_INTERAZIONE] (
    [auini_codice_pk]        INT           NOT NULL,
    [auini_codice_input]     VARCHAR (1)   NULL,
    [auini_descrizione]      VARCHAR (100) NULL,
    [auini_tipo_interazione] VARCHAR (1)   NULL,
    [auini_data_modifica]    DATETIME      NULL,
    [auini_descr_utente]     VARCHAR (50)  NULL
);

