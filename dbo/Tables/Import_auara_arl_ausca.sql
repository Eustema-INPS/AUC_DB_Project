CREATE TABLE [dbo].[Import_auara_arl_ausca] (
    [St_auara_codice_fiscale_ausca] VARCHAR (16)  NULL,
    [St_auara_ausca_codice_pk]      INT           NULL,
    [St_auara_c_tipo]               VARCHAR (2)   NULL,
    [St_auara_tipo]                 VARCHAR (100) NULL,
    [St_auara_c_forma]              VARCHAR (5)   NULL,
    [St_auara_forma]                VARCHAR (100) NULL,
    [St_auara_n_ruolo]              VARCHAR (7)   NULL,
    [St_auara_ruolo_provincia]      VARCHAR (2)   NULL,
    [St_auara_c_ente_rilascio]      VARCHAR (2)   NULL,
    [St_auara_ente_rilascio]        VARCHAR (100) NULL,
    [St_auara_dt_iscrizione]        DATE          NULL,
    [St_auara_dt_domanda]           DATE          NULL,
    [St_auara_dt_delibera]          DATE          NULL,
    [St_auara_dt_cessazione]        DATE          NULL,
    [St_auara_c_causale]            VARCHAR (2)   NULL,
    [St_auara_data_modifica]        DATETIME      NULL,
    [St_auara_descr_utente]         VARCHAR (50)  NULL
);

