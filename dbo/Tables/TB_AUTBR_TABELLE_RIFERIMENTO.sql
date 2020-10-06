CREATE TABLE [dbo].[TB_AUTBR_TABELLE_RIFERIMENTO] (
    [Autbr_codice_pk]            INT           NOT NULL,
    [Autbr_nome_tabella]         VARCHAR (100) NULL,
    [Autbr_flag_visualizzazione] VARCHAR (1)   NULL,
    [Autbr_flag_modfica]         VARCHAR (1)   NULL,
    [Autbr_flag_cancellazione]   VARCHAR (1)   NULL,
    [Autbr_flag_gestibile]       VARCHAR (1)   NULL,
    [Autbr_data_modifica]        DATETIME      NULL,
    [Autbr_descr_utente]         VARCHAR (50)  NULL,
    [Autbr_tipo_tabella]         VARCHAR (1)   NULL,
    CONSTRAINT [PK_TB_AUTBR_TABELLE_RIFERIMENTO] PRIMARY KEY CLUSTERED ([Autbr_codice_pk] ASC)
);

