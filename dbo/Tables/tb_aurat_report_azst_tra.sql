CREATE TABLE [dbo].[tb_aurat_report_azst_tra] (
    [aurat_codice_pk]                   INT           IDENTITY (1, 1) NOT NULL,
    [aurat_identificativo_trasmissione] VARCHAR (50)  NULL,
    [aurat_anno]                        INT           NULL,
    [aurat_mese]                        INT           NULL,
    [aurat_data_invio]                  DATETIME      NULL,
    [aurat_esito_invio_codice]          VARCHAR (10)  NULL,
    [aurat_esito_invio_descrizione]     VARCHAR (MAX) NULL,
    [aurat_xml_invio_request]           XML           NULL,
    [aurat_xml_invio_response]          XML           NULL,
    CONSTRAINT [PK_tb_aurat_report_azst_tra] PRIMARY KEY CLUSTERED ([aurat_codice_pk] ASC)
);

