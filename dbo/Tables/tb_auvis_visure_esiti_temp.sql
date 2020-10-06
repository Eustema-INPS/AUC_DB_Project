CREATE TABLE [dbo].[tb_auvis_visure_esiti_temp] (
    [auvis_id]            INT      NULL,
    [auvis_elaborato]     INT      NULL,
    [auvis_data_modifica] DATETIME CONSTRAINT [DF_tb_auvis_visure_esiti_temp_auvis_data_modifica] DEFAULT (getdate()) NOT NULL
);

