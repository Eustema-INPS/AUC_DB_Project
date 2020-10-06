CREATE TABLE [dbo].[tb_auvar_var_dati] (
    [auvar_codice_pk]         INT           IDENTITY (1, 1) NOT NULL,
    [auvar_ausca_codice_pk]   INT           NULL,
    [auvar_auten_codice_pk]   INT           NULL,
    [auvar_aueva_nome_var]    VARCHAR (50)  NULL,
    [auvar_valore_originale]  VARCHAR (100) NULL,
    [auvar_valore_modificato] VARCHAR (100) NULL,
    [auvar_data_variazione]   DATETIME      NULL,
    [auvar_codice_entita_rif] INT           NULL,
    [auvar_data_modifica]     DATETIME      NULL,
    [auvar_descr_utente]      VARCHAR (50)  NULL,
    [auvar_codice_pk_db2]     INT           NULL,
    CONSTRAINT [PK_tb_auvar] PRIMARY KEY CLUSTERED ([auvar_codice_pk] ASC),
    CONSTRAINT [FK_auvar_aueva] FOREIGN KEY ([auvar_aueva_nome_var]) REFERENCES [dbo].[tb_aueva_elenco_variabili] ([aueva_nome_var]),
    CONSTRAINT [FK_auvar_ausca] FOREIGN KEY ([auvar_ausca_codice_pk]) REFERENCES [dbo].[tb_ausca_sog_contr_az] ([ausca_codice_pk]),
    CONSTRAINT [FK_auvar_auten] FOREIGN KEY ([auvar_auten_codice_pk]) REFERENCES [dbo].[tb_auten_tipo_entita_ct] ([auten_codice_pk]),
    CONSTRAINT [UQ_auvar_auvar] UNIQUE NONCLUSTERED ([auvar_codice_pk] ASC)
);

