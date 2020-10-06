CREATE TABLE [dbo].[tb_auvat_valore_ateco] (
    [auvat_posizione]            VARCHAR (50) NULL,
    [auvat_codice_ateco]         VARCHAR (20) NULL,
    [auvat_auate_1991_codice_pk] INT          NULL,
    [auvat_auate_2002_codice_pk] INT          NULL,
    [auvat_auate_2007_codice_pk] INT          NULL,
    [auvat_stato]                INT          CONSTRAINT [DF_tb_auvat_valore_ateco_auvat_stato] DEFAULT ((0)) NULL,
    [auvat_data]                 DATETIME     CONSTRAINT [DF_tb_auvat_valore_ateco_auvat_data] DEFAULT (getdate()) NULL
);

