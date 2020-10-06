CREATE TABLE [dbo].[Import_Cessate2] (
    [CodiceFiscale]          VARCHAR (16)   NULL,
    [DataCancellazione]      VARCHAR (16)   NULL,
    [DataCessazione]         VARCHAR (16)   NULL,
    [DataDomanda]            VARCHAR (16)   NULL,
    [CodiceCausale]          VARCHAR (16)   NULL,
    [Causale]                VARCHAR (200)  NULL,
    [DataCessazioneAttivita] VARCHAR (16)   NULL,
    [InfoCessazione]         VARCHAR (2000) NULL,
    [FkAusca]                BIGINT         NULL
);

