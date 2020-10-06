CREATE TABLE [dbo].[tb_aucom_compartimento_ct] (
    [aucom_codice_pk]     INT          IDENTITY (1, 1) NOT NULL,
    [aucom_codice]        VARCHAR (1)  NULL,
    [aucom_descr]         VARCHAR (50) NULL,
    [aucom_data_modifica] DATETIME     NULL,
    [aucom_descr_utente]  VARCHAR (50) NULL,
    [aucom_codice_pk_db2] INT          NULL,
    CONSTRAINT [PK_tb_aucom] PRIMARY KEY CLUSTERED ([aucom_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aucom_aucom] UNIQUE NONCLUSTERED ([aucom_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

