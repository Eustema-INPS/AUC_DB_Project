CREATE TABLE [dbo].[TB_AUDET_DENUNCE_DETTAGLIO] (
    [audet_codice_pk]      BIGINT   IDENTITY (1, 1) NOT NULL,
    [Lotto]                BIGINT   NULL,
    [IdTrasmissione]       BIGINT   NULL,
    [S02_DataRicezione]    DATETIME NULL,
    [S02_DataInserimento]  DATETIME NULL,
    [S02_DataElaborazione] DATETIME NULL,
    [S02_Conteggio]        INT      NULL,
    [S02_Aziende]          INT      NULL,
    [S02_Denunce]          INT      NULL,
    [S02_Errori]           INT      NULL,
    [DATARICEZIONE]        DATETIME NULL,
    [INIZIOELABORAZIONE]   DATETIME NULL,
    [FINEELABORAZIONE]     DATETIME NULL,
    [INIZIOPRELEVAMENTO]   DATETIME NULL,
    [FINEPRELEVAMENTO]     DATETIME NULL,
    [COMPLETATA]           INT      NULL
);

