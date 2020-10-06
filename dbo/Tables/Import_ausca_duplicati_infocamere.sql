CREATE TABLE [dbo].[Import_ausca_duplicati_infocamere] (
    [St_ausca_codice_pk]            INT            NULL,
    [St_ausca_denominazione]        VARCHAR (405)  NULL,
    [St_ausca_codice_fiscale]       VARCHAR (16)   NULL,
    [St_ausca_cciaa]                VARCHAR (2)    NULL,
    [St_ausca_Data_Inizio_Attivita] DATE           NULL,
    [St_ausca_Filename]             VARCHAR (1000) NULL,
    [St_ausca_Numero_REA]           VARCHAR (20)   NULL,
    [St_FLAG_1]                     TINYINT        NULL,
    [St_ausca_data_modifica]        DATETIME       NULL,
    [St_ausca_descr_utente]         VARCHAR (50)   NULL
);

