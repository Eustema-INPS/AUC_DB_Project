CREATE TABLE [dbo].[tb_aucfv_cfvar] (
    [aucfv_codice_pk]     BIGINT        IDENTITY (1, 1) NOT NULL,
    [aucfv_cf_partenza]   VARCHAR (16)  NULL,
    [aucfv_cf_target]     VARCHAR (16)  NULL,
    [aucfv_matricola_DM]  VARCHAR (10)  NULL,
    [aucfv_tipo_azione]   VARCHAR (2)   NULL,
    [aucfv_flag]          INT           NULL,
    [aucfv_data_modifica] DATETIME      NULL,
    [aucfv_descr_utente]  VARCHAR (200) NULL
);

