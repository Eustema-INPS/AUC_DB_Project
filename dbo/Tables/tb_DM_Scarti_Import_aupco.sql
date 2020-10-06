CREATE TABLE [dbo].[tb_DM_Scarti_Import_aupco] (
    [St_aupco_aupoc_posizione]          VARCHAR (10)  NULL,
    [St_aupco_data_decorr_caratt_contr] VARCHAR (MAX) NULL,
    [St_aupco_cod_stat_contributivo]    VARCHAR (MAX) NULL,
    [St_aupco_codici_autorizzazione]    VARCHAR (MAX) NULL,
    [St_aupco_data_scad_autorizzazione] VARCHAR (MAX) NULL,
    [St_aupco_giorni_proroga]           VARCHAR (MAX) NULL,
    [St_aupco_lavoratori_autonomi]      VARCHAR (MAX) NULL,
    [St_aupco_data_termine_validita]    VARCHAR (MAX) NULL,
    [St_aupco_inserimento]              VARCHAR (MAX) NULL,
    [St_aupco_codice_Ateco91]           VARCHAR (MAX) NULL,
    [St_aupco_aupoc_codice_pk]          INT           NULL,
    [St_aupco_data_modifica]            DATETIME      NULL,
    [St_aupco_descr_utente]             VARCHAR (MAX) NULL,
    [ErrorNum]                          VARCHAR (MAX) NULL,
    [ErrorDescription]                  VARCHAR (MAX) NULL,
    [NoteScartoErrori]                  VARCHAR (MAX) NULL
);

