﻿CREATE TYPE [dbo].[DmagCidaList_v6] AS TABLE (
    [CIDA]                         VARCHAR (8)   NOT NULL,
    [AnnoMeseDenuncia]             VARCHAR (6)   NULL,
    [CodiceFiscaleAziendaDich]     VARCHAR (16)  NULL,
    [TipoRichiesta]                CHAR (1)      NOT NULL,
    [CIDAPadre]                    VARCHAR (8)   NULL,
    [CodiceFiscaleAzienda]         VARCHAR (16)  NULL,
    [CodiceIstatAzienda]           VARCHAR (6)   NULL,
    [CodiceProgressivoAzienda]     VARCHAR (2)   NULL,
    [TipoDitta1]                   VARCHAR (2)   NULL,
    [TipoDitta2]                   VARCHAR (2)   NULL,
    [Cognome]                      VARCHAR (30)  NULL,
    [Nome]                         VARCHAR (30)  NULL,
    [AziendaSomministratrice]      VARCHAR (1)   NULL,
    [ListaCIDACod]                 VARCHAR (MAX) NULL,
    [CodiciAgevolazione]           VARCHAR (MAX) NULL,
    [DenominazioneUrbanistica]     VARCHAR (10)  NULL,
    [Indirizzo]                    VARCHAR (80)  NULL,
    [Civico]                       VARCHAR (8)   NULL,
    [Edificio]                     VARCHAR (6)   NULL,
    [Frazione]                     VARCHAR (80)  NULL,
    [CodiceIstatResidenza]         VARCHAR (6)   NULL,
    [ProvinciaResidenza]           CHAR (2)      NULL,
    [CAPResidenza]                 CHAR (5)      NULL,
    [ComuneResidenza]              VARCHAR (32)  NULL,
    [CodiceFiscaleAziendaSomm]     VARCHAR (16)  NULL,
    [CodiceIstatAziendaSomm]       VARCHAR (6)   NULL,
    [CodiceProgressivoAziendaSomm] VARCHAR (2)   NULL,
    [TipoDitta1Somm]               VARCHAR (2)   NULL,
    [TipoDitta2Somm]               VARCHAR (2)   NULL,
    [Esito]                        TINYINT       NULL,
    [MotivoErrore]                 VARCHAR (40)  NULL);

