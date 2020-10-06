CREATE TABLE [dbo].[tb_svgio_giornaliere] (
    [svgio_id_Key]                    INT      NULL,
    [svgio_data_ultimo_aggiornamento] DATETIME NULL,
    [svgio_generica]                  CHAR (1) CONSTRAINT [DF__tb_svgio___svgio__35ABE824] DEFAULT ('N') NULL,
    [svgio_presente]                  CHAR (1) CONSTRAINT [DF__tb_svgio___svgio__36A00C5D] DEFAULT ('N') NULL
);

