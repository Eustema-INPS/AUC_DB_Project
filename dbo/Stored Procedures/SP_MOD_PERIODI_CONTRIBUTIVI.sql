
-- =============================================
-- Author:		RP
-- Create date: 06/07/2017
-- Description:	Selezione periodi contributivi di una posizione

-- =============================================
CREATE PROCEDURE [dbo].[SP_MOD_PERIODI_CONTRIBUTIVI] 
	-- Add the parameters for the stored procedure here
	@posizione varchar(50),
	@CA varchar(2),
	@data_inizio date,
	@data_fine date

	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
CREATE TABLE #temp_aupco_periodo_contr(
	[aupco_codice_pk] [bigint] NOT NULL,
	[aupco_aupoc_codice_pk] [int] NULL,
	[aupco_auate_codice_pk] [int] NULL,
	[aupco_data_inizio_validita] [datetime] NULL,
	[aupco_data_fine_validita] [datetime] NULL,
	[aupco_data_scad_autor] [datetime] NULL,
	[aupco_giorni_proroga] [int] NULL,
	[aupco_cod_stat_contr] [varchar](5) NULL,
	[aupco_codici_autor] [varchar](60) NULL,
	[aupco_lavoratori_autonomi] [int] NULL,
	[aupco_inserimento] [varchar](50) NULL,
	[aupco_ateco_91] [varchar](100) NULL,
	[aupco_flag_operativo] [int] NULL,
	[aupco_aucsc_codice_pk] [int] NULL,
	[aupco_data_modifica] [datetime] NULL,
	[aupco_descr_utente] [varchar](50) NULL,
	[aupco_codice_pk_db2] [bigint] NULL,
	[aupco_auate_1991_codice_pk] [int] NULL,
	[aupco_auate_2002_codice_pk] [int] NULL,
	[aupco_auate_2007_codice_pk] [int] NULL,
	[aupco_rec_del] [varchar](1) NULL,
	[aupco_data_del] [datetime] NULL) on [primary];

CREATE TABLE #temp_aupco_totale(
	[aupco_codice_pk] [bigint] NOT NULL,
	[aupco_aupoc_codice_pk] [int] NULL,
	[aupco_auate_codice_pk] [int] NULL,
	[aupco_data_inizio_validita] [datetime] NULL,
	[aupco_data_fine_validita] [datetime] NULL,
	[aupco_data_scad_autor] [datetime] NULL,
	[aupco_giorni_proroga] [int] NULL,
	[aupco_cod_stat_contr] [varchar](5) NULL,
	[aupco_codici_autor] [varchar](60) NULL,
	[aupco_lavoratori_autonomi] [int] NULL,
	[aupco_inserimento] [varchar](50) NULL,
	[aupco_ateco_91] [varchar](100) NULL,
	[aupco_flag_operativo] [int] NULL,
	[aupco_aucsc_codice_pk] [int] NULL,
	[aupco_data_modifica] [datetime] NULL,
	[aupco_descr_utente] [varchar](50) NULL,
	[aupco_codice_pk_db2] [bigint] NULL,
	[aupco_auate_1991_codice_pk] [int] NULL,
	[aupco_auate_2002_codice_pk] [int] NULL,
	[aupco_auate_2007_codice_pk] [int] NULL,
	[aupco_rec_del] [varchar](1) NULL,
	[aupco_data_del] [datetime] NULL) on [primary];


insert into #temp_aupco_periodo_contr 
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,[aupco_data_inizio_validita]
      ,[aupco_data_fine_validita]
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
      ,[aupco_descr_utente]
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM [AUC].[dbo].[tb_aupco_periodo_contr]
  inner join tb_aupoc_pos_contr on aupoc_codice_pk = aupco_aupoc_codice_pk
  where aupoc_posizione = @posizione

--Inizio Sezione A
--condizione A1
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,[aupco_data_inizio_validita]
      ,convert(datetime,@data_inizio)-1
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'A1'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_inizio > convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita])) and
		(@data_fine > convert(date,[aupco_data_fine_validita]))

--condizione A2
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,@data_inizio
      ,[aupco_data_fine_validita]
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'A2'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_inizio > convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita])) and
		(@data_fine > convert(date,[aupco_data_fine_validita]))

--condizione Abis
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,[aupco_data_inizio_validita]
      ,[aupco_data_fine_validita]
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'Abis'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_inizio = convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita])) and
		(@data_fine > convert(date,[aupco_data_fine_validita]))
