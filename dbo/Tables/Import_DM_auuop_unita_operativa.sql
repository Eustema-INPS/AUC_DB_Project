﻿CREATE TABLE [dbo].[Import_DM_auuop_unita_operativa] (
    [St_auuop_aupoc_accentrante]        VARCHAR (10)  NULL,
    [St_auuop_data_richiesta]           VARCHAR (MAX) NULL,
    [St_auuop_ora_richiesta]            VARCHAR (MAX) NULL,
    [St_auuop_identificativo]           VARCHAR (MAX) NULL,
    [St_auuop_num_provvedimento]        VARCHAR (MAX) NULL,
    [St_auuop_data_provvedimento]       VARCHAR (MAX) NULL,
    [St_auuop_cod_fiscale_accentrante]  VARCHAR (MAX) NULL,
    [St_auuop_tipo_richiesta]           VARCHAR (MAX) NULL,
    [St_auuop_segnatura_protocollo]     VARCHAR (MAX) NULL,
    [St_auuop_cod_fiscale_richiedente]  VARCHAR (MAX) NULL,
    [St_auuop_stato_richiesta]          VARCHAR (MAX) NULL,
    [St_auuop_classe_utente_richiedent] VARCHAR (MAX) NULL,
    [St_auuop_validatore_INPS]          VARCHAR (MAX) NULL,
    [St_auuop_aupoc_accentrata]         VARCHAR (MAX) NULL,
    [St_auuop_inizio_accentramento]     VARCHAR (MAX) NULL,
    [St_auuop_fine_accentramento]       VARCHAR (MAX) NULL,
    [St_auuop_denominazione]            VARCHAR (MAX) NULL,
    [St_auuop_toponimo]                 VARCHAR (MAX) NULL,
    [St_auuop_indirizzo]                VARCHAR (MAX) NULL,
    [St_auuop_civico]                   VARCHAR (MAX) NULL,
    [St_auuop_cap]                      VARCHAR (MAX) NULL,
    [St_auuop_comune]                   VARCHAR (MAX) NULL,
    [St_auuop_provincia]                VARCHAR (MAX) NULL,
    [St_auuop_telefono1]                VARCHAR (MAX) NULL,
    [St_auuop_telefono2]                VARCHAR (MAX) NULL,
    [St_auuop_fax]                      VARCHAR (MAX) NULL,
    [St_auuop_email]                    VARCHAR (MAX) NULL,
    [St_auuop_numero_dipendenti]        VARCHAR (MAX) NULL,
    [St_auuop_aupoc_codice_pk_ante]     INT           NULL,
    [St_auuop_aupoc_codice_pk_ata]      INT           NULL,
    [St_id_taccontr]                    INT           IDENTITY (1, 1) NOT NULL,
    [St_auuop_auind_codice_pk]          BIGINT        NULL,
    [St_auuop_data_modifica]            VARCHAR (MAX) NULL,
    [St_auuop_descr_utente]             VARCHAR (MAX) NULL,
    [St_auuop_patch_aupoc]              INT           NULL
);

