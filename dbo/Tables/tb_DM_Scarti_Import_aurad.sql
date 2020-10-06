CREATE TABLE [dbo].[tb_DM_Scarti_Import_aurad] (
    [St_aurad_DM_posizione]              VARCHAR (10)  NULL,
    [St_aurad_sede_provinciale]          INT           NULL,
    [St_aurad_matricola_azienda]         INT           NULL,
    [St_aurad_controcod_matr_az]         INT           NULL,
    [St_aurad_DM_CodiceFiscalePosizione] VARCHAR (16)  NULL,
    [St_aurad_CodiceCarica]              VARCHAR (1)   NULL,
    [St_aurad_CodicefiscaleSoggetto]     VARCHAR (16)  NULL,
    [St_aurad_data_inizio_validita]      VARCHAR (MAX) NULL,
    [St_aurad_data_di_fine_validità]     VARCHAR (MAX) NULL,
    [St_aurad_aupoc_codice_pk]           INT           NULL,
    [St_aurad_audel_codice_pk]           INT           NULL,
    [St_aurad_autid_codice_pk]           INT           NULL,
    [St_aurad_aussu_codice_pk]           INT           NULL,
    [St_aurad_flag_operativo]            INT           NULL,
    [St_aurad_data_modifica]             DATETIME      NULL,
    [St_aurad_descr_utente]              VARCHAR (MAX) NULL,
    [ErrorNum]                           VARCHAR (MAX) NULL,
    [ErrorDescription]                   VARCHAR (MAX) NULL,
    [NoteScartoErrori]                   VARCHAR (MAX) NULL
);

