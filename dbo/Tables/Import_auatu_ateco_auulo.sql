CREATE TABLE [dbo].[Import_auatu_ateco_auulo] (
    [St_auatu_codice_fiscale_ausca]  VARCHAR (16)  NULL,
    [St_auatu_ausca_codice_pk]       INT           NULL,
    [St_auatu_progressivo]           INT           NULL,
    [St_auatu_dt_aperturaUL]         DATE          NULL,
    [St_auatu_cod_comuneUL]          VARCHAR (3)   NULL,
    [St_auatu_provinciaUL]           VARCHAR (2)   NULL,
    [St_auatu_dt_chiusuraUL]         DATE          NULL,
    [St_auatu_auulo_codice_pk]       INT           NULL,
    [St_auatu_classificazione_ateco] VARCHAR (4)   NULL,
    [St_auatu_cod_att_input]         VARCHAR (8)   NULL,
    [St_auatu_cod_att_output]        VARCHAR (6)   NULL,
    [St_auatu_descr_attivita]        VARCHAR (200) NULL,
    [St_auatu_cod_importanza]        VARCHAR (1)   NULL,
    [St_auatu_importanza]            VARCHAR (50)  NULL,
    [St_auatu_dt_inizio]             DATE          NULL,
    [St_auatu_dt_fine]               DATE          NULL,
    [St_auatu_dt_riferimento]        DATE          NULL,
    [St_auatu_data_modifica]         DATETIME      NULL,
    [St_auatu_descr_utente]          VARCHAR (50)  NULL
);

