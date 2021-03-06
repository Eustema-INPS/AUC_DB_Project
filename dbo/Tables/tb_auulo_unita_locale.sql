﻿CREATE TABLE [dbo].[tb_auulo_unita_locale] (
    [auulo_codice_pk]                      BIGINT        IDENTITY (1, 1) NOT NULL,
    [auulo_ausca_codice_pk]                INT           NULL,
    [auulo_Progressivo_localizz]           VARCHAR (5)   NULL,
    [auulo_Tipo_localizz]                  VARCHAR (2)   NULL,
    [auulo_descr_tipo_localizz]            VARCHAR (20)  NULL,
    [auulo_tipo_iscr]                      VARCHAR (10)  NULL,
    [auulo_descr_tipo_iscr]                VARCHAR (50)  NULL,
    [auulo_denominazione]                  VARCHAR (405) NULL,
    [auulo_data_apertura]                  DATETIME      NULL,
    [auulo_flag_cessazione]                VARCHAR (1)   NULL,
    [auulo_data_cessazione]                DATETIME      NULL,
    [auulo_data_denuncia_cessazione]       DATETIME      NULL,
    [auulo_descr_sotto_tipo1]              VARCHAR (100) NULL,
    [auulo_sotto_tipo1]                    VARCHAR (5)   NULL,
    [auulo_descr_sotto_tipo2]              VARCHAR (100) NULL,
    [auulo_sotto_tipo2]                    VARCHAR (5)   NULL,
    [auulo_descr_sotto_tipo3]              VARCHAR (100) NULL,
    [auulo_sotto_tipo3]                    VARCHAR (5)   NULL,
    [auulo_descr_sotto_tipo4]              VARCHAR (100) NULL,
    [auulo_sotto_tipo4]                    VARCHAR (5)   NULL,
    [auulo_descr_sotto_tipo5]              VARCHAR (100) NULL,
    [auulo_sotto_tipo5]                    VARCHAR (5)   NULL,
    [auulo_codice_comune]                  VARCHAR (3)   NULL,
    [auulo_comune]                         VARCHAR (30)  NULL,
    [auulo_sigla_prov]                     VARCHAR (2)   NULL,
    [auulo_toponimo]                       VARCHAR (3)   NULL,
    [auulo_descr_toponimo]                 VARCHAR (253) NULL,
    [auulo_via]                            VARCHAR (30)  NULL,
    [auulo_civico]                         VARCHAR (8)   NULL,
    [auulo_cap]                            VARCHAR (5)   NULL,
    [auulo_codice_stato_estero]            VARCHAR (3)   NULL,
    [auulo_stato_estero]                   VARCHAR (100) NULL,
    [auulo_frazione]                       VARCHAR (100) NULL,
    [Auulo_nrea_ul]                        VARCHAR (20)  NULL,
    [Auulo_nrea_ul_cciaa]                  VARCHAR (2)   NULL,
    [auulo_data_modifica]                  DATETIME      NULL,
    [auulo_descr_utente]                   VARCHAR (50)  NULL,
    [auulo_codice_pk_db2]                  BIGINT        NULL,
    [auulo_rec_del]                        VARCHAR (1)   NULL,
    [auulo_data_del]                       DATETIME      NULL,
    [auulo_altre_indicazioni]              VARCHAR (255) NULL,
    [auulo_auate_codice_pk]                INT           NULL,
    [auulo_Cod_Ateco2007]                  VARCHAR (10)  NULL,
    [auulo_DataInizio]                     DATE          NULL,
    [auulo_DesAteco2007]                   VARCHAR (255) NULL,
    [auulo_Importanza]                     VARCHAR (255) NULL,
    [auulo_insegna]                        VARCHAR (50)  NULL,
    [auulo_cod_istat_comune]               VARCHAR (5)   NULL,
    [auulo_cod_stradario]                  VARCHAR (5)   NULL,
    [auulo_telefono]                       VARCHAR (16)  NULL,
    [auulo_fax]                            VARCHAR (16)  NULL,
    [auulo_cod_causa_cess]                 VARCHAR (2)   NULL,
    [auulo_art_categoria]                  VARCHAR (2)   NULL,
    [auulo_art_descr_categoria]            VARCHAR (50)  NULL,
    [auulo_art_num_iscrizione_ruolo]       VARCHAR (20)  NULL,
    [auulo_art_provincia_iscrizione_ruolo] VARCHAR (20)  NULL,
    [auulo_art_data_accertamento]          DATE          NULL,
    [auulo_art_data_domanda]               DATE          NULL,
    [auulo_art_data_domanda_accertamento]  DATE          NULL,
    [auulo_art_data_iscrizione]            DATE          NULL,
    [auulo_art_data_delibera]              DATE          NULL,
    [auulo_art_data_iscrizione_inizio]     DATE          NULL,
    [auulo_art_data_inizio]                DATE          NULL,
    [auulo_art_info_suppl]                 VARCHAR (200) NULL,
    [auulo_art_causale_cess]               VARCHAR (2)   NULL,
    [auulo_art_descr_causale_cess]         VARCHAR (100) NULL,
    [auulo_art_data_domanda_accert_cess]   DATE          NULL,
    [auulo_art_data_delibera_cess]         DATE          NULL,
    [auulo_art_data_cessazione]            DATE          NULL,
    [auulo_art_descrizione_attivita]       VARCHAR (200) NULL,
    CONSTRAINT [PK_tb_auulo] PRIMARY KEY CLUSTERED ([auulo_codice_pk] ASC),
    CONSTRAINT [FK_auulo_ausca] FOREIGN KEY ([auulo_ausca_codice_pk]) REFERENCES [dbo].[tb_ausca_sog_contr_az] ([ausca_codice_pk]),
    CONSTRAINT [UQ_auulo_auulo] UNIQUE NONCLUSTERED ([auulo_codice_pk] ASC)
);

