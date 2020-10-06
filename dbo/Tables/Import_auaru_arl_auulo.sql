﻿CREATE TABLE [dbo].[Import_auaru_arl_auulo] (
    [St_auaru_codice_fiscale_ausca] VARCHAR (16)  NULL,
    [St_auaru_progressivo]          INT           NULL,
    [St_auaru_dt_aperturaUL]        DATE          NULL,
    [St_auaru_cod_comuneUL]         VARCHAR (3)   NULL,
    [St_auaru_provinciaUL]          VARCHAR (2)   NULL,
    [St_auaru_dt_chiusuraUL]        DATE          NULL,
    [st_auaru_auulo_codice_pk]      INT           NULL,
    [St_auaru_ausca_codice_pk]      INT           NULL,
    [St_auaru_c_tipo]               VARCHAR (2)   NULL,
    [St_auaru_tipo]                 VARCHAR (100) NULL,
    [St_auaru_c_forma]              VARCHAR (5)   NULL,
    [St_auaru_forma]                VARCHAR (100) NULL,
    [St_auaru_n_ruolo]              VARCHAR (7)   NULL,
    [St_auaru_ruolo_provincia]      VARCHAR (2)   NULL,
    [St_auaru_c_ente_rilascio]      VARCHAR (2)   NULL,
    [St_auaru_ente_rilascio]        VARCHAR (50)  NULL,
    [St_auaru_dt_iscrizione]        DATE          NULL,
    [St_auaru_dt_domanda]           DATE          NULL,
    [St_auaru_dt_delibera]          DATE          NULL,
    [St_auaru_dt_cessazione]        DATE          NULL,
    [St_auaru_c_causale]            VARCHAR (2)   NULL,
    [St_auaru_data_modifica]        DATETIME      NULL,
    [St_auaru_descr_utente]         VARCHAR (50)  NULL
);

