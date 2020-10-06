CREATE TABLE [dbo].[tb_ausrc_storico_registro_aiuti_cf] (
    [ausrc_codice_pk]                        BIGINT       IDENTITY (1, 1) NOT NULL,
    [ausrc_ausra_codice_pk]                  BIGINT       NULL,
    [ausrc_codice_fiscale_impresa_collegata] VARCHAR (16) NULL,
    [ausrc_data_modifica]                    DATETIME     NULL,
    CONSTRAINT [PK_tb_ausrc] PRIMARY KEY CLUSTERED ([ausrc_codice_pk] ASC),
    CONSTRAINT [FK_ausrc_ausra] FOREIGN KEY ([ausrc_ausra_codice_pk]) REFERENCES [dbo].[tb_ausra_storico_registro_aiuti] ([ausra_codice_pk]),
    CONSTRAINT [UQ_ausrc_ausrc] UNIQUE NONCLUSTERED ([ausrc_codice_pk] ASC)
);

