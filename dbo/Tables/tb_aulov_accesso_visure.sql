CREATE TABLE [dbo].[tb_aulov_accesso_visure] (
    [aulov_codice_pk]        INT           IDENTITY (1, 1) NOT NULL,
    [aulov_codfisc_soggetto] VARCHAR (16)  NULL,
    [aulov_tipo_ricerca]     VARCHAR (1)   NULL,
    [aulov_descr_tr]         VARCHAR (100) NULL,
    [aulov_data_modifica]    DATETIME      NULL,
    [aulov_descr_utente]     VARCHAR (50)  NULL
);

