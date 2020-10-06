CREATE TABLE [dbo].[Info_aurss] (
    [aurss_codice_pk]             BIGINT   NULL,
    [aurss_ausca_codice_pk]       INT      NULL,
    [aurss_ausco_codice_pk]       INT      NULL,
    [aurss_autis_codice_pk]       INT      NULL,
    [aurss_data_inizio_validita]  DATE     NULL,
    [aurss_data_di_fine_validita] DATE     NULL,
    [aurss_Presente_Infocamere]   CHAR (1) CONSTRAINT [DF_Info_aurss_aurss_Presente_Infocamere] DEFAULT ('N') NULL
);

