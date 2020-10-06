CREATE TABLE [dbo].[tb_audb2_verso_db2] (
    [audb2_codice_fiscale]    VARCHAR (16)  NULL,
    [audb2_sede_provinciale]  INT           NULL,
    [audb2_matricola_azienda] INT           NULL,
    [audb2_controcod_matr_az] INT           NULL,
    [audb2_pec]               VARCHAR (160) NULL,
    [audb2_stato_pec]         INT           CONSTRAINT [DF_tb_audb2_verso_db2_audb2_stato_pec] DEFAULT ((0)) NULL,
    [audb2_data_modifica]     DATETIME      CONSTRAINT [DF_tb_audb2_verso_db2_audb2_data_modifica] DEFAULT (getdate()) NULL,
    [audb2_descr_utente]      VARCHAR (50)  CONSTRAINT [DF_tb_audb2_verso_db2_audb2_descr_utente] DEFAULT ('SSIS Infocamere') NULL
);

