CREATE TABLE [dbo].[tb_aueva_elenco_variabili] (
    [aueva_nome_var]      VARCHAR (50) NOT NULL,
    [aueva_sequenza]      INT          NULL,
    [aueva_descr_var]     VARCHAR (50) NULL,
    [aueva_data_modifica] DATETIME     NULL,
    [aueva_descr_utente]  VARCHAR (50) NULL,
    CONSTRAINT [PK_tb_aueva] PRIMARY KEY CLUSTERED ([aueva_nome_var] ASC) WITH (FILLFACTOR = 90)
);

