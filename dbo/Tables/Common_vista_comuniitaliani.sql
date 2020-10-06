CREATE TABLE [dbo].[Common_vista_comuniitaliani] (
    [CodiceCatastale] VARCHAR (4)  NULL,
    [Comune]          VARCHAR (60) NULL,
    [Provincia]       VARCHAR (2)  NULL,
    CONSTRAINT [UQ_vista_comuniitaliani] UNIQUE NONCLUSTERED ([CodiceCatastale] ASC) WITH (FILLFACTOR = 90)
);

