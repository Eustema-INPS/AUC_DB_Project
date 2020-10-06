CREATE TABLE [dbo].[tb_aucia_com_ist_az] (
    [aucia_codice_pk]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [aucia_chiave_gestionale]     VARCHAR (50)    NULL,
    [aucia_posizione]             VARCHAR (50)    NULL,
    [aucia_origine]               VARCHAR (20)    NULL,
    [aucia_cod_oper]              VARCHAR (20)    NULL,
    [aucia_cf_del_tit]            VARCHAR (16)    NULL,
    [aucia_localita_uff_registro] VARCHAR (50)    NULL,
    [aucia_data_invocazione]      DATETIME        NULL,
    [aucia_data_invio]            DATETIME        NULL,
    [aucia_oggetto_invio]         VARCHAR (200)   NULL,
    [aucia_messaggio_invio]       VARCHAR (MAX)   NULL,
    [aucia_allegato_invio]        VARBINARY (MAX) NULL,
    [aucia_stato_codice]          VARCHAR (2)     NULL,
    [aucia_stato_descr]           VARCHAR (MAX)   NULL,
    [aucia_stato_data]            DATETIME        NULL,
    [aucia_data_ins]              DATETIME        NULL,
    [aucia_flag_verifica_esito]   VARCHAR (1)     NULL,
    [aucia_flag_pec]              VARCHAR (1)     NULL,
    [aucia_mail_destinatario]     VARCHAR (320)   NULL,
    CONSTRAINT [PK_tb_aucia] PRIMARY KEY CLUSTERED ([aucia_codice_pk] ASC),
    CONSTRAINT [UQ_aucia_aucia] UNIQUE NONCLUSTERED ([aucia_codice_pk] ASC)
);

