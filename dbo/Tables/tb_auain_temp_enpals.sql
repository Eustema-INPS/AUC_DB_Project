CREATE TABLE [dbo].[tb_auain_temp_enpals] (
    [auain_codice_fiscale]            VARCHAR (16) NULL,
    [auain_cf_rappr_legale]           VARCHAR (16) NULL,
    [auain_data_inizio_val]           DATETIME     NULL,
    [AUAIN_DATA_MODIFICA]             DATETIME     NULL,
    [AUAIN_CODICE_AUSCA]              INT          NULL,
    [AUAIN_CODICE_AUSCO]              INT          NULL,
    [AUAIN_CODICE_AUSSU]              INT          CONSTRAINT [DF_AUAIN_CODICE_AUSSU] DEFAULT ((1)) NULL,
    [AUAIN_DESCRUTENTE]               VARCHAR (20) CONSTRAINT [DF_AUAIN_DESCRUTENTE] DEFAULT ('SSIS ENPALS') NULL,
    [AUAIN_Relazione_NON_certificata] VARCHAR (1)  CONSTRAINT [DF_AUAIN_Relazione_NON_certificata] DEFAULT ('N') NULL,
    [AUAIN_TS]                        VARCHAR (1)  NULL,
    [AUAIN_FK_AUTIS]                  INT          NULL,
    [AUAIN_Rappresentante_Legale]     VARCHAR (1)  NULL
);

