CREATE TABLE [dbo].[Sync_DM_aupoc_variazioni] (
    [id]                           BIGINT        IDENTITY (1, 1) NOT NULL,
    [St_aupoc_posizione]           VARCHAR (10)  NULL,
    [St_aupoc_codice_fiscale_DM]   VARCHAR (16)  NULL,
    [St_aupoc_codice_fiscale_AUC]  VARCHAR (16)  NULL,
    [St_aupoc_Partita_IVA]         VARCHAR (11)  NULL,
    [St_aupoc_ausca_codice_pk_DM]  INT           NULL,
    [St_aupoc_ausca_codice_pk_AUC] INT           NULL,
    [St_aupoc_ausin_codice_pk]     INT           NULL,
    [St_aupoc_data_modifica]       DATETIME      NULL,
    [St_aupoc_aupoc_descr_utente]  VARCHAR (200) NULL
);

