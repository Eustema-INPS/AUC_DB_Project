CREATE TABLE [dbo].[tb_svdes_destinatario] (
    [svdes_codice_pk]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [svdes_svmes_codice_pk] BIGINT        NOT NULL,
    [svdes_ID_destinatario] INT           NOT NULL,
    [svdes_ID_Key]          INT           NOT NULL,
    [svdes_tipo]            VARCHAR (50)  NULL,
    [svdes_email]           VARCHAR (250) NOT NULL,
    [svdes_generica]        VARCHAR (2)   NULL
);

