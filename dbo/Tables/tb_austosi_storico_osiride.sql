CREATE TABLE [dbo].[tb_austosi_storico_osiride] (
    [austosi_codice_pk]                  INT           IDENTITY (1, 1) NOT NULL,
    [austosi_ausca_codice_pk]            INT           NULL,
    [austosi_codice_fiscale]             VARCHAR (16)  NULL,
    [austosi_nome_file]                  VARCHAR (255) NULL,
    [austosi_data_registrazione_osiride] DATETIME      NULL,
    [austosi_data_modifica]              DATETIME      CONSTRAINT [DF_tb_austosi_storico_osiride_data_modifica] DEFAULT (getdate()) NULL,
    [austosi_descr_utente]               VARCHAR (50)  NULL
);

