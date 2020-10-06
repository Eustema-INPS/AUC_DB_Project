CREATE TABLE [dbo].[tb_auvas_var_stato_pos] (
    [auvas_codice_pk]             BIGINT       IDENTITY (1, 1) NOT NULL,
    [auvas_aupoc_codice_pk]       INT          NULL,
    [auvas_auspc_codice_pk]       INT          NULL,
    [auvas_data_variazione_stato] DATETIME     NULL,
    [auvas_utente]                VARCHAR (50) NULL,
    [auvas_dispositivo_utente]    VARCHAR (6)  NULL,
    [auvas_data_modifica]         DATETIME     NULL,
    [auvas_descr_utente]          VARCHAR (50) NULL,
    [auvas_flag_operativo]        INT          NULL,
    [auvas_codice_pk_db2]         BIGINT       NULL,
    [auvas_rec_del]               VARCHAR (1)  NULL,
    [auvas_data_del]              DATETIME     NULL,
    [auvas_data_modifica_utente]  DATETIME     NULL,
    [auvas_interruzioni]          INT          CONSTRAINT [DF_tb_auvas_var_stato_pos_auvas_interruzioni] DEFAULT ((0)) NULL,
    [auvas_ora_modifica_utente]   INT          NULL,
    CONSTRAINT [PK_tb_auvas] PRIMARY KEY CLUSTERED ([auvas_codice_pk] ASC),
    CONSTRAINT [FK_auvas_aupoc] FOREIGN KEY ([auvas_aupoc_codice_pk]) REFERENCES [dbo].[tb_aupoc_pos_contr] ([aupoc_codice_pk]),
    CONSTRAINT [FK_auvas_auspc] FOREIGN KEY ([auvas_auspc_codice_pk]) REFERENCES [dbo].[tb_auspc_stato_pos_contr_ct] ([auspc_codice_pk]),
    CONSTRAINT [UQ_auvas_auvas] UNIQUE NONCLUSTERED ([auvas_codice_pk] ASC)
);

