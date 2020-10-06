CREATE TABLE [dbo].[tb_auatu_ateco_auulo] (
    [auatu_codice_pk]             BIGINT        IDENTITY (1, 1) NOT NULL,
    [auatu_ausca_codice_pk]       INT           NULL,
    [auatu_ausca_codice_fiscale]  VARCHAR (16)  NULL,
    [auatu_auulo_codice_pk]       INT           NULL,
    [auatu_classificazione_ateco] VARCHAR (4)   NULL,
    [auatu_cod_att_output]        VARCHAR (6)   NULL,
    [auatu_descr_attivita]        VARCHAR (200) NULL,
    [auatu_cod_importanza]        VARCHAR (1)   NULL,
    [auatu_importanza]            VARCHAR (50)  NULL,
    [auatu_dt_inizio]             DATE          NULL,
    [auatu_dt_fine]               DATE          NULL,
    [auatu_dt_riferimento]        DATE          NULL,
    [auatu_data_modifica]         DATETIME      NULL,
    [auatu_descr_utente]          VARCHAR (50)  NULL,
    CONSTRAINT [PK_tb_auatu] PRIMARY KEY CLUSTERED ([auatu_codice_pk] ASC),
    CONSTRAINT [UQ_auata_auatu] UNIQUE NONCLUSTERED ([auatu_codice_pk] ASC)
);

