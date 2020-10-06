CREATE TABLE [dbo].[Import_auata_ateco_ausca] (
    [St_auata_codice_fiscale_ausca]  VARCHAR (16)  NULL,
    [St_auata_ausca_codice_pk]       INT           NULL,
    [St_auata_classificazione_ateco] VARCHAR (4)   NULL,
    [St_auata_cod_att_input]         VARCHAR (8)   NULL,
    [St_auata_cod_att_output]        VARCHAR (6)   NULL,
    [St_auata_descr_attivita]        VARCHAR (200) NULL,
    [St_auata_cod_importanza]        VARCHAR (1)   NULL,
    [St_auata_importanza]            VARCHAR (50)  NULL,
    [St_auata_dt_inizio]             DATE          NULL,
    [St_auata_dt_fine]               DATE          NULL,
    [St_auata_dt_riferimento]        DATE          NULL,
    [St_auata_data_modifica]         DATETIME      NULL,
    [St_auata_descr_utente]          VARCHAR (50)  NULL
);

