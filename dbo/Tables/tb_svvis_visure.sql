﻿CREATE TABLE [dbo].[tb_svvis_visure] (
    [svvis_codice_pk]                 BIGINT        IDENTITY (1, 1) NOT NULL,
    [svvis_id_Key]                    INT           NULL,
    [svvis_messageID]                 VARCHAR (250) NULL,
    [svvis_msgID]                     VARCHAR (250) NULL,
    [svvis_from_PEC]                  VARCHAR (250) NULL,
    [svvis_from_msg]                  VARCHAR (250) NULL,
    [svvis_posted_data]               DATETIME      NULL,
    [svvis_delivered_data]            DATETIME      NULL,
    [svvis_subject_PEC]               VARCHAR (500) NULL,
    [svvis_subject]                   VARCHAR (500) NULL,
    [svvis_body_PEC]                  VARCHAR (MAX) NULL,
    [svvis_body]                      VARCHAR (MAX) NULL,
    [svvis_IdPratica]                 VARCHAR (20)  NULL,
    [svvis_tipo]                      VARCHAR (50)  NULL,
    [svvis_stato]                     VARCHAR (5)   NULL,
    [svvis_dettaglio_stato]           VARCHAR (500) NULL,
    [svvis_segnatura_mittente]        VARCHAR (50)  NULL,
    [svvis_segnatura_INPS_E]          VARCHAR (50)  NULL,
    [svvis_segnatura_INPS_U]          VARCHAR (50)  NULL,
    [svvis_messaggio]                 IMAGE         NULL,
    [svvis_data_ultimo_aggiornamento] DATETIME      NULL,
    [svvis_area]                      VARCHAR (10)  NULL,
    [svvis_generica]                  VARCHAR (2)   NULL,
    [svvis_codice_fiscale]            VARCHAR (16)  NULL,
    [svvis_visura_xml]                XML           NULL,
    [svvis_data_modifica]             DATETIME      NULL,
    [svvis_descr_utente]              VARCHAR (50)  NULL,
    [svvis_lotto]                     VARCHAR (8)   NULL
);

