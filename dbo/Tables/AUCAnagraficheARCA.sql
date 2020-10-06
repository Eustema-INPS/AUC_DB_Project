CREATE TABLE [dbo].[AUCAnagraficheARCA] (
    [IdAUCAnagraficheARCA] INT           NOT NULL,
    [ID_GESTIONALE]        CHAR (9)      NOT NULL,
    [CF]                   CHAR (16)     NOT NULL,
    [COGNOME]              VARCHAR (100) NULL,
    [NOME]                 VARCHAR (100) NULL,
    [SESSO]                CHAR (1)      NULL,
    [DATA_NASCITA]         CHAR (10)     NULL,
    [CODICE_BELFIORE]      CHAR (4)      NULL,
    [COMUNE]               VARCHAR (100) NULL,
    [PROVINCIA]            CHAR (3)      NULL,
    [NAZIONALITA]          VARCHAR (100) NULL,
    [DATA_MORTE]           CHAR (10)     NULL,
    [TipoValidazione]      SMALLINT      NOT NULL
);

