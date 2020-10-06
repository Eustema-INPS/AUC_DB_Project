CREATE TABLE [dbo].[VS_TB_SoggettoContribuentePersoneGiuridiche] (
    [DenominazioneRagioneSociale] VARCHAR (100) NULL,
    [PartitaIVA]                  VARCHAR (16)  NULL,
    [Cap]                         NCHAR (5)     NULL,
    [Comune]                      VARCHAR (100) NULL,
    [Provincia]                   VARCHAR (50)  NULL,
    [Via]                         VARCHAR (50)  NULL,
    [CodiceFiscaleRappLegale]     NVARCHAR (16) NULL,
    [NomeRappLegale]              VARCHAR (100) NULL,
    [CognomeRappLegale]           VARCHAR (100) NULL,
    [SessoRappLegale]             VARCHAR (2)   NULL,
    [LuogoNascitaRappLegale]      NCHAR (60)    NULL,
    [DataNascitaRappLegale]       DATE          NULL,
    [indirizzoEmailPEC]           NCHAR (50)    NULL,
    [IndirizzoEmail]              NCHAR (50)    NULL,
    [Telefono]                    NCHAR (20)    NULL,
    [DataUltimaModifica]          DATETIME      NULL,
    [OrdinaleInserimento]         BIGINT        NOT NULL
);

