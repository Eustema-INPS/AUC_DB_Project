CREATE TABLE [dbo].[tb_aufzs_funzioni_storico] (
    [aufzs_codice_pk]       INT           IDENTITY (1, 1) NOT NULL,
    [aufun_codice_pk]       INT           NOT NULL,
    [aufun_funzione]        VARCHAR (50)  NULL,
    [aufun_raggruppamento]  VARCHAR (50)  NULL,
    [aufun_tipo_funzione]   VARCHAR (1)   NOT NULL,
    [aufun_descr]           VARCHAR (200) NULL,
    [aufun_flag_abilitato]  VARCHAR (1)   NULL,
    [aufun_data_modifica]   DATETIME      NULL,
    [aufun_descr_utente]    VARCHAR (50)  NULL,
    [aufzs_data_storicizza] DATETIME      NULL,
    [aufzs_descr_utente]    VARCHAR (50)  NULL,
    [aufzs_motivo]          VARCHAR (200) NULL,
    [aufzs_tipo_intervento] VARCHAR (1)   NULL
);

