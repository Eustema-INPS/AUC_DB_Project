CREATE TABLE [dbo].[tb_auras_report_azst_stato] (
    [auras_codice_pk]              INT           IDENTITY (1, 1) NOT NULL,
    [auras_data_verifica]          DATETIME      NULL,
    [auras_esito_codice]           VARCHAR (10)  NULL,
    [auras_esito_descrizione]      VARCHAR (MAX) NULL,
    [auras_esito_dataElaborazione] DATETIME      NULL,
    [auras_xml_request]            XML           NULL,
    [auras_xml_response]           XML           NULL,
    CONSTRAINT [PK_tb_auras_report_azst_stato] PRIMARY KEY CLUSTERED ([auras_codice_pk] ASC)
);

