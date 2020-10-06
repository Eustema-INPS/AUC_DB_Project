CREATE TABLE [dbo].[tb_auces_fusioni_cessioni] (
    [auces_codice_pk]             INT           IDENTITY (1, 1) NOT NULL,
    [auces_ausca_codice_pk]       INT           NULL,
    [auces_tipo_operazione]       INT           NULL,
    [auces_descr_tipo_operazione] VARCHAR (100) NULL,
    [auces_ausca_codice_pk_az]    INT           NULL,
    [auces_denominazione]         VARCHAR (100) NULL,
    [auces_codice_fiscale]        VARCHAR (16)  NULL,
    [auces_cciaa]                 VARCHAR (2)   NULL,
    [auces_n_rea]                 VARCHAR (20)  NULL,
    [auces_sede]                  VARCHAR (30)  NULL,
    [auces_data_iscrizione]       DATETIME      NULL,
    [auces_data_atto]             DATETIME      NULL,
    [auces_data_modifica]         DATETIME      NULL,
    [auces_descr_utente]          VARCHAR (50)  NULL,
    [auces_codice_pk_db2]         INT           NULL,
    CONSTRAINT [PK_tb_auces] PRIMARY KEY CLUSTERED ([auces_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_auces_auces] UNIQUE NONCLUSTERED ([auces_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

