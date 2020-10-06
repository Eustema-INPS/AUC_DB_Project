CREATE TABLE [dbo].[tb_aupro_processi_batch] (
    [aupro_codice_pk]     INT           IDENTITY (1, 1) NOT NULL,
    [aupro_nome_processo] VARCHAR (50)  NULL,
    [aupro_note]          VARCHAR (200) NULL,
    [aupro_data_modifica] DATETIME      NULL,
    [aupro_descr_utente]  VARCHAR (50)  NULL,
    [aupro_codice_pk_db2] INT           NULL,
    CONSTRAINT [PK_tb_aupro] PRIMARY KEY CLUSTERED ([aupro_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aupro_aupro] UNIQUE NONCLUSTERED ([aupro_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

