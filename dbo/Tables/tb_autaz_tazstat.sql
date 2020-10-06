﻿CREATE TABLE [dbo].[tb_autaz_tazstat] (
    [autaz_codice_pk]           BIGINT       IDENTITY (1, 1) NOT NULL,
    [autaz_azstapro]            INT          NULL,
    [autaz_azstaazi]            INT          NULL,
    [autaz_azstacod]            INT          NULL,
    [autaz_azstazon]            INT          NULL,
    [autaz_azcodopr]            VARCHAR (2)  NULL,
    [autaz_azmatdip]            VARCHAR (8)  NULL,
    [autaz_azregion]            INT          NULL,
    [autaz_azdatopr]            VARCHAR (8)  NULL,
    [autaz_azoraopr]            VARCHAR (8)  NULL,
    [autaz_data_operazione_str] VARCHAR (30) NULL,
    [autaz_data_operazione]     AS           (CONVERT([datetime],(((((((((((substring([autaz_data_operazione_str],(1),(4))+'-')+substring([autaz_data_operazione_str],(5),(2)))+'-')+substring([autaz_data_operazione_str],(7),(2)))+' ')+substring([autaz_data_operazione_str],(9),(2)))+':')+substring([autaz_data_operazione_str],(9),(2)))+':')+substring([autaz_data_operazione_str],(13),(2)))+':')+substring([autaz_data_operazione_str],(15),(2)),(120))),
    [autaz_azproven]            INT          NULL,
    [autaz_azflagop]            INT          NULL,
    [autaz_azflag01]            INT          NULL,
    [autaz_azflag02]            INT          NULL,
    [autaz_azflag03]            INT          NULL,
    [autaz_azflag04]            INT          NULL,
    [autaz_azflag05]            INT          NULL,
    [autaz_data_modifica]       DATETIME     CONSTRAINT [DF_tb_autaz_tazstat_autaz_data_modifica] DEFAULT (getdate()) NULL,
    [autaz_descr_utente]        VARCHAR (50) CONSTRAINT [DF_tb_autaz_tazstat_autaz_descr_utente] DEFAULT ('AZ124_30_TAZSTAT') NULL,
    CONSTRAINT [PK_tb_autaz] PRIMARY KEY CLUSTERED ([autaz_codice_pk] ASC),
    CONSTRAINT [UQ_autaz_autaz] UNIQUE NONCLUSTERED ([autaz_codice_pk] ASC)
);

