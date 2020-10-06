CREATE TABLE [dbo].[tb_auica_iscritte_casse] (
    [auica_codice_pk]             BIGINT       IDENTITY (1, 1) NOT NULL,
    [auica_aupoc_codice_pk]       INT          NULL,
    [auica_id_sin]                VARCHAR (10) NULL,
    [auica_codice_fiscale]        VARCHAR (16) NULL,
    [auica_progressivo_confluito] VARCHAR (5)  NULL,
    [auica_cassa]                 VARCHAR (3)  NULL,
    [auica_data_inizio]           DATETIME     NULL,
    [auica_data_fine]             DATETIME     NULL,
    [auica_data_modifica]         DATETIME     NULL,
    [auica_descr_utente]          VARCHAR (50) NULL,
    [auica_aucas_codice_pk]       INT          NULL,
    [auica_rec_del]               VARCHAR (1)  NULL,
    [auica_data_del]              DATETIME     NULL,
    [auica_tipo_iscr_INPDAP]      VARCHAR (1)  NULL,
    [auica_desc_tipo_iscr_INPDAP] VARCHAR (20) NULL
);

