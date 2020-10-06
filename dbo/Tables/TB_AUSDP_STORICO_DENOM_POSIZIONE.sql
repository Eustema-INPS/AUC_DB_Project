CREATE TABLE [dbo].[TB_AUSDP_STORICO_DENOM_POSIZIONE] (
    [ausdp_codice_pk]           BIGINT        IDENTITY (1, 1) NOT NULL,
    [ausdp_posizione]           VARCHAR (50)  NULL,
    [ausdp_aupoc_codice_pk]     INT           NULL,
    [ausdp_denom_precedente]    VARCHAR (300) NULL,
    [ausdp_denom_attuale]       VARCHAR (300) NULL,
    [ausdp_data_modifica_aupoc] DATETIME      NULL,
    [ausdp_data_modifica_dmag]  DATETIME      NULL,
    [ausdp_data_modifica]       DATETIME      NULL,
    [ausdp_descr_utente]        VARCHAR (50)  NULL,
    [ausdp_motivo]              VARCHAR (200) NULL,
    CONSTRAINT [PK_tb_ausdp] PRIMARY KEY CLUSTERED ([ausdp_codice_pk] ASC),
    CONSTRAINT [UQ_tb_ausdp] UNIQUE NONCLUSTERED ([ausdp_codice_pk] ASC)
);

