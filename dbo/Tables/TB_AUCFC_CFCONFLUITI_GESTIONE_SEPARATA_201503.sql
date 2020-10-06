CREATE TABLE [dbo].[TB_AUCFC_CFCONFLUITI_GESTIONE_SEPARATA_201503] (
    [AUCFC_CODICE_PK]         INT          NOT NULL,
    [Aucfc_codice_gestione]   VARCHAR (50) NULL,
    [Aucfc_cf]                VARCHAR (16) NULL,
    [Aucfc_stato]             VARCHAR (20) NULL,
    [Aucfc_motivo_cessazione] VARCHAR (60) NULL,
    [Aucfc_data_inizio]       DATETIME     NULL,
    [Aucfc_data_fine]         DATETIME     NULL,
    [Aucfc_cf_confluenza]     VARCHAR (16) NULL,
    [AUCFC_DATA_MODIFICA]     DATETIME     NULL,
    [AUCFC_STATO_LAVORAZIONE] INT          NULL,
    [AUCFC_CODICE_LOTTO]      INT          NULL,
    [AUFC_CODICE_AUSCA]       INT          NULL
);

