CREATE TABLE [dbo].[Import_Scarti] (
    [ImportScarti_Id]            INT           IDENTITY (1, 1) NOT NULL,
    [ImportScarti_ErrorCode]     INT           NULL,
    [ImportScarti_ErrorColumn]   INT           NULL,
    [ImportScarti_Chiave1]       VARCHAR (255) NULL,
    [ImportScarti_Chiave2]       VARCHAR (255) NULL,
    [ImportScarti_Chiave3]       VARCHAR (255) NULL,
    [ImportScarti_DataRicezione] DATETIME      NULL
);

