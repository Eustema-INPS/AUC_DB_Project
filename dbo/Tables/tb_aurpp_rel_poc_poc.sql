CREATE TABLE [dbo].[tb_aurpp_rel_poc_poc] (
    [aurpp_codice_pk]           BIGINT       IDENTITY (1, 1) NOT NULL,
    [aurpp_aupoc_cod_pk_madre]  INT          NULL,
    [aurpp_aupoc_cod_pk_figlia] INT          NULL,
    [aurpp_flag_operativo]      INT          NULL,
    [aurpp_data_modifica]       DATETIME     NULL,
    [aurpp_descr_utente]        VARCHAR (50) NULL,
    [aurpp_codice_pk_db2]       BIGINT       NULL,
    [aurpp_rec_del]             VARCHAR (1)  NULL,
    [aurpp_data_del]            DATETIME     NULL,
    CONSTRAINT [PK_tb_aurpp] PRIMARY KEY CLUSTERED ([aurpp_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_aurpp_figlia_aupoc] FOREIGN KEY ([aurpp_aupoc_cod_pk_figlia]) REFERENCES [dbo].[tb_aupoc_pos_contr] ([aupoc_codice_pk]),
    CONSTRAINT [FK_aurpp_madre_aupoc] FOREIGN KEY ([aurpp_aupoc_cod_pk_madre]) REFERENCES [dbo].[tb_aupoc_pos_contr] ([aupoc_codice_pk]),
    CONSTRAINT [UQ_aurpp_aurpp] UNIQUE NONCLUSTERED ([aurpp_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

