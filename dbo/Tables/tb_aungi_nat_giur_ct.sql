CREATE TABLE [dbo].[tb_aungi_nat_giur_ct] (
    [aungi_codice_pk]     INT           IDENTITY (1, 1) NOT NULL,
    [aungi_codice_forma]  VARCHAR (2)   NULL,
    [aungi_descr_breve]   VARCHAR (20)  NULL,
    [aungi_descr_lunga]   VARCHAR (100) NULL,
    [aungi_data_modifica] DATETIME      NULL,
    [aungi_descr_utente]  VARCHAR (50)  NULL,
    [aungi_codice_pk_db2] INT           NULL,
    [aungi_descr_altern]  VARCHAR (100) NULL,
    [aungi_iscr_ccia]     BIT           CONSTRAINT [DF_tb_aungi_nat_giur_ct_iscr_ccia] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_tb_aungi] PRIMARY KEY CLUSTERED ([aungi_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aungi_naungi] UNIQUE NONCLUSTERED ([aungi_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

