CREATE TABLE [dbo].[tb_auvis_visure_esiti] (
    [auvis_id]                   INT          NULL,
    [auvis_elaborato]            INT          CONSTRAINT [DF_tb_auvis_visure_esiti_auvis_elaborato] DEFAULT ((0)) NULL,
    [auvis_DataElaborazione]     DATETIME     NULL,
    [IdentificativoPratica]      VARCHAR (20) NULL,
    [ProtocolloRI]               VARCHAR (50) NULL,
    [auvis_DataFineElaborazione] DATETIME     NULL
);

