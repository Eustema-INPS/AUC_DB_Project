CREATE TABLE [dbo].[tb_ausub_subentri] (
    [ausub_codice_pk]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [ausub_ausca_codice_pk] INT           NULL,
    [ausub_c_tipo]          VARCHAR (5)   NULL,
    [ausub_tipo]            VARCHAR (100) NULL,
    [ausub_denominazione]   VARCHAR (455) NULL,
    [ausub_codice_fiscale]  VARCHAR (16)  NULL,
    [ausub_c_titolo]        VARCHAR (5)   NULL,
    [ausub_titolo]          VARCHAR (255) NULL,
    [ausub_codice_pk_db2]   BIGINT        NULL,
    [ausub_data_modifica]   DATETIME      NULL,
    [ausub_descr_utente]    VARCHAR (50)  NULL,
    [ausub_rec_del]         VARCHAR (1)   NULL,
    [ausub_data_del]        DATETIME      NULL,
    CONSTRAINT [PK_ausub] PRIMARY KEY CLUSTERED ([ausub_codice_pk] ASC),
    CONSTRAINT [FK_ausub_ausca] FOREIGN KEY ([ausub_ausca_codice_pk]) REFERENCES [dbo].[tb_ausca_sog_contr_az] ([ausca_codice_pk]),
    CONSTRAINT [UQ_ausub_ausub] UNIQUE NONCLUSTERED ([ausub_codice_pk] ASC)
);

