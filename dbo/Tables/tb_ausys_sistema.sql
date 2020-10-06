CREATE TABLE [dbo].[tb_ausys_sistema] (
    [ausys_codice_pk]     INT           IDENTITY (1, 1) NOT NULL,
    [ausys_parametro]     VARCHAR (50)  NULL,
    [ausys_descr_breve]   VARCHAR (50)  NULL,
    [ausys_descr_lunga]   VARCHAR (200) NULL,
    [ausys_data_modifica] DATETIME      NULL,
    [ausys_descr_utente]  VARCHAR (50)  NULL,
    [ausys_valore]        VARCHAR (200) NULL,
    CONSTRAINT [PK_tb_ausys] PRIMARY KEY CLUSTERED ([ausys_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_ausys_ausys] UNIQUE NONCLUSTERED ([ausys_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

