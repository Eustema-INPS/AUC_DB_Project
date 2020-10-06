CREATE TABLE [dbo].[Sync_DM_TATECOS] (
    [St_tatecos_aupoc_posizione]          VARCHAR (10) NULL,
    [St_tatecos_cod_stat_contributivo]    VARCHAR (5)  NULL,
    [St_tatecos_data_decorr_caratt_contr] VARCHAR (50) NULL,
    [St_tatecos_data_termine_validita]    VARCHAR (50) NULL,
    [St_tatecos_CodAteco2007]             VARCHAR (10) NULL,
    [St_tatecos_auate_2007_codice_pk]     INT          NULL,
    [St_tatecos_data_modifica]            DATETIME     CONSTRAINT [DF_Sync_DM_TATECOS_St_tatecos_data_modifica] DEFAULT (getdate()) NULL
);

