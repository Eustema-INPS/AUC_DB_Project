CREATE TABLE [dbo].[tb_auata_ateco_ausca] (
    [auata_codice_pk]             BIGINT        IDENTITY (1, 1) NOT NULL,
    [auata_ausca_codice_pk]       INT           NULL,
    [auata_ausca_codice_fiscale]  VARCHAR (16)  NULL,
    [auata_classificazione_ateco] VARCHAR (4)   NULL,
    [auata_cod_att_output]        VARCHAR (6)   NULL,
    [auata_descr_attivita]        VARCHAR (200) NULL,
    [auata_cod_importanza]        VARCHAR (1)   NULL,
    [auata_importanza]            VARCHAR (50)  NULL,
    [auata_dt_inizio]             DATE          NULL,
    [auata_dt_fine]               DATE          NULL,
    [auata_dt_riferimento]        DATE          NULL,
    [auata_data_modifica]         DATETIME      NULL,
    [auata_descr_utente]          VARCHAR (50)  NULL,
    CONSTRAINT [PK_tb_auata] PRIMARY KEY CLUSTERED ([auata_codice_pk] ASC),
    CONSTRAINT [UQ_auata_auata] UNIQUE NONCLUSTERED ([auata_codice_pk] ASC)
);

