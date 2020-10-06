CREATE TABLE [dbo].[tb_DM_Scarti_Import_aurpp] (
    [St_aurpp_aupoc_posizione_madre]  VARCHAR (10)  NULL,
    [St_aurpp_aupoc_posizione_figlia] VARCHAR (10)  NULL,
    [St_aurpp_aupoc_cod_pk_madre]     INT           NULL,
    [St_aurpp_aupoc_cod_pk_figlia]    INT           NULL,
    [St_aurpp_data_modifica]          DATETIME      NULL,
    [St_aurad_descr_utente]           VARCHAR (MAX) NULL,
    [ErrorNum]                        VARCHAR (MAX) NULL,
    [ErrorDescription]                VARCHAR (MAX) NULL,
    [NoteScartoErrori]                VARCHAR (MAX) NULL
);

