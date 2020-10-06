CREATE TABLE [dbo].[tb_auaru_arl_auulo] (
    [auaru_codice_pk]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [auaru_progressivo]     INT           NULL,
    [auaru_ausca_codice_pk] INT           NULL,
    [auaru_auulo_codice_pk] INT           NULL,
    [auaru_c_tipo]          VARCHAR (2)   NULL,
    [auaru_tipo]            VARCHAR (100) NULL,
    [auaru_c_forma]         VARCHAR (5)   NULL,
    [auaru_forma]           VARCHAR (100) NULL,
    [auaru_n_ruolo]         VARCHAR (7)   NULL,
    [auaru_ruolo_provincia] VARCHAR (2)   NULL,
    [auaru_c_ente_rilascio] VARCHAR (2)   NULL,
    [auaru_ente_rilascio]   VARCHAR (50)  NULL,
    [auaru_dt_iscrizione]   DATE          NULL,
    [auaru_dt_domanda]      DATE          NULL,
    [auaru_dt_delibera]     DATE          NULL,
    [auaru_dt_cessazione]   DATE          NULL,
    [auaru_c_causale]       VARCHAR (2)   NULL,
    [auaru_data_modifica]   DATETIME      NULL,
    [auaru_descr_utente]    VARCHAR (50)  NULL,
    CONSTRAINT [PK_tb_auaru] PRIMARY KEY CLUSTERED ([auaru_codice_pk] ASC),
    CONSTRAINT [UQ_auaru_auaru] UNIQUE NONCLUSTERED ([auaru_codice_pk] ASC)
);

