CREATE TABLE [dbo].[Sync_DM_auvas_ordinato] (
    [codice_pk]                      BIGINT        IDENTITY (1, 1) NOT NULL,
    [st_auvas_codice_pk]             BIGINT        NULL,
    [aupoc_posizione]                VARCHAR (10)  NULL,
    [SOTIPCEN_stato_posizione]       INT           NULL,
    [SODATCEN_data_posizione]        VARCHAR (MAX) NULL,
    [SOTIPCEO_Stato_precedente]      VARCHAR (1)   NULL,
    [SODATCEO_data_stato_precedente] VARCHAR (8)   NULL,
    [SODATVAR_data_intervento]       VARCHAR (8)   NULL,
    [SOORAVAR_ora_intervento]        INT           NULL,
    [cancellato]                     VARCHAR (1)   NULL,
    [dispositivo]                    VARCHAR (MAX) NULL,
    [utente]                         VARCHAR (MAX) NULL,
    [data_modifica]                  DATETIME      CONSTRAINT [DF_Sync_DM_auvas_ordinato_data_modifica] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK1_sync_tb_auvas] PRIMARY KEY CLUSTERED ([codice_pk] ASC),
    CONSTRAINT [UQ1_st_auvas_auvas] UNIQUE NONCLUSTERED ([codice_pk] ASC)
);

