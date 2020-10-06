CREATE TABLE [dbo].[tb_aufal_fallimento] (
    [aufal_codice_pk]       BIGINT       NULL,
    [aufal_ausco_codice_pk] INT          NULL,
    [aufal_p_fallimento]    VARCHAR (4)  NULL,
    [aufal_prov_tribunale]  CHAR (2)     NULL,
    [aufal_tribunale]       CHAR (30)    NULL,
    [aufal_n_fallimento]    CHAR (10)    NULL,
    [aufal_dt_fallimento]   CHAR (8)     NULL,
    [aufal_n_sentenza]      CHAR (10)    NULL,
    [aufal_dt_sentenza]     CHAR (8)     NULL,
    [aufal_c_organo_giud]   CHAR (1)     NULL,
    [aufal_curatore]        CHAR (30)    NULL,
    [aufal_cognome]         CHAR (25)    NULL,
    [aufal_nome]            CHAR (25)    NULL,
    [aufal_dt_nascita]      CHAR (8)     NULL,
    [aufal_data_modifica]   DATETIME     NULL,
    [aufal_descr_utente]    VARCHAR (50) NULL
);

