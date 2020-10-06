CREATE TABLE [dbo].[tb_aupoe_PosizioniErrate_Aupco] (
    [aupoc_posizione]            VARCHAR (50)  NULL,
    [aupco_aupoc_codice_pk]      INT           NULL,
    [aupco_auate_codice_pk]      INT           NULL,
    [aupco_data_inizio_validita] DATETIME2 (3) NULL,
    [aupco_data_fine_validita]   DATETIME2 (3) NULL,
    [aupco_data_scad_autor]      DATETIME2 (3) NULL,
    [aupco_giorni_proroga]       INT           NULL,
    [aupco_cod_stat_contr]       VARCHAR (5)   NULL,
    [aupco_codici_autor]         VARCHAR (60)  NULL,
    [aupco_lavoratori_autonomi]  INT           NULL,
    [aupco_inserimento]          VARCHAR (50)  NULL,
    [aupco_ateco_91]             VARCHAR (100) NULL,
    [aupco_flag_operativo]       INT           NULL,
    [aupco_aucsc_codice_pk]      INT           NULL,
    [aupco_data_modifica]        DATETIME2 (3) NULL,
    [aupco_descr_utente]         VARCHAR (50)  NULL,
    [aupco_codice_pk_db2]        BIGINT        NULL,
    [aupco_auate_1991_codice_pk] INT           NULL,
    [aupco_auate_2002_codice_pk] INT           NULL,
    [aupco_auate_2007_codice_pk] INT           NULL
);

