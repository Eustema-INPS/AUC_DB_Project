CREATE TABLE [dbo].[Import_aurss_relazioni_cancellate] (
    [St_aurss_CodicefiscaleAzienda]      VARCHAR (16)  NULL,
    [St_aurss_CodicefiscaleSoggetto]     VARCHAR (16)  NULL,
    [St_aurss_descrizione_cancellazione] VARCHAR (999) NULL,
    [St_aurss_CodiceCarica]              VARCHAR (3)   NULL,
    [St_aurss_Carica]                    VARCHAR (50)  NULL,
    [St_aurss_data_di_fine_validità]     DATE          NULL,
    [St_aurss_PRESENTE]                  CHAR (1)      CONSTRAINT [DF_Import_aurss_relazioni_cancellate_St_aurss_PRESENTE] DEFAULT ('N') NULL,
    [St_aurss_CANCELLATO]                INT           CONSTRAINT [DF_Import_aurss_relazioni_cancellate_St_aurss_CANCELLATO] DEFAULT ((0)) NULL,
    [St_aurss_ausca_codice_pk]           INT           NULL,
    [St_aurss_ausco_codice_pk]           INT           NULL,
    [St_aurss_autis_codice_pk]           INT           NULL,
    [St_aurss_Data_Inizio_Validita]      DATE          NULL
);

