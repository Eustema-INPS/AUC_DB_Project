CREATE TABLE [dbo].[Sync_DM_auvas] (
    [st_auvas_codice_pk]                BIGINT        IDENTITY (1, 1) NOT NULL,
    [St_auvas_auvas_aupoc_posizione]    VARCHAR (10)  NULL,
    [St_auvas_auvas_stato_posizione]    INT           NULL,
    [St_auvas_auvas_data_posizione]     VARCHAR (8)   NULL,
    [St_auvas_auvas_utente]             VARCHAR (MAX) NULL,
    [St_auvas_auvas_dispositivo_utente] VARCHAR (MAX) NULL,
    [St_auvas_auvas_data_cambio_stato]  VARCHAR (MAX) NULL,
    [auspc_codice_pk]                   INT           NULL,
    [auvas_aupoc_codice_pk]             INT           NULL,
    [St_auvas_data_modifica]            VARCHAR (MAX) NULL,
    [St_auvas_descr_utente]             VARCHAR (MAX) NULL,
    [St_auvas_interruzioni]             INT           CONSTRAINT [DF_Sync_DM_auvas_St_auvas_interruzioni] DEFAULT ((0)) NULL,
    [St_auvas_ora_cambio_stato]         INT           NULL,
    [St_auvas_Stato_precedente]         VARCHAR (1)   NULL,
    [St_auvas_data_stato_precedente]    VARCHAR (8)   NULL,
    CONSTRAINT [PK_sync_tb_auvas] PRIMARY KEY CLUSTERED ([st_auvas_codice_pk] ASC),
    CONSTRAINT [UQ_st_auvas_auvas] UNIQUE NONCLUSTERED ([st_auvas_codice_pk] ASC)
);

