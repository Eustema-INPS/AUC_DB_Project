CREATE TABLE [dbo].[tb_aucfi_cod_fiscale] (
    [aucfi_codice_pk]            INT          IDENTITY (1, 1) NOT NULL,
    [aucfi_ausca_codice_pk]      INT          NULL,
    [aucfi_data_inizio_validita] DATETIME     NULL,
    [aucfi_data_fine_validita]   DATETIME     NULL,
    [aucfi_codice_fiscale]       VARCHAR (16) NULL,
    [aucfi_data_modifica]        DATETIME     NULL,
    [aucfi_descr_utente]         VARCHAR (50) NULL,
    [aucfi_codice_pk_db2]        INT          NULL,
    [aucfi_data_del]             DATETIME     NULL,
    [aucfi_rec_del]              VARCHAR (1)  NULL,
    CONSTRAINT [PK_tb_aucfi] PRIMARY KEY CLUSTERED ([aucfi_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_aucfi_ausca] FOREIGN KEY ([aucfi_ausca_codice_pk]) REFERENCES [dbo].[tb_ausca_sog_contr_az] ([ausca_codice_pk]),
    CONSTRAINT [UQ_aucfi_aucfi] UNIQUE NONCLUSTERED ([aucfi_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

