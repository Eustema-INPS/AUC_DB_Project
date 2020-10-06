CREATE TABLE [dbo].[AUCIndirizziARCA] (
    [IdAUCIndirizziARCA] INT           NOT NULL,
    [ID_GESTIONALE]      CHAR (9)      NOT NULL,
    [INDIRIZZO]          VARCHAR (100) NULL,
    [CIVICO]             VARCHAR (20)  NULL,
    [CAP]                VARCHAR (9)   NULL,
    [CODICE_BELFIORE]    CHAR (4)      NULL,
    [COMUNE]             VARCHAR (100) NULL,
    [PROVINCIA]          VARCHAR (3)   NULL
);

