CREATE TABLE [dbo].[TB_AUOPS_OPERAZIONE_SOCIETARIA_PARTECIPANTE_STORICO] (
    [auops_codice_pk]              BIGINT       IDENTITY (1, 1) NOT NULL,
    [auops_auoso_codice_pk]        BIGINT       NULL,
    [auops_auoss_codice_pk]        BIGINT       NULL,
    [auops_codice_fiscale]         VARCHAR (16) NULL,
    [auops_posizione]              VARCHAR (50) NULL,
    [auops_CSC_posizione]          VARCHAR (5)  NULL,
    [auops_CA_posizione]           VARCHAR (60) NULL,
    [auops_aupoc_codice_pk]        INT          NULL,
    [auops_Cancellato_logicamente] CHAR (1)     NULL,
    [auops_data_modifica]          DATETIME     NULL,
    [auops_descr_utente]           VARCHAR (50) NULL,
    CONSTRAINT [PK_tb_auops] PRIMARY KEY CLUSTERED ([auops_codice_pk] ASC),
    CONSTRAINT [UQ_auops_auops] UNIQUE NONCLUSTERED ([auops_codice_pk] ASC)
);

