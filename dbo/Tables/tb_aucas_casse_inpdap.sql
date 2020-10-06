CREATE TABLE [dbo].[tb_aucas_casse_inpdap] (
    [aucas_codice_pk]          INT           IDENTITY (1, 1) NOT NULL,
    [aucas_codice]             VARCHAR (3)   NULL,
    [aucas_descrizione_brevre] VARCHAR (50)  NULL,
    [aucas_descrizione]        VARCHAR (200) NULL,
    [aucas_data_modifica]      DATETIME      CONSTRAINT [DF_aucas_data_modifica] DEFAULT (getdate()) NULL,
    [aucas_descr_utente]       VARCHAR (50)  CONSTRAINT [DF_tb_aucas_casse_inpdap_aucas_descr_utente] DEFAULT ('Caricamento INPDAP') NULL,
    [AUCAS_BDCS_ID_VA]         BIGINT        NULL,
    [AUCAS_BDCS_CODFIN_VB]     VARCHAR (6)   NULL,
    [AUCAS_BDCS_CODFISC_VB]    VARCHAR (11)  NULL,
    [AUCAS_BDCS_FLGPEPR_VB]    VARCHAR (1)   NULL,
    [AUCAS_BDCS_NUMERO_VB]     VARCHAR (6)   NULL,
    [AUCAS_BDCS_SIGLA_VB]      VARCHAR (15)  NULL,
    [AUCAS_BDCS_MODREC_VB]     DATE          NULL,
    [AUCAS_BDCS_CODEN_VB]      VARCHAR (2)   NULL,
    [AUCAS_BDCS_DATAINI_VB]    DATE          NULL,
    [AUCAS_BDCS_DATAFIN_VB]    DATE          NULL,
    [AUCAS_BDCS_NSI_VB]        VARCHAR (1)   NULL,
    CONSTRAINT [PK_tb_aucas] PRIMARY KEY CLUSTERED ([aucas_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aucas_aucas] UNIQUE NONCLUSTERED ([aucas_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

