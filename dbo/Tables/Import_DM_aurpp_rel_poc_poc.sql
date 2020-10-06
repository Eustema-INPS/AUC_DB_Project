CREATE TABLE [dbo].[Import_DM_aurpp_rel_poc_poc] (
    [St_aurpp_aupoc_posizione_madre]  VARCHAR (10)  NULL,
    [St_aurpp_aupoc_posizione_figlia] VARCHAR (10)  NULL,
    [St_aurpp_aupoc_cod_pk_madre]     INT           NULL,
    [St_aurpp_aupoc_cod_pk_figlia]    INT           NULL,
    [St_aupoc_data_modifica]          VARCHAR (MAX) NULL,
    [St_aupoc_aupoc_descr_utente]     VARCHAR (MAX) NULL,
    [St_aurpp_patch_aupoc]            INT           NULL
);

