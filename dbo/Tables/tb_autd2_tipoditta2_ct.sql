CREATE TABLE [dbo].[tb_autd2_tipoditta2_ct] (
    [autd2_codice_pk]         INT           IDENTITY (1, 1) NOT NULL,
    [autd2_codice]            VARCHAR (2)   NULL,
    [autd2_descrizione]       VARCHAR (100) NULL,
    [autd2_descrizione_lunga] VARCHAR (300) NULL,
    [autd2_ordinamento]       INT           NULL,
    [autd2_data_modifica]     DATETIME      NULL,
    [autd2_descr_utente]      VARCHAR (50)  NULL,
    [autd2_codice_pk_db2]     INT           NULL,
    CONSTRAINT [PK_tb_audt2] PRIMARY KEY CLUSTERED ([autd2_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_audt2_audt2] UNIQUE NONCLUSTERED ([autd2_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

