CREATE TABLE [dbo].[TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE] (
    [auosp_codice_pk]              BIGINT       IDENTITY (1, 1) NOT NULL,
    [auosp_auoso_codice_pk]        BIGINT       NULL,
    [auosp_codice_fiscale]         VARCHAR (16) NULL,
    [auosp_posizione]              VARCHAR (50) NULL,
    [auosp_CSC_posizione]          VARCHAR (5)  NULL,
    [auosp_CA_posizione]           VARCHAR (60) NULL,
    [auosp_aupoc_codice_pk]        INT          NULL,
    [auosp_Cancellato_logicamente] CHAR (1)     CONSTRAINT [DF_TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE_auosp_Cancellato_logicamente] DEFAULT ('N') NULL,
    [auosp_data_modifica]          DATETIME     NULL,
    [auosp_descr_utente]           VARCHAR (50) NULL,
    CONSTRAINT [PK_tb_auosp] PRIMARY KEY CLUSTERED ([auosp_codice_pk] ASC),
    CONSTRAINT [UQ_auosp_auosp] UNIQUE NONCLUSTERED ([auosp_codice_pk] ASC)
);

