CREATE TABLE [dbo].[tb_DM_Scarti_Import_auind] (
    [St_auind_tabella]         VARCHAR (5)   NULL,
    [St_auind_chiave_interna]  VARCHAR (50)  NULL,
    [St_auind_chiave_esterna]  VARCHAR (MAX) NULL,
    [St_auind_tipo_indirizzo]  VARCHAR (MAX) NULL,
    [St_auind_codice_toponimo] VARCHAR (MAX) NULL,
    [St_auind_indirizzo]       VARCHAR (MAX) NULL,
    [St_auind_civico]          VARCHAR (MAX) NULL,
    [St_auind_cap]             VARCHAR (MAX) NULL,
    [St_auind_descr_comune]    VARCHAR (MAX) NULL,
    [St_auind_sigla_provincia] VARCHAR (MAX) NULL,
    [St_auind_telefono1]       VARCHAR (MAX) NULL,
    [St_auind_telefono2]       VARCHAR (MAX) NULL,
    [St_auind_fax]             VARCHAR (MAX) NULL,
    [St_auind_data_modifica]   VARCHAR (MAX) NULL,
    [St_auind_descr_utente]    VARCHAR (MAX) NULL,
    [ErrorNum]                 VARCHAR (MAX) NULL,
    [ErrorDescription]         VARCHAR (MAX) NULL,
    [NoteScartoErrori]         VARCHAR (MAX) NULL
);

