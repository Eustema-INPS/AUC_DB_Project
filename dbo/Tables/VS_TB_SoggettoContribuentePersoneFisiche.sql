CREATE TABLE [dbo].[VS_TB_SoggettoContribuentePersoneFisiche] (
    [CodiceFiscale]       NVARCHAR (16) NOT NULL,
    [Cognome]             NCHAR (50)    NULL,
    [Nome]                NCHAR (50)    NULL,
    [DataNascita]         DATE          NULL,
    [Sesso]               NCHAR (1)     NULL,
    [LuogoNascita]        VARCHAR (100) NULL,
    [ProvinciaNascita]    NCHAR (50)    NULL,
    [ResidenzaCap]        NCHAR (5)     NULL,
    [ResidenzaComune]     VARCHAR (100) NULL,
    [ResidenzaProvincia]  NCHAR (50)    NULL,
    [ResidenzaVia]        NCHAR (50)    NULL,
    [IndirizzoEmailPEC]   NCHAR (50)    NULL,
    [IndirizzoEmail]      NCHAR (50)    NULL,
    [Telefono]            NCHAR (20)    NULL,
    [DataUltimaModifica]  DATETIME      NULL,
    [OrdinaleInserimento] BIGINT        NOT NULL
);

