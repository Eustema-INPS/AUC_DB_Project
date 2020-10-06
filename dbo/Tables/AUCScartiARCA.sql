CREATE TABLE [dbo].[AUCScartiARCA] (
    [IdAUCScartiARCA] INT           NOT NULL,
    [ID_GESTIONALE]   CHAR (9)      NOT NULL,
    [CF]              CHAR (16)     NOT NULL,
    [COGNOME]         VARCHAR (100) NULL,
    [NOME]            VARCHAR (100) NULL,
    [SESSO]           CHAR (1)      NULL,
    [DATA_NASCITA]    CHAR (10)     NULL,
    [CODICE_BELFIORE] CHAR (4)      NULL,
    [Colonna]         VARCHAR (100) NULL,
    [TipoValidazione] SMALLINT      NULL,
    [MotivoScarto]    VARCHAR (100) NULL
);

