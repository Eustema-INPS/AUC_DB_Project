CREATE TABLE [dbo].[TB_AUOUT_OUTPUT_GENERICO] (
    [auout_codice_pk]       BIGINT        IDENTITY (1, 1) NOT NULL,
    [auout_tipo_operazione] VARCHAR (50)  NULL,
    [auout_output]          VARCHAR (MAX) NULL,
    [auout_data_modifica]   DATETIME      NULL,
    [auout_descr_utente]    VARCHAR (50)  NULL,
    CONSTRAINT [PK_tb_auout] PRIMARY KEY CLUSTERED ([auout_codice_pk] ASC),
    CONSTRAINT [UQ_tb_auout] UNIQUE NONCLUSTERED ([auout_codice_pk] ASC)
);

