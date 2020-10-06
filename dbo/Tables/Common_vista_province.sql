CREATE TABLE [dbo].[Common_vista_province] (
    [code_sigla] VARCHAR (2)  NULL,
    [provincia]  VARCHAR (60) NULL,
    [regione]    VARCHAR (30) NULL,
    CONSTRAINT [UQ_vista_province] UNIQUE NONCLUSTERED ([code_sigla] ASC) WITH (FILLFACTOR = 90)
);

