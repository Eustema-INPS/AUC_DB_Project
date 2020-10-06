CREATE TABLE [dbo].[TB_AUSGO_STORICO_GIORNALIERO_OSIRIDE] (
    [ausgo_codice_pk]         BIGINT        IDENTITY (1, 1) NOT NULL,
    [ausgo_Lotto]             BIGINT        NULL,
    [ausgo_CodiceFiscale]     VARCHAR (16)  NULL,
    [ausgo_DataEstrazione]    DATE          NULL,
    [ausgo_nome_file_osiride] VARCHAR (255) NULL,
    [ausgo_data_modifica]     DATETIME      NULL,
    [ausgo_descr_utente]      VARCHAR (50)  NULL
);

