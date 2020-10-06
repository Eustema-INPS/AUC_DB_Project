CREATE TABLE [dbo].[tb_auara_arl_ausca] (
    [auara_codice_pk]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [auara_ausca_codice_pk] INT           NULL,
    [auara_c_tipo]          VARCHAR (2)   NULL,
    [auara_tipo]            VARCHAR (100) NULL,
    [auara_c_forma]         VARCHAR (5)   NULL,
    [auara_forma]           VARCHAR (100) NULL,
    [auara_n_ruolo]         VARCHAR (7)   NULL,
    [auara_ruolo_provincia] VARCHAR (2)   NULL,
    [auara_c_ente_rilascio] VARCHAR (2)   NULL,
    [auara_ente_rilascio]   VARCHAR (100) NULL,
    [auara_dt_iscrizione]   DATE          NULL,
    [auara_dt_domanda]      DATE          NULL,
    [auara_dt_delibera]     DATE          NULL,
    [auara_dt_cessazione]   DATE          NULL,
    [auara_c_causale]       VARCHAR (2)   NULL,
    [auara_data_modifica]   DATETIME      NULL,
    [auara_descr_utente]    VARCHAR (50)  NULL,
    CONSTRAINT [PK_tb_auara] PRIMARY KEY CLUSTERED ([auara_codice_pk] ASC),
    CONSTRAINT [UQ_auara_auara] UNIQUE NONCLUSTERED ([auara_codice_pk] ASC)
);

