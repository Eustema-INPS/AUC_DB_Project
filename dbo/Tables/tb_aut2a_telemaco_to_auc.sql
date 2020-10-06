CREATE TABLE [dbo].[tb_aut2a_telemaco_to_auc] (
    [aut2a_codice_pk]          INT            IDENTITY (1, 1) NOT NULL,
    [aut2a_ausca_codice_pk]    INT            NULL,
    [aut2a_codice_fiscale]     VARCHAR (16)   NULL,
    [aut2a_PEC]                VARCHAR (162)  NULL,
    [aut2a_visura]             XML            NULL,
    [aut2a_priorita]           TINYINT        NULL,
    [aut2a_stato_lavorazione]  VARCHAR (1)    NULL,
    [aut2a_numero_lotto]       INT            NULL,
    [aut2a_data_inserimento]   DATETIME       NULL,
    [aut2a_messaggio_errore]   NVARCHAR (MAX) NULL,
    [aut2a_data_aggiornamento] DATETIME       NULL,
    [aut2a_id_utente]          NVARCHAR (50)  NULL,
    [aut2a_soap_request]       XML            NULL,
    [aut2a_soap_response]      XML            NULL,
    [Aut2a_estrazione_PEC]     INT            NULL,
    [aut2a_estrazione_RL]      INT            NULL,
    [aut2a_estrazione_STATO]   INT            NULL,
    [aut2a_aggiorna_ausca]     INT            NULL,
    CONSTRAINT [PK_tb_aut2a_telemaco_to_auc] PRIMARY KEY CLUSTERED ([aut2a_codice_pk] ASC)
);

