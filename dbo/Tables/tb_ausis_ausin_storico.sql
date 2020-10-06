CREATE TABLE [dbo].[tb_ausis_ausin_storico] (
    [ausis_codice_pk]           INT           IDENTITY (1, 1) NOT NULL,
    [ausin_codice_pk]           INT           NULL,
    [ausin_codice_sede]         VARCHAR (4)   NULL,
    [ausin_descr]               VARCHAR (30)  NULL,
    [ausin_codice_regione]      VARCHAR (2)   NULL,
    [ausin_descrizione_regione] VARCHAR (100) NULL,
    [ausin_ordinamento]         INT           NULL,
    [ausin_data_modifica]       DATETIME      NULL,
    [ausin_descr_utente]        VARCHAR (50)  NULL,
    [ausin_codice_pk_db2]       INT           NULL,
    [ausis_data_storicizza]     DATETIME      NULL,
    [ausis_descr_utente]        VARCHAR (50)  NULL,
    [ausis_motivo]              VARCHAR (200) NULL,
    [ausis_tipo_intervento]     VARCHAR (1)   NULL
);

