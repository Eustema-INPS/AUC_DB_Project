CREATE TABLE [dbo].[tb_aueve_eventi] (
    [aueve_codice_pk]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [aueve_aufus_codice_pk] BIGINT        NULL,
    [aueve_prog_societa]    INT           NULL,
    [aueve_denominazione]   VARCHAR (455) NULL,
    [aueve_comune]          VARCHAR (255) NULL,
    [aueve_codice_fiscale]  VARCHAR (16)  NULL,
    [aueve_cciaa]           VARCHAR (2)   NULL,
    [aueve_n_rea]           VARCHAR (20)  NULL,
    [aueve_codice_pk_db2]   BIGINT        NULL,
    [aueve_data_modifica]   DATETIME      NULL,
    [aueve_descr_utente]    VARCHAR (50)  NULL,
    [aueve_rec_del]         VARCHAR (1)   NULL,
    [aueve_data_del]        DATETIME      NULL,
    CONSTRAINT [PK_tb_aueve] PRIMARY KEY CLUSTERED ([aueve_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_aueve_aufus] FOREIGN KEY ([aueve_aufus_codice_pk]) REFERENCES [dbo].[tb_aufus_fusioni_scissioni] ([aufus_codice_pk]),
    CONSTRAINT [UQ_aueve_aueve] UNIQUE NONCLUSTERED ([aueve_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

