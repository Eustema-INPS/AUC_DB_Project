CREATE TABLE [dbo].[VS_TB_SoggettoContribuenteRapportoDiLavoro] (
    [ProgressivoRapportoLavoro]    VARCHAR (11)  NOT NULL,
    [ChiaveGestionaleDatoreLavoro] VARCHAR (16)  NULL,
    [CodiceFiscale]                NVARCHAR (16) NULL,
    [DataPresentazione]            DATE          NULL,
    [DataAssunzioneLavoratore]     DATE          NULL,
    [DataCessazione]               DATE          NULL,
    [StatoPratica]                 VARCHAR (50)  NULL,
    [DescrizioneStatoPratica]      VARCHAR (50)  NULL,
    [SedeInpsRiferimento]          VARCHAR (50)  NULL,
    [Cap]                          NCHAR (5)     NULL,
    [Comune]                       VARCHAR (100) NULL,
    [Provincia]                    VARCHAR (50)  NULL,
    [Via]                          VARCHAR (50)  NULL,
    [CodiceFiscaleLavoratore]      NVARCHAR (16) NULL,
    [DataUltimaModifica]           DATETIME      NULL,
    [OrdinaleInserimento]          BIGINT        NOT NULL
);

