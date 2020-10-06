CREATE TABLE [dbo].[TB_AUOSO_OPERAZIONE_SOCIETARIA] (
    [auoso_codice_pk]                  BIGINT        IDENTITY (1, 1) NOT NULL,
    [auoso_tipo_operazione]            CHAR (1)      NULL,
    [auoso_codice_fiscale_riferimento] VARCHAR (16)  NULL,
    [auoso_posizione_riferimento]      VARCHAR (50)  NULL,
    [auoso_descr_operazione]           VARCHAR (200) NULL,
    [auoso_data_operazione]            DATE          NULL,
    [auoso_stato_operazione]           VARCHAR (20)  NULL,
    [auoso_CSC_posizione_riferimento]  VARCHAR (5)   NULL,
    [auoso_CA_posizione_riferimento]   VARCHAR (60)  NULL,
    [auoso_codice_fiscale_delegato]    VARCHAR (16)  NULL,
    [auoso_codice_operatore]           VARCHAR (8)   NULL,
    [auoso_azione_effettuata]          VARCHAR (1)   NULL,
    [auoso_data_azione]                DATE          NULL,
    [auoso_aupoc_codice_pk]            INT           NULL,
    [auoso_data_modifica]              DATETIME      NULL,
    [auoso_descr_utente]               VARCHAR (50)  NULL,
    [auoso_note]                       VARCHAR (200) NULL,
    CONSTRAINT [PK_tb_auoso] PRIMARY KEY CLUSTERED ([auoso_codice_pk] ASC),
    CONSTRAINT [UQ_auoso_auoso] UNIQUE NONCLUSTERED ([auoso_codice_pk] ASC)
);

