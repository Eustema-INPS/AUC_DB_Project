CREATE TABLE [dbo].[tb_aupoe_PosizioniErrate_Aupcs] (
    [aupoc_posizione]            VARCHAR (50)  NULL,
    [aupcs_data_inizio_validita] DATETIME2 (3) NULL,
    [aupcs_data_fine_validita]   DATETIME2 (3) NULL,
    [aupcs_data_scad_autor]      DATETIME2 (3) NULL,
    [aupcs_giorni_proroga]       INT           NULL,
    [aupcs_cod_stat_contr]       VARCHAR (5)   NULL,
    [aupcs_codici_autor]         VARCHAR (60)  NULL,
    [aupcs_lavoratori_autonomi]  INT           NULL,
    [aupcs_inserimento]          VARCHAR (50)  NULL,
    [aupcs_ateco_91]             VARCHAR (100) NULL,
    [aupcs_flag_operativo]       INT           NULL,
    [aupcs_aucsc_codice_pk]      INT           NULL,
    [aupcs_data_modifica]        DATETIME2 (3) NULL,
    [aupcs_descr_utente]         VARCHAR (50)  NULL,
    [aupcs_codice_pk_db2]        BIGINT        NULL,
    [aupcs_auate_1991_codice_pk] INT           NULL,
    [aupcs_auate_2002_codice_pk] INT           NULL,
    [aupcs_auate_2007_codice_pk] INT           NULL
);

