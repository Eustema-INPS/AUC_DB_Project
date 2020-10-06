CREATE TABLE [dbo].[tb_aucdc_cdclas_ct] (
    [aucdc_codice_pk]         INT          IDENTITY (1, 1) NOT NULL,
    [aucdc_codice]            VARCHAR (2)  NOT NULL,
    [aucdc_descrizione_breve] VARCHAR (12) NULL,
    [aucdc_descrizione]       VARCHAR (50) NULL,
    [aucdc_data_modifica]     DATETIME     NULL,
    [aucdc_descr_utente]      VARCHAR (50) NULL,
    [aucdc_codice_pk_db2]     INT          NULL,
    CONSTRAINT [PK_tb_aucdc] PRIMARY KEY CLUSTERED ([aucdc_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aucdc_aucdc] UNIQUE NONCLUSTERED ([aucdc_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

