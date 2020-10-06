﻿CREATE TABLE [dbo].[Import_DM_aupoc_pos_contr] (
    [St_aupoc_posizione]                VARCHAR (10)  NULL,
    [St_aupoc_sede_provinciale]         INT           NULL,
    [St_aupoc_matricola_azienda]        INT           NULL,
    [St_aupoc_controcod_matr_az]        INT           NULL,
    [St_aupoc_sede_zonale]              VARCHAR (MAX) NULL,
    [St_aupoc_tipo_posizione]           VARCHAR (MAX) NULL,
    [St_aupoc_posizione_riferimento]    VARCHAR (MAX) NULL,
    [St_aupoc_data_inizio_attivita]     VARCHAR (MAX) NULL,
    [St_aupoc_data_cessazione_attivita] VARCHAR (MAX) NULL,
    [St_aupoc_stato_posizione]          VARCHAR (MAX) NULL,
    [St_aupoc_num_posizioni_collegate]  VARCHAR (MAX) NULL,
    [St_aupoc_denom_posiz_contributiva] VARCHAR (MAX) NULL,
    [St_aupoc_attivita_econ_dichiarata] VARCHAR (MAX) NULL,
    [St_aupoc_data_decorr_caratt_contr] VARCHAR (MAX) NULL,
    [St_aupoc_cod_stat_contributivo]    VARCHAR (MAX) NULL,
    [St_aupoc_codici_autorizzazione]    VARCHAR (MAX) NULL,
    [St_aupoc_data_scad_autorizzazione] VARCHAR (MAX) NULL,
    [St_aupoc_giorni_proroga]           VARCHAR (MAX) NULL,
    [St_aupoc_num_dip_iscrizione]       VARCHAR (MAX) NULL,
    [St_aupoc_codice_fiscale]           VARCHAR (MAX) NULL,
    [St_aupoc_Partita_IVA]              VARCHAR (MAX) NULL,
    [St_aupoc_codice_Ateco91]           VARCHAR (MAX) NULL,
    [St_aupoc_data_domanda_iscrizione]  VARCHAR (MAX) NULL,
    [St_aupoc_codice_forma_giuridica]   VARCHAR (MAX) NULL,
    [St_aupoc_nuovo_CSC]                VARCHAR (MAX) NULL,
    [St_aupoc_codice_sede_INPS]         VARCHAR (MAX) NULL,
    [St_aupoc_codice_agenzia]           VARCHAR (MAX) NULL,
    [St_aupoc_provenienza_iscrizione]   VARCHAR (MAX) NULL,
    [St_aupoc_utente_acquisizione]      VARCHAR (MAX) NULL,
    [St_aupoc_utente_validazione]       VARCHAR (MAX) NULL,
    [St_aupoc_tipo_indirizzo_postale]   VARCHAR (MAX) NULL,
    [St_aupoc_flag_pos_contr_annullata] VARCHAR (MAX) NULL,
    [St_aupoc_tipo_indirizzo]           VARCHAR (MAX) NULL,
    [St_aupoc_codice_toponimo]          VARCHAR (MAX) NULL,
    [St_aupoc_indirizzo]                VARCHAR (MAX) NULL,
    [St_aupoc_civico]                   VARCHAR (MAX) NULL,
    [St_aupoc_cap]                      VARCHAR (MAX) NULL,
    [St_aupoc_descr_comune]             VARCHAR (MAX) NULL,
    [St_aupoc_sigla_provincia]          VARCHAR (MAX) NULL,
    [St_aupoc_telefono1]                VARCHAR (MAX) NULL,
    [St_aupoc_telefono2]                VARCHAR (MAX) NULL,
    [St_aupoc_fax]                      VARCHAR (MAX) NULL,
    [St_aupoc_email]                    VARCHAR (MAX) NULL,
    [St_aupoc_PEC]                      VARCHAR (MAX) NULL,
    [St_aupoc_legalmail]                VARCHAR (MAX) NULL,
    [St_aupoc_note]                     VARCHAR (MAX) NULL,
    [St_aupoc_autia_codice_pk]          INT           NULL,
    [St_aupoc_auspc_codice_pk]          INT           NULL,
    [St_aupoc_ausca_codice_pk]          INT           NULL,
    [St_aupoc_auapp_codice_pk]          INT           NULL,
    [St_aupoc_ausin_codice_pk]          INT           NULL,
    [St_aupoc_data_modifica]            VARCHAR (MAX) NULL,
    [St_aupoc_aupoc_descr_utente]       VARCHAR (MAX) NULL,
    [St_aupoc_codice_fiscale_Orig]      VARCHAR (30)  NULL
);