--Fine Sezione A

--Inizio Sezione B
--condizione B1
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,[aupco_data_inizio_validita]
      ,@data_fine
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'B1'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine < convert(date,[aupco_data_fine_validita])) and
		(@data_inizio < convert(date,[aupco_data_inizio_validita]))

--condizione B2
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,convert(datetime,@data_fine)+1
      ,[aupco_data_fine_validita]
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'B2'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine < convert(date,[aupco_data_fine_validita])) and
		(@data_inizio < convert(date,[aupco_data_inizio_validita]))

--condizione Bbis
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,[aupco_data_inizio_validita]
      ,[aupco_data_fine_validita]
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'Bbis'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine = convert(date,[aupco_data_fine_validita])) and
		(@data_inizio < convert(date,[aupco_data_inizio_validita]))

--Fine Sezione B

--Inizio Sezione C
--condizione C1
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,[aupco_data_inizio_validita]
      ,convert(datetime,@data_inizio)-1
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'C1'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine < convert(date,[aupco_data_fine_validita])) and
		(@data_inizio > convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita]))

--condizione C2
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,@data_inizio
      ,@data_fine
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'C2'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine < convert(date,[aupco_data_fine_validita])) and
		(@data_inizio > convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita]))

--condizione C3
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,convert(datetime,@data_fine)+1
      ,[aupco_data_fine_validita]
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'C3'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine < convert(date,[aupco_data_fine_validita])) and
		(@data_inizio > convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita]))


--condizione C4
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,[aupco_data_inizio_validita]
      ,@data_fine
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'C4'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine < convert(date,[aupco_data_fine_validita])) and
		(@data_inizio = convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita]))

--condizione C5
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,convert(datetime,@data_fine) + 1
      ,aupco_data_fine_validita
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'C5'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine < convert(date,[aupco_data_fine_validita])) and
		(@data_inizio = convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita]))


--condizione C6
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,[aupco_data_inizio_validita]
      ,convert(datetime,@data_inizio)-1
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'C6'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine = convert(date,[aupco_data_fine_validita])) and
		(@data_inizio > convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita]))

--condizione C7
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,@data_inizio
      ,aupco_data_fine_validita
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'C7'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine = convert(date,[aupco_data_fine_validita])) and
		(@data_inizio > convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita]))

--condizione C8
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,aupco_data_inizio_validita
      ,aupco_data_fine_validita
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'C8'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine = convert(date,[aupco_data_fine_validita])) and
		(@data_inizio = convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita]))

--Fine Sezione C

--Inizio Sezione D

--condizione D1
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,aupco_data_inizio_validita
      ,aupco_data_fine_validita
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'D1'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_inizio_validita]) and @data_fine >= convert(date,[aupco_data_fine_validita])) and
		(@data_inizio <= convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_fine_validita]))

--Fine Sezione D


--Inizio Sezione E

--condizione E1
insert into #temp_aupco_totale
SELECT [aupco_codice_pk]
      ,[aupco_aupoc_codice_pk]
      ,[aupco_auate_codice_pk]
      ,aupco_data_inizio_validita
      ,aupco_data_fine_validita
      ,[aupco_data_scad_autor]
      ,[aupco_giorni_proroga]
      ,[aupco_cod_stat_contr]
      ,[aupco_codici_autor]
      ,[aupco_lavoratori_autonomi]
      ,[aupco_inserimento]
      ,[aupco_ateco_91]
      ,[aupco_flag_operativo]
      ,[aupco_aucsc_codice_pk]
      ,[aupco_data_modifica]
--      ,[aupco_descr_utente]
	  ,'E1'
      ,[aupco_codice_pk_db2]
      ,[aupco_auate_1991_codice_pk]
      ,[aupco_auate_2002_codice_pk]
      ,[aupco_auate_2007_codice_pk]
      ,[aupco_rec_del]
      ,[aupco_data_del]
  FROM #temp_aupco_periodo_contr
  where (@data_fine > convert(date,[aupco_data_fine_validita]) and @data_inizio > convert(date,[aupco_data_fine_validita]) ) or
        (@data_fine < convert(date,[aupco_data_inizio_validita]) and @data_inizio < convert(date,[aupco_data_inizio_validita]) ) 

--Fine Sezione E

  select * from #temp_aupco_totale


END

