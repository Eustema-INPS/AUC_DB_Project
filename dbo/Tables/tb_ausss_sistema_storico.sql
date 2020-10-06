CREATE TABLE [dbo].[tb_ausss_sistema_storico] (
    [ausss_codice_pk]       INT           IDENTITY (1, 1) NOT NULL,
    [ausys_codice_pk]       INT           NOT NULL,
    [ausys_parametro]       VARCHAR (50)  NULL,
    [ausys_descr_breve]     VARCHAR (50)  NULL,
    [ausys_descr_lunga]     VARCHAR (200) NULL,
    [ausys_data_modifica]   DATETIME      NULL,
    [ausys_descr_utente]    VARCHAR (50)  NULL,
    [ausys_valore]          VARCHAR (200) NULL,
    [ausss_data_storicizza] DATETIME      NULL,
    [ausss_descr_utente]    VARCHAR (50)  NULL,
    [ausss_motivo]          VARCHAR (200) NULL,
    [ausss_tipo_intervento] VARCHAR (1)   NULL
);

