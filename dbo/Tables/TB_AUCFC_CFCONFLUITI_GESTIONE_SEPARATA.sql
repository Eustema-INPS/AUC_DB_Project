﻿CREATE TABLE [dbo].[TB_AUCFC_CFCONFLUITI_GESTIONE_SEPARATA] (
    [AUCFC_CODICE_PK]         INT          IDENTITY (1, 1) NOT NULL,
    [Aucfc_codice_gestione]   VARCHAR (50) NULL,
    [Aucfc_cf]                VARCHAR (16) NULL,
    [Aucfc_stato]             VARCHAR (20) NULL,
    [Aucfc_motivo_cessazione] VARCHAR (60) NULL,
    [Aucfc_data_inizio]       DATETIME     NULL,
    [Aucfc_data_fine]         DATETIME     NULL,
    [Aucfc_cf_confluenza]     VARCHAR (16) NULL,
    [AUCFC_DATA_MODIFICA]     DATETIME     CONSTRAINT [DF_TB_AUCFC_CFCONFLUITI_GESTIONE_SEPARATA_AUCFC_DATA_MODIFICA] DEFAULT (getdate()) NULL,
    [AUCFC_STATO_LAVORAZIONE] INT          CONSTRAINT [DF_TB_AUCFC_CFCONFLUITI_GESTIONE_SEPARATA_AUCFC_STATO_LAVORAZIONE] DEFAULT ((0)) NULL,
    [AUCFC_CODICE_LOTTO]      INT          CONSTRAINT [DF_TB_AUCFC_CFCONFLUITI_GESTIONE_SEPARATA_AUCFC_CODICE_LOTTO] DEFAULT ((0)) NULL,
    [AUFC_CODICE_AUSCA]       INT          NULL
);

