CREATE TABLE [dbo].[TB_AULAT_LISTA_ATTIVITA_GESTIONE_SEPARATA] (
    [AULAT_CODICE_PK]            INT           IDENTITY (1, 1) NOT NULL,
    [Aulat_codice_gestione]      VARCHAR (50)  NULL,
    [Aulat_data_inizio_attivita] DATETIME      NULL,
    [Aulat_provenienza]          VARCHAR (30)  NULL,
    [Aulat_data_inserimento]     DATETIME      NULL,
    [Aulat_cf]                   VARCHAR (16)  NULL,
    [Aulat_data_cf]              DATETIME      NULL,
    [Aulat_protocollo]           VARCHAR (10)  NULL,
    [Aulat_note]                 VARCHAR (100) NULL,
    [Aulat_categoria]            VARCHAR (50)  NULL,
    [AULAT_DATA_MODIFICA]        DATETIME      CONSTRAINT [DF_TB_AULAT_LISTA_ATTIVITA_GESTIONE_SEPARATA_AULAT_DATA_MODIFICA] DEFAULT (getdate()) NULL,
    [AULAT_STATO_LAVORAZIONE]    INT           CONSTRAINT [DF_TB_AULAT_LISTA_ATTIVITA_GESTIONE_SEPARATA_AULAT_STATO_LAVORAZIONE] DEFAULT ((0)) NULL,
    [AULAT_CODICE_LOTTO]         INT           CONSTRAINT [DF_TB_AULAT_LISTA_ATTIVITA_GESTIONE_SEPARATA_AULAT_CODICE_LOTTO] DEFAULT ((0)) NULL,
    [AULAT_CODICE_AUSCA]         INT           NULL
);

