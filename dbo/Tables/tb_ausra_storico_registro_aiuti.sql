CREATE TABLE [dbo].[tb_ausra_storico_registro_aiuti] (
    [ausra_codice_pk]               BIGINT       IDENTITY (1, 1) NOT NULL,
    [ausra_ausca_codice_pk]         INT          NULL,
    [ausra_RA_impresa_autonoma]     VARCHAR (1)  CONSTRAINT [DF__tb_ausra___ausra__0E1D19B7] DEFAULT ('N') NULL,
    [ausra_RA_impresa_associata]    VARCHAR (1)  CONSTRAINT [DF__tb_ausra___ausra__0F113DF0] DEFAULT ('N') NULL,
    [ausra_RA_impresa_collegata]    VARCHAR (1)  CONSTRAINT [DF__tb_ausra___ausra__10056229] DEFAULT ('N') NULL,
    [ausra_RA_data_fine_esercizio]  DATE         CONSTRAINT [DF__tb_ausra___ausra__10F98662] DEFAULT (NULL) NULL,
    [ausra_RA_dimensione_aziendale] VARCHAR (2)  CONSTRAINT [DF__tb_ausra___ausra__11EDAA9B] DEFAULT (NULL) NULL,
    [ausra_codice_operatore]        VARCHAR (20) NULL,
    [ausra_codice_fiscale_delegato] VARCHAR (16) NULL,
    [ausra_data_modifica]           DATETIME     NULL,
    CONSTRAINT [PK_tb_ausra] PRIMARY KEY CLUSTERED ([ausra_codice_pk] ASC),
    CONSTRAINT [FK_ausra_ausca] FOREIGN KEY ([ausra_ausca_codice_pk]) REFERENCES [dbo].[tb_ausca_sog_contr_az] ([ausca_codice_pk]),
    CONSTRAINT [UQ_ausra_ausra] UNIQUE NONCLUSTERED ([ausra_codice_pk] ASC)
);

