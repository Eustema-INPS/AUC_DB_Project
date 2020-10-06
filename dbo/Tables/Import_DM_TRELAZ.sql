CREATE TABLE [dbo].[Import_DM_TRELAZ] (
    [St_aurss_DM_posizione]              VARCHAR (10)  NULL,
    [St_aurss_sede_provinciale]          INT           NULL,
    [St_aurss_matricola_azienda]         INT           NULL,
    [St_aurss_controcod_matr_az]         INT           NULL,
    [St_aurss_DM_CodiceFiscalePosizione] VARCHAR (16)  NULL,
    [St_aurss_CodiceCarica]              VARCHAR (1)   NULL,
    [St_aurss_CodicefiscaleSoggetto]     VARCHAR (16)  NULL,
    [St_aurss_Flag_Delega_Esplicita]     VARCHAR (1)   NULL,
    [St_aurss_data_inizio_validita]      VARCHAR (MAX) NULL,
    [St_aurss_data_di_fine_validità]     VARCHAR (MAX) NULL,
    [St_aurss_data_modifica]             DATETIME      NULL,
    [St_aurss_descr_utente]              VARCHAR (MAX) NULL
);

