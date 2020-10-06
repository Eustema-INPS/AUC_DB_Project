CREATE TABLE [dbo].[Import_aufal] (
    [St_aufal_codice_pk]            BIGINT       NULL,
    [St_aufal_codice_fiscale_ausco] VARCHAR (16) NULL,
    [St_aufal_ausco_codice_pk]      INT          NULL,
    [St_aufal_p_fallimento]         VARCHAR (4)  NULL,
    [St_aufal_prov_tribunale]       VARCHAR (2)  NULL,
    [St_aufal_tribunale]            VARCHAR (30) NULL,
    [St_aufal_n_fallimento]         VARCHAR (10) NULL,
    [St_aufal_dt_fallimento]        DATE         NULL,
    [St_aufal_n_sentenza]           VARCHAR (10) NULL,
    [St_aufal_dt_sentenza]          DATE         NULL,
    [St_aufal_c_organo_giud]        VARCHAR (1)  NULL,
    [St_aufal_curatore]             VARCHAR (30) NULL,
    [St_aufal_cognome]              VARCHAR (25) NULL,
    [St_aufal_nome]                 VARCHAR (25) NULL,
    [St_aufal_dt_nascita]           DATE         NULL,
    [St_aufal_data_modifica]        DATETIME     NULL,
    [St_aufal_descr_utente]         VARCHAR (50) NULL
);

