CREATE TABLE [dbo].[tb_svall_allegato] (
    [svall_codice_pk]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [svall_svmes_codice_pk] BIGINT        NOT NULL,
    [svall_ID_allegato]     INT           NOT NULL,
    [svall_ID_Key]          INT           NOT NULL,
    [svall_nome]            VARCHAR (250) NOT NULL,
    [svall_tipo]            VARCHAR (50)  NULL,
    [svall_allegato]        IMAGE         NOT NULL,
    [svall_stato]           VARCHAR (5)   NOT NULL,
    [svall_formato]         VARCHAR (3)   NOT NULL,
    [svall_firmato]         CHAR (1)      NOT NULL,
    [svall_generica]        VARCHAR (2)   NULL
);

