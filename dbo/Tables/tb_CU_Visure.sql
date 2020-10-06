CREATE TABLE [dbo].[tb_CU_Visure] (
    [IdentificativoPratica] VARCHAR (20)  NULL,
    [ProtocolloRI]          VARCHAR (50)  NULL,
    [Area]                  VARCHAR (10)  NULL,
    [DataSpedizione]        DATETIME      NULL,
    [DataConsegna]          DATETIME      NULL,
    [NomeFileVisura]        VARCHAR (250) NULL,
    [ContenutoFileVisura]   IMAGE         NULL,
    [generica]              VARCHAR (1)   NULL,
    [Lotto]                 VARCHAR (20)  NULL,
    [CodiceFiscale]         VARCHAR (16)  NULL,
    [visura_xml]            XML           NULL,
    [EsitoElaborazione]     INT           NULL
);

