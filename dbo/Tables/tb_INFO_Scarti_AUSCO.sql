﻿CREATE TABLE [dbo].[tb_INFO_Scarti_AUSCO] (
    [St_ausco_codice_pk]                  INT           NULL,
    [St_ausco_codice_fiscale]             VARCHAR (16)  NULL,
    [St_ausco_cognome]                    VARCHAR (255) NULL,
    [St_ausco_nome]                       VARCHAR (150) NULL,
    [St_ausco_denominazione]              VARCHAR (405) NULL,
    [St_ausco_note]                       VARCHAR (200) NULL,
    [St_ausco_FisicaGiuridica]            VARCHAR (1)   NULL,
    [St_ausco_sesso]                      VARCHAR (1)   NULL,
    [St_ausco_Codice_Toponimo]            VARCHAR (3)   NULL,
    [St_ausco_Toponimo]                   VARCHAR (100) NULL,
    [St_ausco_Nome_Via]                   VARCHAR (100) NULL,
    [St_ausco_civico]                     VARCHAR (50)  NULL,
    [St_ausco_sede_legale_italia]         VARCHAR (999) NULL,
    [St_ausco_codice_comune]              VARCHAR (4)   NULL,
    [St_ausco_localita]                   VARCHAR (50)  NULL,
    [St_ausco_sigla_provincia]            VARCHAR (2)   NULL,
    [St_ausco_regione]                    VARCHAR (999) NULL,
    [St_ausco_codice_stato_estero]        VARCHAR (4)   NULL,
    [St_ausco_cap]                        VARCHAR (5)   NULL,
    [St_ausco_CodiceFormaGiuridica]       VARCHAR (999) NULL,
    [St_ausco_Stato]                      VARCHAR (10)  NULL,
    [St_ausco_telefono1]                  VARCHAR (20)  NULL,
    [St_ausco_fax]                        VARCHAR (20)  NULL,
    [St_ausco_PEC]                        VARCHAR (162) NULL,
    [St_ausco_data_nascita]               DATE          NULL,
    [St_ausco_comune_nascita]             VARCHAR (50)  NULL,
    [St_ausco_prov_nascita]               VARCHAR (2)   NULL,
    [St_ausco_Residenza_indirizzo]        VARCHAR (999) NULL,
    [St_ausco_Residenza_provincia]        VARCHAR (999) NULL,
    [St_ausco_Residenza_comune]           VARCHAR (999) NULL,
    [St_ausco_Residenza_ctoponimo]        VARCHAR (999) NULL,
    [St_ausco_Residenza_via]              VARCHAR (999) NULL,
    [St_ausco_Residenza_ncivico]          VARCHAR (999) NULL,
    [St_ausco_Residenza_cap]              VARCHAR (999) NULL,
    [St_ausco_Filename]                   VARCHAR (999) NULL,
    [St_ausco_data_domandafile]           VARCHAR (999) NULL,
    [St_ausco_TipologiaFile]              VARCHAR (999) NULL,
    [St_ausco_MatricolaGestioneAziende]   VARCHAR (999) NULL,
    [St_ausco_NomeFileVisuraOriginale]    VARCHAR (999) NULL,
    [St_ausco_NomeOriginale_Prov1]        VARCHAR (999) NULL,
    [St_ausco_NomeOriginale_Anno]         VARCHAR (999) NULL,
    [St_ausco_NomeOriginale_Progressivo1] VARCHAR (999) NULL,
    [St_ausco_NomeOriginale_Visura]       VARCHAR (999) NULL,
    [St_ausco_NomeOriginale_Prov2]        VARCHAR (999) NULL,
    [St_ausco_NomeOriginale_NumREA]       VARCHAR (999) NULL,
    [St_ausco_FLAG]                       TINYINT       NULL,
    [St_ausco_PRESENTE]                   CHAR (1)      NULL,
    [St_ausco_data_modifica]              DATETIME      NULL,
    [St_ausco_descr_utente]               VARCHAR (50)  NULL,
    [ErrorNum]                            VARCHAR (MAX) NULL,
    [ErrorDescription]                    VARCHAR (MAX) NULL
);
