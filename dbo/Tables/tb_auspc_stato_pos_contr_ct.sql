CREATE TABLE [dbo].[tb_auspc_stato_pos_contr_ct] (
    [auspc_codice_pk]     INT          IDENTITY (1, 1) NOT NULL,
    [auspc_codice]        INT          NOT NULL,
    [auspc_descr]         VARCHAR (50) NULL,
    [auspc_ordinamento]   INT          NULL,
    [auspc_data_modifica] DATETIME     NULL,
    [auspc_descr_utente]  VARCHAR (50) NULL,
    [auspc_codice_pk_db2] INT          NULL,
    CONSTRAINT [PK_tb_aussa] PRIMARY KEY CLUSTERED ([auspc_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_auspc_auspc] UNIQUE NONCLUSTERED ([auspc_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

