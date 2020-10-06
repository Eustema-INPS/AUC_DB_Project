CREATE TABLE [dbo].[tb_aupoe_PosizioniErrate_Auvas] (
    [aupoc_posizione]             VARCHAR (50)  NULL,
    [auvas_aupoc_codice_pk]       INT           NULL,
    [auvas_auspc_codice_pk]       INT           NULL,
    [auvas_data_variazione_stato] DATETIME2 (3) NULL,
    [auvas_utente]                VARCHAR (50)  NULL,
    [auvas_dispositivo_utente]    VARCHAR (6)   NULL,
    [auvas_data_modifica]         DATETIME2 (3) NULL,
    [auvas_descr_utente]          VARCHAR (50)  NULL,
    [auvas_flag_operativo]        INT           NULL,
    [auvas_codice_pk_db2]         BIGINT        NULL,
    [auvas_rec_del]               VARCHAR (1)   NULL,
    [auvas_data_del]              DATETIME2 (3) NULL,
    [auvas_data_modifica_utente]  DATETIME2 (3) NULL,
    [auvas_interruzioni]          INT           NULL
);

