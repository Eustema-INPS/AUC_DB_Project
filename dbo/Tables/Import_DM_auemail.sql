CREATE TABLE [dbo].[Import_DM_auemail] (
    [St_auemail_codice_fiscale]    VARCHAR (16)  NULL,
    [St_auemail_sede_provinciale]  INT           NULL,
    [St_auemail_matricola_azienda] INT           NULL,
    [St_auemail_controcod_matr_az] INT           NULL,
    [St_auemail_posizione]         VARCHAR (MAX) NULL,
    [St_auemail_tipo_indirizzo]    VARCHAR (1)   NULL,
    [St_auemail_indirizzo]         VARCHAR (100) NULL,
    [St_auemail_data_modifica]     VARCHAR (MAX) NULL,
    [St_auemail_descr_utente]      VARCHAR (MAX) NULL
);

