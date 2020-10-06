CREATE TABLE [dbo].[tb_aupoe_PosizioniErrate_Aursp] (
    [aupoc_posizione]             VARCHAR (50)  NULL,
    [ausco_codice_fiscale]        VARCHAR (16)  NOT NULL,
    [aursp_aupoc_codice_pk]       INT           NOT NULL,
    [aursp_ausco_codice_pk]       INT           NOT NULL,
    [aursp_aussu_codice_pk]       INT           NULL,
    [aursp_autis_codice_pk]       INT           NULL,
    [aursp_data_inizio_validita]  DATETIME2 (3) NULL,
    [aursp_data_di_fine_validita] DATETIME2 (3) NULL,
    [aursp_note]                  VARCHAR (200) NULL,
    [aursp_rappresentante_legale] VARCHAR (1)   NULL,
    [aursp_data_modifica]         DATETIME2 (3) NULL,
    [aursp_descr_utente]          VARCHAR (50)  NULL,
    [aursp_cert_auten_cod_pk]     INT           NULL,
    [aursp_cert_cod_entita_rif]   INT           NULL,
    [aursp_cert_data_modifica]    DATETIME2 (3) NULL,
    [aursp_auten_codice_pk]       INT           NULL,
    [aursp_codice_entita_rif]     INT           NULL,
    [aursp_tipo_soggetto]         VARCHAR (2)   NULL,
    [aursp_data_domanda]          DATETIME2 (3) NULL,
    [aursp_tipo_domanda]          VARCHAR (5)   NULL
);

