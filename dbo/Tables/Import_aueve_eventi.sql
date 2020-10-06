CREATE TABLE [dbo].[Import_aueve_eventi] (
    [aueve_codice_pk]            BIGINT        NULL,
    [aueve_aufus_codice_pk]      BIGINT        NULL,
    [aueve_prog_societa]         INT           NULL,
    [aueve_ausca_codice_pk]      INT           NULL,
    [aueve_denominazione]        VARCHAR (455) NULL,
    [aueve_comune]               VARCHAR (255) NULL,
    [aueve_codice_fiscale]       VARCHAR (16)  NULL,
    [aueve_cciaa]                VARCHAR (2)   NULL,
    [aueve_n_rea]                VARCHAR (20)  NULL,
    [aueve_codice_fiscale_AUSCA] VARCHAR (16)  NULL,
    [aueve_aufus_prog_fusione]   INT           NULL,
    [aueve_FLAG]                 TINYINT       NULL,
    [aueve_PRESENTE]             CHAR (1)      NULL,
    [aueve_data_modifica]        DATETIME      NULL,
    [aueve_descr_utente]         VARCHAR (50)  NULL
);

