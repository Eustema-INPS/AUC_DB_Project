CREATE TABLE [dbo].[TB_AUPDI_POSIZIONI_DA_INSERIRE] (
    [aupdi_codice_pk]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [aupdi_posizione]       VARCHAR (50)  NULL,
    [aupdi_cf]              VARCHAR (16)  NULL,
    [aupdi_aupoc_codice_pk] INT           NULL,
    [aupdi_provenienza]     VARCHAR (20)  NULL,
    [aupdi_denominazione]   VARCHAR (300) NULL,
    [aupdi_stato]           INT           NULL,
    [aupdi_data_modifica]   DATETIME      NULL,
    [aupdi_descr_utente]    VARCHAR (50)  NULL,
    [aupdi_ausca_codice_pk] INT           NULL,
    [aupdi_flag_ausca]      CHAR (1)      NULL,
    [aupdi_flag_rl]         CHAR (1)      NULL,
    CONSTRAINT [PK_tb_aupdi] PRIMARY KEY CLUSTERED ([aupdi_codice_pk] ASC),
    CONSTRAINT [UQ_tb_aupdi] UNIQUE NONCLUSTERED ([aupdi_codice_pk] ASC)
);

