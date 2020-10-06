CREATE TABLE [dbo].[tb_XmlSource] (
    [XmlSource_Id]                   INT           IDENTITY (1, 1) NOT NULL,
    [XmlSource_NomeFile]             VARCHAR (255) NOT NULL,
    [XmlSource_elaborato]            INT           NULL,
    [XmlSource_DataRicezione]        DATETIME      NULL,
    [XmlSource_DataElaborazione]     DATETIME      NULL,
    [XmlSource_dataFineElaborazione] DATETIME      NULL,
    [XmlSource_Lavorabile]           INT           NULL
);

