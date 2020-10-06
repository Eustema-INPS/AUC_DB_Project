CREATE TABLE [dbo].[tb_ausvi_visura_soggetto] (
    [ausvi_codice_pk]                  INT           IDENTITY (1, 1) NOT NULL,
    [ausvi_ausca_codice_pk]            INT           NULL,
    [ausvi_codice_fiscale]             VARCHAR (16)  NULL,
    [ausvi_visura]                     XML           NULL,
    [ausvi_data_riferimento]           DATETIME      NULL,
    [ausvi_primo_stato]                INT           CONSTRAINT [DF_tb_ausvi_visura_soggetto_ausvi_primo_stato] DEFAULT ((0)) NULL,
    [ausvi_secondo_stato]              INT           CONSTRAINT [DF_tb_ausvi_visura_soggetto_ausvi_secondo_stato] DEFAULT ((0)) NULL,
    [ausvi_terzo_stato]                INT           CONSTRAINT [DF_tb_ausvi_visura_soggetto_ausvi_terzo_stato] DEFAULT ((0)) NULL,
    [ausvi_data_modifica]              DATETIME      CONSTRAINT [DF_tb_ausvi_visura_soggetto_ausvi_data_modifica] DEFAULT (getdate()) NULL,
    [ausvi_descr_utente]               VARCHAR (50)  NULL,
    [ausvi_PEC]                        VARCHAR (160) NULL,
    [ausvi_DataEstrazione]             VARCHAR (10)  NULL,
    [ausvi_data_registrazione_osiride] DATETIME      NULL
);

