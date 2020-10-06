CREATE TABLE [dbo].[Import_aupas_partecipazione_soggetto] (
    [St_aupas_CodicefiscaleAzienda]  VARCHAR (16) NULL,
    [St_aupas_CodicefiscaleSoggetto] VARCHAR (16) NULL,
    [St_aupas_Ausca_codice_pk]       INT          NULL,
    [St_aupas_Ausco_codice_pk]       INT          NULL,
    [St_aupas_Prog_pers]             VARCHAR (4)  NULL,
    [St_aupas_Cap_agire]             VARCHAR (2)  NULL,
    [St_aupas_flag_se_elettore]      VARCHAR (1)  NULL,
    [St_aupas_potere_firma]          VARCHAR (1)  NULL,
    [St_aupas_quote_partec]          VARCHAR (15) NULL,
    [St_aupas_perce_partec]          VARCHAR (4)  NULL,
    [St_aupas_data_modifica]         DATETIME     NULL,
    [St_aupas_descr_utente]          VARCHAR (50) NULL
);

