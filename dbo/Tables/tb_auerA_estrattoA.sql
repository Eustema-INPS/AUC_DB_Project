CREATE TABLE [dbo].[tb_auerA_estrattoA] (
    [auerA_codice_pk]     INT             IDENTITY (1, 1) NOT NULL,
    [auerA_uso]           INT             CONSTRAINT [DF_tb_auerA_estrattoA_auerA_uso] DEFAULT ((0)) NULL,
    [auerA_anno]          INT             NULL,
    [auerA_edile]         CHAR (1)        CONSTRAINT [DF_tb_auerA_estrattoA_auerA_edile] DEFAULT ('N') NULL,
    [auerA_cf]            VARCHAR (16)    NULL,
    [auerA_pos]           VARCHAR (50)    NULL,
    [auerA_denom]         VARCHAR (405)   NULL,
    [auerA_csc]           VARCHAR (5)     NULL,
    [auerA_ca]            VARCHAR (40)    NULL,
    [auerA_stato]         VARCHAR (30)    NULL,
    [auerA_data]          DATE            NULL,
    [auerA_data_inizio]   DATE            NULL,
    [auerA_media]         DECIMAL (10, 2) NULL,
    [auerA_data_modifica] DATETIME        CONSTRAINT [DF_tb_auerA_estrattoA_auerA_data_modifica] DEFAULT (getdate()) NULL
);

