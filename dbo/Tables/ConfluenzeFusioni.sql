CREATE TABLE [dbo].[ConfluenzeFusioni] (
    [ID_Gestionale]  INT           NOT NULL,
    [CodiceFiscale]  VARCHAR (16)  NOT NULL,
    [CodFiscFusione] VARCHAR (16)  NULL,
    [Nome]           VARCHAR (150) NULL,
    [Denominazione]  VARCHAR (450) NULL,
    [Data]           DATETIME      NULL,
    [Tipo]           INT           NOT NULL,
    [DescrTipo]      VARCHAR (255) NULL
);

