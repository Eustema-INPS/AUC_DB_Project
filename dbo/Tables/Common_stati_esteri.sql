CREATE TABLE [dbo].[Common_stati_esteri] (
    [CodiceCatastale] VARCHAR (4)   NULL,
    [Stato_estero]    VARCHAR (100) NULL,
    CONSTRAINT [UQ_stati_esteri] UNIQUE NONCLUSTERED ([CodiceCatastale] ASC) WITH (FILLFACTOR = 90)
);

