﻿CREATE TABLE [dbo].[TB_PATRONATI_ANAGRAFE] (
    [TIMESTAMP_ACQUISIZIONE] SMALLDATETIME  NOT NULL,
    [TIPO_RECORD]            VARCHAR (1)    NOT NULL,
    [CODFIS_PATRONATO]       VARCHAR (11)   NOT NULL,
    [CODINPS]                CHAR (3)       NOT NULL,
    [CODUFF]                 VARCHAR (10)   NOT NULL,
    [SIGLAPATR]              VARCHAR (30)   NOT NULL,
    [NOMEUFF]                VARCHAR (100)  NOT NULL,
    [SIGLAST]                CHAR (3)       NOT NULL,
    [NOMEST]                 VARCHAR (100)  NOT NULL,
    [REGIONE]                VARCHAR (30)   NOT NULL,
    [PROV]                   CHAR (2)       NOT NULL,
    [CAP]                    CHAR (9)       NOT NULL,
    [COMUNE]                 VARCHAR (100)  NOT NULL,
    [INDIRIZZO]              VARCHAR (100)  NOT NULL,
    [PREFINT]                VARCHAR (6)    NOT NULL,
    [TELUFF]                 CHAR (20)      NOT NULL,
    [FAXUFF]                 CHAR (20)      NOT NULL,
    [MAILUFF]                VARCHAR (100)  NOT NULL,
    [NOMERESP]               VARCHAR (70)   NOT NULL,
    [COGNRESP]               VARCHAR (70)   NOT NULL,
    [TELRESP]                CHAR (20)      NOT NULL,
    [FAXRESP]                CHAR (20)      NOT NULL,
    [MAILRESP]               VARCHAR (100)  NOT NULL,
    [PECDP]                  VARCHAR (100)  NOT NULL,
    [GG_AGG]                 CHAR (2)       NOT NULL,
    [MM_AGG]                 CHAR (2)       NOT NULL,
    [AA_AGG]                 CHAR (4)       NOT NULL,
    [GG_INI]                 CHAR (2)       NOT NULL,
    [MM_INI]                 CHAR (2)       NOT NULL,
    [AA_INI]                 CHAR (4)       NOT NULL,
    [GG_FNAT]                CHAR (2)       NOT NULL,
    [MM_FNAT]                CHAR (2)       NOT NULL,
    [AA_FNAT]                CHAR (4)       NOT NULL,
    [NEWUFF]                 VARCHAR (10)   NOT NULL,
    [NEWPATR]                VARCHAR (3)    NOT NULL,
    [STATO]                  INT            NOT NULL,
    [DESC_STATO]             VARCHAR (2500) NOT NULL,
    [DEC_STATO]              INT            NOT NULL,
    [TIPO_OPERAZIONE]        INT            NOT NULL,
    [DATA_LAVORAZIONE]       SMALLDATETIME  NULL,
    [DATA_INSERIMENTO]       SMALLDATETIME  NOT NULL,
    CONSTRAINT [PK_TB_PATRONATI_ANAGRAFICA] PRIMARY KEY CLUSTERED ([TIMESTAMP_ACQUISIZIONE] ASC, [TIPO_RECORD] ASC, [CODFIS_PATRONATO] ASC, [CODINPS] ASC, [CODUFF] ASC, [SIGLAPATR] ASC, [TIPO_OPERAZIONE] ASC)
);
