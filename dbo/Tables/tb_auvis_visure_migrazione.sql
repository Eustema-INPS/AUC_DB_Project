CREATE TABLE [dbo].[tb_auvis_visure_migrazione] (
    [auvis_id]                   INT             IDENTITY (1, 1) NOT NULL,
    [auvis_CF]                   VARCHAR (16)    NULL,
    [auvis_PEC]                  VARCHAR (160)   NULL,
    [auvis_PEC_Old]              VARCHAR (160)   NULL,
    [auvis_nome_file]            VARCHAR (255)   NULL,
    [auvis_visura_xml]           XML             NULL,
    [auvis_visura_bin]           VARBINARY (MAX) NULL,
    [auvis_lotto]                INT             NULL,
    [auvis_flag01]               INT             CONSTRAINT [DF_tb_auvis_visure_migrazione_auvis_flag01] DEFAULT ((0)) NULL,
    [auvis_flag02]               INT             CONSTRAINT [DF_tb_auvis_visure_migrazione_auvis_flag02] DEFAULT ((0)) NULL,
    [auvis_flag03]               INT             CONSTRAINT [DF_tb_auvis_visure_migrazione_auvis_flag03] DEFAULT ((0)) NULL,
    [auvis_elaborato]            INT             CONSTRAINT [DF_tb_auvis_visure_migrazione_auvis_elaborato] DEFAULT ((0)) NULL,
    [auvis_lavorabile]           INT             CONSTRAINT [DF_tb_auvis_visure_migrazione_auvis_lavorabile] DEFAULT ((0)) NULL,
    [auvis_DataElaborazione]     DATETIME        NULL,
    [auvis_DataFineElaborazione] DATETIME        NULL,
    [auvis_ausca_codice_pk]      INT             NULL
) ON [XML] TEXTIMAGE_ON [XML];

