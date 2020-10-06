CREATE TABLE [dbo].[TB_AUREP_REPORT] (
    [aurep_codice_pk]          INT           NOT NULL,
    [aurep_descrizione]        VARCHAR (100) NULL,
    [aurep_codice_input]       VARCHAR (1)   NULL,
    [aurep_flag_selezionabile] VARCHAR (1)   NULL,
    [aurep_data_modifica]      DATETIME      NULL,
    [aurep_descr_utente]       VARCHAR (50)  NULL,
    CONSTRAINT [PK_TB_AUREP_REPORT] PRIMARY KEY CLUSTERED ([aurep_codice_pk] ASC)
);

