CREATE TABLE [dbo].[tb_gsrss_aurss_gestione_separata] (
    [gsrss_ausca_codice_pk]             INT           NULL,
    [gsrss_ausca_codice_fiscale]        VARCHAR (16)  NULL,
    [gsrss_aurrs_data_inizio_validita]  DATE          NULL,
    [gsrss_aurss_data_di_fine_validita] DATE          NULL,
    [gsrss_ausco_codice_fiscale]        VARCHAR (16)  NULL,
    [gsrss_ausco_email]                 VARCHAR (200) NULL,
    [gsrss_ausco_fax]                   VARCHAR (20)  NULL,
    [gsrss_ausco_legalmail]             VARCHAR (200) NULL,
    [gsrss_ausco_pec]                   VARCHAR (200) NULL,
    [gsrss_ausco_telefono]              VARCHAR (20)  NULL,
    [gsrss_ausco_tipo_persona]          VARCHAR (1)   NULL,
    [gsrss_autis_codice_carica]         VARCHAR (3)   NULL,
    [gsrss_autis_descr]                 VARCHAR (100) NULL,
    [gsrss_descrizione_fonte]           VARCHAR (100) NULL,
    [gsrss_tipologia_fonte]             VARCHAR (100) NULL,
    [gsrss_data_modifica]               DATETIME      CONSTRAINT [DF_tb_gsrss_aurss_gestione_separata_gsrss_data_modifica] DEFAULT (getdate()) NULL
);

