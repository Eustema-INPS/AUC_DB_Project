CREATE TABLE [dbo].[tb_aupoe_PosizioniErrate] (
    [aupoe_codice_pk]          INT           IDENTITY (1, 1) NOT NULL,
    [aupoe_aupoc_codice_pk]    BIGINT        NOT NULL,
    [aupoe_posizione]          VARCHAR (50)  NULL,
    [aupoe_codice_fiscale]     VARCHAR (16)  NULL,
    [aupoe_posizione_DB2]      VARCHAR (50)  NULL,
    [aupoe_codice_fiscale_DB2] VARCHAR (16)  NULL,
    [aupoe_lotto_AUC]          VARCHAR (8)   NULL,
    [aupoe_lotto_IVA]          VARCHAR (8)   NULL,
    [aupoe_data_modifica_AUC]  DATETIME      NULL,
    [aupoe_data_modifica_IVA]  DATETIME      NULL,
    [aupoe_descr_utente]       VARCHAR (50)  NULL,
    [aupoe_esito_IVA]          VARCHAR (10)  NULL,
    [aupoe_esito_IVA_descr]    VARCHAR (MAX) NULL
);

