CREATE TABLE [dbo].[TB_AULAT_LISTA_ATTIVITA_GESTIONE_SEPARATA_201503] (
    [AULAT_CODICE_PK]            INT           NOT NULL,
    [Aulat_codice_gestione]      VARCHAR (50)  NULL,
    [Aulat_data_inizio_attivita] DATETIME      NULL,
    [Aulat_provenienza]          VARCHAR (30)  NULL,
    [Aulat_data_inserimento]     DATETIME      NULL,
    [Aulat_cf]                   VARCHAR (16)  NULL,
    [Aulat_data_cf]              DATETIME      NULL,
    [Aulat_protocollo]           VARCHAR (10)  NULL,
    [Aulat_note]                 VARCHAR (100) NULL,
    [Aulat_categoria]            VARCHAR (50)  NULL,
    [AULAT_DATA_MODIFICA]        DATETIME      NULL,
    [AULAT_STATO_LAVORAZIONE]    INT           NULL,
    [AULAT_CODICE_LOTTO]         INT           NULL,
    [AULAT_CODICE_AUSCA]         INT           NULL
);

