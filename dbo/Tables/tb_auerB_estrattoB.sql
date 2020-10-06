CREATE TABLE [dbo].[tb_auerB_estrattoB] (
    [auerB_codice_pk]            INT             IDENTITY (1, 1) NOT NULL,
    [auerB_uso]                  INT             CONSTRAINT [DF_tb_auerB_estrattoB_auerB_uso] DEFAULT ((0)) NULL,
    [auerB_anno]                 INT             NULL,
    [auerB_edile]                CHAR (1)        CONSTRAINT [DF_tb_auerB_estrattoB_auerB_edile] DEFAULT ('N') NULL,
    [auerB_cf]                   VARCHAR (16)    NULL,
    [auerB_pos]                  VARCHAR (50)    NULL,
    [auerB_denom]                VARCHAR (405)   NULL,
    [auerB_csc]                  VARCHAR (5)     NULL,
    [auerB_ca]                   VARCHAR (40)    NULL,
    [auerB_stato]                VARCHAR (30)    NULL,
    [auerB_data]                 DATE            NULL,
    [auerB_data_inizio]          DATE            NULL,
    [auerB_media]                DECIMAL (10, 2) NULL,
    [auerB_cf_rl]                VARCHAR (16)    NULL,
    [auerB_data_inizio_validita] DATE            NULL,
    [auerB_data_fine_validita]   DATE            NULL,
    [auerB_data_modifica]        DATETIME        CONSTRAINT [DF_tb_auerB_estrattoB_auerB_data_modifica] DEFAULT (getdate()) NULL
);

