CREATE TABLE [dbo].[tb_aufun_funz_sistema] (
    [aufun_codice_pk]      INT           IDENTITY (1, 1) NOT NULL,
    [aufun_funzione]       VARCHAR (50)  NULL,
    [aufun_raggruppamento] VARCHAR (50)  NULL,
    [aufun_tipo_funzione]  VARCHAR (1)   NOT NULL,
    [aufun_descr]          VARCHAR (200) NULL,
    [aufun_flag_abilitato] VARCHAR (1)   NULL,
    [aufun_data_modifica]  DATETIME      NULL,
    [aufun_descr_utente]   VARCHAR (50)  NULL,
    [aufun_codice_pk_db2]  INT           NULL,
    CONSTRAINT [PK_tb_aufun] PRIMARY KEY CLUSTERED ([aufun_codice_pk] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [UQ_aufun_aufun] UNIQUE NONCLUSTERED ([aufun_codice_pk] ASC) WITH (FILLFACTOR = 90)
);

