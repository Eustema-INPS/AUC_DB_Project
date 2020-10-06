CREATE TABLE [dbo].[tb_aupoe_PosizioniErrate_Aurpp] (
    [aurpp_aupoc_cod_pk_madre]  INT          NULL,
    [aurpp_posizione_madre]     VARCHAR (50) NULL,
    [aurpp_aupoc_cod_pk_figlia] INT          NULL,
    [aurpp_posizione_figlia]    VARCHAR (50) NULL,
    [aurpp_flag_operativo]      INT          NULL,
    [aurpp_codice_pk_db2]       BIGINT       NULL,
    [aurpp_data_modifica]       DATETIME     NULL,
    [aurpp_descr_utente]        VARCHAR (50) NULL,
    [aurpp_codice_pk]           INT          NULL
);

