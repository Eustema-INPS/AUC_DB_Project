CREATE TABLE [dbo].[tb_aurac_registro_aiuti_cf] (
    [aurac_codice_pk]                        BIGINT       IDENTITY (1, 1) NOT NULL,
    [aurac_ausca_codice_pk]                  INT          NULL,
    [aurac_codice_fiscale_impresa_collegata] VARCHAR (16) NULL,
    [aurac_data_modifica]                    DATETIME     NULL,
    CONSTRAINT [PK_tb_aurac] PRIMARY KEY CLUSTERED ([aurac_codice_pk] ASC),
    CONSTRAINT [FK_aurac_ausca] FOREIGN KEY ([aurac_ausca_codice_pk]) REFERENCES [dbo].[tb_ausca_sog_contr_az] ([ausca_codice_pk]),
    CONSTRAINT [UQ_aurac_aurac] UNIQUE NONCLUSTERED ([aurac_codice_pk] ASC)
);

