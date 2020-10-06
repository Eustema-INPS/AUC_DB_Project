CREATE TABLE [dbo].[tb_gssca_ausca_gestione_separata] (
    [gssca_ausca_codice_pk]               INT           NULL,
    [gssca_ausca_codice_fiscale]          VARCHAR (16)  NULL,
    [gssca_ausca_n_rea]                   VARCHAR (20)  NULL,
    [gssca_aungi_codice_forma]            VARCHAR (2)   NULL,
    [gssca_aungi_nat_giur_ct_descr_lunga] VARCHAR (100) NULL,
    [gssca_ausca_pec]                     VARCHAR (200) NULL,
    [gssca_ausca_cciaa]                   VARCHAR (2)   NULL,
    [gssca_ausca_email]                   VARCHAR (200) NULL,
    [gssca_ausca_fax]                     VARCHAR (20)  NULL,
    [gssca_ausca_legalmail]               VARCHAR (200) NULL,
    [gssca_ausca_soggetto_certificato]    VARCHAR (1)   NULL,
    [gssca_ausca_telefono1]               VARCHAR (20)  NULL,
    [gssca_ausca_telefono2]               VARCHAR (20)  NULL,
    [gssca_ausca_telefono3]               VARCHAR (20)  NULL,
    [gssca_ausca_telex]                   VARCHAR (20)  NULL,
    [gssca_ausca_utente_applicazione]     VARCHAR (100) NULL,
    [gssca_descr_soggetto_certificatore]  VARCHAR (100) NULL,
    [gssca_data_modifica]                 DATETIME      CONSTRAINT [DF_tb_gssca_ausca_gestione_separata_gssca_data_modifica] DEFAULT (getdate()) NULL
);

