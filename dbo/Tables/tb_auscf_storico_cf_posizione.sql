CREATE TABLE [dbo].[tb_auscf_storico_cf_posizione] (
    [auscf_codice_pk]         INT          IDENTITY (1, 1) NOT NULL,
    [auscf_aupoc_codice_pk]   INT          NULL,
    [auscf_posizione]         VARCHAR (10) NULL,
    [codice_fiscale_dismesso] VARCHAR (16) NULL,
    [codice_fiscale_nuovo]    VARCHAR (16) NULL,
    [auscf_data_inserimento]  VARCHAR (25) NULL,
    [auscf_data_modifica]     DATETIME     DEFAULT (getdate()) NULL,
    [auscf_descr_Utente]      VARCHAR (50) NULL
);

