CREATE TABLE [dbo].[Sync_DM_AUC_Scarti] (
    [IdRiga]       INT          IDENTITY (1, 1) NOT NULL,
    [IdProcesso]   INT          NOT NULL,
    [Id]           INT          NOT NULL,
    [Flag]         INT          NULL,
    [Entita]       VARCHAR (20) NULL,
    [Data_Ins]     DATETIME     NULL,
    [CF]           VARCHAR (16) NULL,
    [CodPRO]       INT          NULL,
    [MatAZI]       INT          NULL,
    [CtrCOD]       INT          NULL,
    [MATRICOLA_DM] VARCHAR (10) NULL,
    [DataScarto]   VARCHAR (20) NULL
);

