CREATE TABLE [dbo].[tb_aupas_partecipazione_soggetto] (
    [aupas_codice_pk]        BIGINT       IDENTITY (1, 1) NOT NULL,
    [aupas_ausca_codice_pk]  INT          NULL,
    [aupas_ausco_codice_pk]  INT          NULL,
    [aupas_Prog_pers]        VARCHAR (4)  NULL,
    [aupas_Cap_agire]        VARCHAR (2)  NULL,
    [aupas_flag_se_elettore] VARCHAR (1)  NULL,
    [aupas_potere_firma]     VARCHAR (1)  NULL,
    [aupas_quote_partec]     VARCHAR (15) NULL,
    [aupas_perce_partec]     VARCHAR (4)  NULL,
    [aupas_rec_del]          VARCHAR (1)  NULL,
    [aupas_data_del]         DATETIME     NULL,
    [aupas_data_modifica]    DATETIME     NULL,
    [aupas_descr_utente]     VARCHAR (50) NULL,
    CONSTRAINT [PK_tb_aupas] PRIMARY KEY CLUSTERED ([aupas_codice_pk] ASC),
    CONSTRAINT [FK_aupas_ausca] FOREIGN KEY ([aupas_ausca_codice_pk]) REFERENCES [dbo].[tb_ausca_sog_contr_az] ([ausca_codice_pk]),
    CONSTRAINT [FK_aupas_ausco] FOREIGN KEY ([aupas_ausco_codice_pk]) REFERENCES [dbo].[tb_ausco_sog_contr_col] ([ausco_codice_pk]),
    CONSTRAINT [UQ_aupas_aupas] UNIQUE NONCLUSTERED ([aupas_codice_pk] ASC)
);

