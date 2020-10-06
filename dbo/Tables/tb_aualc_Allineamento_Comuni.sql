CREATE TABLE [dbo].[tb_aualc_Allineamento_Comuni] (
    [aualc_codice_pk]            INT          IDENTITY (1, 1) NOT NULL,
    [aualc_Comune_AUC]           VARCHAR (60) NULL,
    [aualc_ComuneI]              VARCHAR (60) NULL,
    [aualc_ComuneT]              VARCHAR (60) NULL,
    [aualc_Belfiore]             VARCHAR (4)  NULL,
    [aualc_PROV]                 VARCHAR (3)  NULL,
    [aualc_regione]              VARCHAR (2)  NULL,
    [aualc_regione_inps]         VARCHAR (2)  NULL,
    [aualc_ISTAT_Codice_Regione] VARCHAR (2)  NULL,
    [aualc_ISTAT_Codice_Comune]  VARCHAR (6)  NULL,
    [aualc_flag_lavorazione]     INT          CONSTRAINT [DF_tb_aualc_Allineamento_Comuni_aualc_flag_lavorazione] DEFAULT ((0)) NULL,
    [aualc_stato]                INT          NULL,
    [aualc_data_modifica]        DATETIME     NULL,
    [aualc_descr_utente]         VARCHAR (50) NULL,
    [aualc_Descr_Regione]        VARCHAR (50) NULL,
    CONSTRAINT [PK_tb_aualc_Allineamento_Comuni] PRIMARY KEY CLUSTERED ([aualc_codice_pk] ASC)
);

