CREATE TABLE [dbo].[Sync_DM_CFAZI] (
    [posizione]               VARCHAR (10) NULL,
    [codice_fiscale_dismesso] VARCHAR (16) NULL,
    [codice_fiscale_nuovo]    VARCHAR (16) NULL,
    [aupoc_codice_pk]         INT          NULL,
    [data_inserimento]        VARCHAR (25) NULL,
    [data_modifica]           DATETIME     CONSTRAINT [DF__Sync_DM_C__data___37C93AC0] DEFAULT (getdate()) NULL,
    [descr_Utente]            VARCHAR (50) NULL,
    [flag_presente]           CHAR (1)     CONSTRAINT [DF_Sync_DM_CFAZI_flag_presente] DEFAULT ('N') NULL
);

