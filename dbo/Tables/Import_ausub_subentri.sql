CREATE TABLE [dbo].[Import_ausub_subentri] (
    [ausub_codice_pk]            BIGINT        NULL,
    [ausub_ausca_codice_pk]      INT           NULL,
    [ausub_c_tipo]               VARCHAR (5)   NULL,
    [ausub_tipo]                 VARCHAR (100) NULL,
    [ausub_denominazione]        VARCHAR (455) NULL,
    [ausub_codice_fiscale]       VARCHAR (16)  NULL,
    [ausub_c_titolo]             VARCHAR (5)   NULL,
    [ausub_titolo]               VARCHAR (255) NULL,
    [ausub_codice_fiscale_AUSCA] VARCHAR (16)  NULL,
    [ausub_FLAG]                 TINYINT       NULL,
    [ausub_PRESENTE]             CHAR (1)      NULL,
    [ausub_data_modifica]        DATETIME      NULL,
    [ausub_descr_utente]         VARCHAR (50)  NULL
);

