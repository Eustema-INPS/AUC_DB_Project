
-- =============================================
-- Autore:		Raffaele Palmieri & Italo Paioletti
-- Data:		2017.25.17
-- Ritorna i RL e Titolari di aziende aventi almento una posizione ex-Enpals
-- =============================================
CREATE PROCEDURE [dbo].[EX_Soggetti_Ex_Enpals]
	@data_inizio as date,
	@data_fine as date
AS
BEGIN
  SET NOCOUNT ON;

  if @data_inizio is null
	set @data_inizio = '1900-01-01'

  if @data_fine is null
	set @data_fine = '2999-12-31'
 
--Creazione prima tabella temporanea
create table #temp_01(cf varchar(16) null,fk_ausca int null) on [primary]

--Creazione prima tabella temporanea gemella
create table #temp_01bis(cf varchar(16) null,fk_ausca int null) on [primary]
CREATE NONCLUSTERED INDEX [Temp1Bis] ON [dbo].[#temp_01bis] ([fk_ausca]) INCLUDE ([cf])

--Inserimento in tabella temporanea dei cf afferenti a posizioni Sport e Spettacolo
insert into #temp_01 (cf,fk_ausca)
	SELECT tb_ausca_sog_contr_az.ausca_codice_fiscale, tb_ausca_sog_contr_az.ausca_codice_pk
	FROM tb_ausca_sog_contr_az INNER JOIN tb_aupoc_pos_contr  WITH (READUNCOMMITTED) ON 
		 tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk
	and aupoc_aurea_codice_pk = 4

-- CF Univoci
Insert into  #temp_01bis (cf ,fk_ausca)
	Select  #temp_01.cf,  #temp_01.fk_ausca FROM #temp_01
	Group by #temp_01.cf,  #temp_01.fk_ausca 

--


--Creazione seconda tabella temporanea
create table #temp_02(cf_az varchar(16) null, cf_sog varchar(16) null) on [primary]
create table #temp_02bis (cf_az varchar(16) null, cf_sog varchar(16) null) on [primary]

--Inserimento in tabella temporanea dei cf afferenti a posizioni Sport e Spettacolo e dei cf dei soggetti RL
--152.858
insert into #temp_02 (cf_az, cf_sog)
	select cf, ausco_codice_fiscale  from #temp_01bis
	inner join tb_aurss_rel_sog_sog WITH (NOLOCK) on aurss_ausca_codice_pk = #temp_01bis.fk_ausca
	inner join tb_ausco_sog_contr_col WITH (NOLOCK) on aurss_ausco_codice_pk = ausco_codice_pk
	where	aurss_rappresentante_legale = 'S'
	AND convert(date,getdate()) between convert(date,aurss_data_inizio_validita) AND convert(date,aurss_data_di_fine_validita)
	AND convert(date,aurss_data_modifica) between @data_inizio AND @data_fine 

insert into #temp_02bis (cf_az, cf_sog)
	SELECT #temp_02.cf_az , #temp_02.cf_sog
	FROM  #temp_02
	Group By cf_az , cf_sog

select cf_az as Codice_fiscale_azienda, cf_sog as Codice_fiscale_soggetto from #temp_02bis

drop table #temp_01
drop table #temp_02
drop table #temp_01bis
drop table #temp_02bis

END
