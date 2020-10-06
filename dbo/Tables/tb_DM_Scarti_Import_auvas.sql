CREATE TABLE [dbo].[tb_DM_Scarti_Import_auvas] (
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
    [ErrorNum]                          VARCHAR (MAX) NULL,
    [ErrorDescription]                  VARCHAR (MAX) NULL,
    [NoteScartoErrori]                  VARCHAR (MAX) NULL
);

