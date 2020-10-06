CREATE TABLE [dbo].[Import_aufus_fusioni_scissioni] (
    [aufus_codice_pk]            BIGINT        NULL,
    [aufus_ausca_codice_pk]      INT           NULL,
    [aufus_prog_fusione]         INT           NULL,
    [aufus_c_tipo]               VARCHAR (5)   NULL,
    [aufus_tipo]                 VARCHAR (50)  NULL,
    [aufus_c_approvazione]       VARCHAR (5)   NULL,
    [aufus_approvazione]         VARCHAR (50)  NULL,
    [aufus_c_evento]             VARCHAR (5)   NULL,
    [aufus_evento]               VARCHAR (255) NULL,
    [aufus_data_iscrizione]      DATE          NULL,
    [aufus_data_mod_evento]      DATE          NULL,
    [aufus_data_delibera]        DATE          NULL,
    [aufus_data_atto_esecuzione] DATE          NULL,
    [aufus_data_atto]            DATE          NULL,
    [aufus_codice_fiscale_AUSCA] VARCHAR (16)  NULL,
    [aufus_FLAG]                 TINYINT       NULL,
    [aufus_PRESENTE]             CHAR (1)      NULL,
    [aufus_data_modifica]        DATETIME      NULL,
    [aufus_descr_utente]         VARCHAR (50)  NULL
);

