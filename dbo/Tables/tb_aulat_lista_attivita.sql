CREATE TABLE [dbo].[tb_aulat_lista_attivita] (
    [aulat_codice_pk]            INT           IDENTITY (1, 1) NOT NULL,
    [aulat_ausca_codice_PK]      INT           NOT NULL,
    [aulat_codice_gestione]      VARCHAR (50)  NULL,
    [aulat_data_inizio_attivita] DATETIME      NULL,
    [aulat_provenienza]          VARCHAR (30)  NULL,
    [aulat_data_inserimento]     DATETIME      NULL,
    [aulat_cf]                   VARCHAR (16)  NULL,
    [aulat_data_cf]              DATETIME      NULL,
    [aulat_protocollo]           VARCHAR (10)  NULL,
    [aulat_note]                 VARCHAR (100) NULL,
    [aulat_categoria]            VARCHAR (50)  NULL,
    [aulat_data_modifica]        DATETIME      CONSTRAINT [DF_TB_aulat_LISTA_ATTIVITA_DATA_MODIFICA] DEFAULT (getdate()) NULL,
    [aulat_descr_utente]         VARCHAR (50)  NULL,
    [aulat_rec_del]              VARCHAR (1)   NULL,
    [aulat_data_del]             DATETIME      NULL
);

