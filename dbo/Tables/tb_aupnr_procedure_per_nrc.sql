CREATE TABLE [dbo].[tb_aupnr_procedure_per_nrc] (
    [aupnr_codice_pk]             BIGINT       IDENTITY (1, 1) NOT NULL,
    [aupnr_codice_fiscale]        VARCHAR (16) NULL,
    [aupnr_tipo_procedura]        VARCHAR (2)  NULL,
    [aupnr_data_inizio]           DATETIME     NULL,
    [aupnr_data_fine]             DATETIME     NULL,
    [aupnr_gestione_pc]           INT          NULL,
    [aupnr_presenza_pc]           INT          NULL,
    [aupnr_posizione]             VARCHAR (50) NULL,
    [aupnr_data_invio_email]      DATETIME     NULL,
    [aupnr_ausca_codice_pk]       INT          NULL,
    [aupnr_aupoc_codice_pk]       INT          NULL,
    [aupnr_data_modifica]         DATETIME     NULL,
    [aupnr_descr_utente]          VARCHAR (20) NULL,
    [Aupnr_ritorno_in_bonis]      VARCHAR (1)  CONSTRAINT [DF_tb_aupnr_procedure_per_nrc_Aupnr_ritorno_in_bonis] DEFAULT ('N') NULL,
    [Aupnr_data_ritorno_in_bonis] DATETIME     NULL,
    CONSTRAINT [PK_tb_aupnr] PRIMARY KEY CLUSTERED ([aupnr_codice_pk] ASC),
    CONSTRAINT [UQ_aupnr_aupnr] UNIQUE NONCLUSTERED ([aupnr_codice_pk] ASC)
);

