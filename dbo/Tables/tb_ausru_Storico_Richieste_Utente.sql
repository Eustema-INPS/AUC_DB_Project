CREATE TABLE [dbo].[tb_ausru_Storico_Richieste_Utente] (
    [ausru_codice_pk]                BIGINT        IDENTITY (1, 1) NOT NULL,
    [ausru_codice_fiscale]           VARCHAR (16)  NULL,
    [ausru_posizione]                VARCHAR (50)  NULL,
    [ausru_utente_richiesta]         VARCHAR (255) NULL,
    [ausru_identificativo_richiesta] VARCHAR (20)  DEFAULT ('--') NULL,
    [ausru_data_inizio_elaborazione] DATETIME      NULL,
    [ausru_data_fine_elaborazione]   DATETIME      NULL,
    [ausru_stato_lavorazione]        INT           DEFAULT ((0)) NULL,
    [ausru_tipo_richiesta]           VARCHAR (3)   NULL,
    [ausru_file_da_elaborare]        VARCHAR (255) NULL,
    [ausru_data_richiesta]           DATETIME      NULL,
    [ausru_data_caricamento]         DATETIME      NULL,
    [ausru_data_analisi]             DATETIME      NULL,
    [ausru_data_annullamento]        DATETIME      NULL,
    [ausru_data_aggiornamento]       DATETIME      NULL,
    [ausru_data_modifica]            DATETIME      DEFAULT (getdate()) NULL,
    [ausru_descr_utente]             VARCHAR (50)  NULL
);

