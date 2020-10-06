CREATE TABLE [dbo].[Appo_Aufor] (
    [aufor_aupoc_codice_pk]      INT           NULL,
    [aufor_posizione]            VARCHAR (50)  NULL,
    [aufor_annomese]             INT           NULL,
    [aufor_num_dip_dic]          INT           NULL,
    [aufor_utente_dic]           VARCHAR (50)  NULL,
    [aufor_data_dic]             DATETIME2 (3) NULL,
    [aufor_num_dip_dic_mod]      INT           NULL,
    [aufor_utente_dic_mod]       VARCHAR (50)  NULL,
    [aufor_data_dic_mod]         DATETIME2 (3) NULL,
    [aufor_num_dip_cert]         INT           NULL,
    [aufor_utente_cert]          VARCHAR (50)  NULL,
    [aufor_data_cert]            DATETIME2 (3) NULL,
    [aufor_num_dip_cert_mod]     INT           NULL,
    [aufor_utente_cert_mod]      VARCHAR (50)  NULL,
    [aufor_data_cert_mod]        DATETIME2 (3) NULL,
    [aufor_tipo_dic]             VARCHAR (10)  NULL,
    [aufor_stato_certificazione] INT           NULL,
    [aufor_data_modifica]        DATETIME2 (3) NULL,
    [aufor_descr_utente]         VARCHAR (50)  NULL,
    [aufor_codice_pk_db2]        INT           NULL
);

