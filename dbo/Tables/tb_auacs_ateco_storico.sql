﻿CREATE TABLE [dbo].[tb_auacs_ateco_storico] (
    [auacs_codice_pk]                INT           IDENTITY (1, 1) NOT NULL,
    [auate_codice_pk]                INT           NOT NULL,
    [auate_cod_ateco_complessivo]    VARCHAR (15)  NULL,
    [auate_cod_sezione]              VARCHAR (1)   NULL,
    [auate_cod_sezione_tit]          VARCHAR (200) NULL,
    [auate_cod_sezione_descr]        VARCHAR (200) NULL,
    [auate_cod_divisione]            VARCHAR (2)   NULL,
    [auate_cod_divisione_tit]        VARCHAR (200) NULL,
    [auate_cod_divisione_descr]      VARCHAR (200) NULL,
    [auate_cod_gruppo]               VARCHAR (1)   NULL,
    [auate_cod_gruppo_tit]           VARCHAR (200) NULL,
    [auate_cod_gruppo_descr]         VARCHAR (200) NULL,
    [auate_cod_classe]               VARCHAR (1)   NULL,
    [auate_cod_classe_tit]           VARCHAR (200) NULL,
    [auate_cod_classe_descr]         VARCHAR (200) NULL,
    [auate_cod_categoria]            VARCHAR (1)   NULL,
    [auate_cod_categoria_tit]        VARCHAR (200) NULL,
    [auate_cod_categoria_descr]      VARCHAR (200) NULL,
    [auate_cod_sottocategoria]       VARCHAR (1)   NULL,
    [auate_cod_sottocategoria_tit]   VARCHAR (200) NULL,
    [auate_cod_sottocategoria_descr] VARCHAR (200) NULL,
    [auate_cod_seconda_coppia]       VARCHAR (2)   NULL,
    [auate_cod_terza_coppia]         VARCHAR (2)   NULL,
    [auate_note]                     VARCHAR (200) NULL,
    [auate_anno_riferimento]         INT           NULL,
    [auate_codatt]                   VARCHAR (15)  NULL,
    [auate_istat_code]               VARCHAR (15)  NULL,
    [auate_data_modifica]            DATETIME      NULL,
    [auate_descr_utente]             VARCHAR (50)  NULL,
    [auate_codice_pk_db2]            INT           NULL,
    [auacs_data_storicizza]          DATETIME      NULL,
    [auacs_descr_utente]             VARCHAR (50)  NULL,
    [auacs_motivo]                   VARCHAR (200) NULL,
    [auacs_tipo_intervento]          VARCHAR (1)   NULL
);
