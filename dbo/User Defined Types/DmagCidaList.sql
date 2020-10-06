CREATE TYPE [dbo].[DmagCidaList] AS TABLE (
    [CIDA]                     VARCHAR (8)  NOT NULL,
    [AnnoMeseDenuncia]         VARCHAR (7)  NOT NULL,
    [CodiceISTATAzienda]       VARCHAR (6)  NULL,
    [CodiceProgressivoAzienda] VARCHAR (2)  NULL,
    [TipoDitta1]               VARCHAR (2)  NULL,
    [TipoDitta2]               VARCHAR (2)  NULL,
    [CodiceFiscale]            VARCHAR (16) NULL,
    [Esito]                    TINYINT      NULL,
    [MotivoErrore]             VARCHAR (40) NULL);

