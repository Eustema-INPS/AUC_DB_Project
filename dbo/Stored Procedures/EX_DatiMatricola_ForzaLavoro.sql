



-- =============================================
-- Autore:		Raffaele 
-- Data:		2019.03.19
-- Descrizione:	La procedura riceve in input un codice fiscale di un soggetto contribuente e fornisce in output:
--				Codice Fisale Soggetto Contribuente (CfSoggettoContribuente)
--				Denominazione Soggetto Contribuente (DenominazioneSoggettoContribuente)
--				Codice Forma Giuridica Soggetto Contribuente (CodiceFormaGiuridica)
--				Descrizione Forma giuridica Soggetto Contribuente (FormaGiuridica)
--				Prefisso Stradale Soggetto Contribuente (PrefissoStradale_SL)
--				Nome Via Soggetto Contribuente (NomeVia_SL)
--				Numero civico Soggetto Contribuente (NumeroCivico_SL)
--				CAP Soggetto Contribuente (CAP_SL)
--				Comune Soggetto Contribuente (Comune_SL)
--				Provincia Soggetto Contribuente (Provincia_SL)
--				Codice Regione Soggetto Contribuente (CodiceRegione)
--				Codice Regione ISTAT Soggetto Contribuente (CodiceRegioneIstat)
--				Descrizione Regione Soggetto Contribuente (Regione)
--				Codice Belfiore Soggetto Contribuente (CodiceBelfioreSL)
--				Codice Ateco 1991 Soggetto Contribuente (Ateco91SoggettoContribuente)
--				Descrizione Codice Ateco 1991 Soggetto Contribuente (DescrizioneAteco91SoggettoContribuente)
--				Codice Ateco 2002 Soggetto Contribuente (Ateco02SoggettoContribuente)
--				Descrizione Codice Ateco 2002 Soggetto Contribuente (DescrizioneAteco02SoggettoContribuente)
--				Codice Ateco 2007 Soggetto Contribuente (Ateco07SoggettoContribuente)
--				Descrizione Codice Ateco 2007 Soggetto Contribuente (DescrizioneAteco07SoggettoContribuente)
--				PEC Soggetto Contribuente (PEC)
--				Posizione (Posizione)
--				Area appartenenza Posizione (AreaPosizione)
--				Descrizione Stato Posizione (DescrizioneStato)
--				Forza Lavoro Posizione (ForzaLavoro)
--				Data Riferimento Forza Lavoro Posizione (DataForzaLavoro)
--				Codice Ateco 1991 Posizione (Ateco91Posizione)
--				Descrizione Codice Ateco 1991 Posizione (DescrAteco91Posizione)
--				Codice Ateco 2002 Posizione (Ateco02Posizione)
--				Descrizione Codice Ateco 2002 Posizione (DescrAteco02Posizione)
--				Codice Ateco 2007 Posizione (DescrAteco07Posizione)
--				Descrizione Codice Ateco 2007 Posizione (DescrAteco07Posizione)
-- =============================================
-- Modifica:	Raffaele
-- Data:		29/03/2019
-- Descrizione:	Inserita l'estrazione del campo ausca_cod_com_Belfiore
-- =============================================


CREATE PROCEDURE [dbo].[EX_DatiMatricola_ForzaLavoro]
	@cf as varchar(16)
AS
BEGIN
  SET NOCOUNT ON;

create table #tempprovRegione (provincia varchar(2), regione varchar(2), regioneIstat varchar(2), descrRegione varchar(30)) on [primary];

insert into #tempprovRegione (provincia, regione, regioneIstat, descrregione)
SELECT 
      [aualc_PROV]
      ,[aualc_regione]
      ,[aualc_ISTAT_Codice_Regione]
	  , case when [aualc_regione] = '01' then 'PIEMONTE'
	         when [aualc_regione] = '02' then 'VAL D'' AOSTA'
	         when [aualc_regione] = '03' then 'LOMBARDIA'
	         when [aualc_regione] = '04' then 'LIGURIA'
	         when [aualc_regione] = '05' then 'TRENTINO ALTO ADIGE'
	         when [aualc_regione] = '06' then 'VENETO'
	         when [aualc_regione] = '07' then 'FRIULI VENEZIA GIULIA'
	         when [aualc_regione] = '08' then 'EMILIA ROMAGNA'
	         when [aualc_regione] = '09' then 'TOSCANA'
	         when [aualc_regione] = '10' then 'UMBRIA'
	         when [aualc_regione] = '11' then 'MARCHE'
	         when [aualc_regione] = '12' then 'LAZIO'
	         when [aualc_regione] = '13' then 'ABRUZZO'
	         when [aualc_regione] = '14' then 'MOLISE'
	         when [aualc_regione] = '15' then 'CAMPANIA'
	         when [aualc_regione] = '16' then 'PUGLIA'
	         when [aualc_regione] = '17' then 'BASILICATA'
	         when [aualc_regione] = '18' then 'CALABRIA'
	         when [aualc_regione] = '19' then 'SICILIA'
	         when [aualc_regione] = '20' then 'SARDEGNA'
	  end as Regione
  FROM [AUC].[dbo].[tb_aualc_Allineamento_Comuni]
  group by       [aualc_PROV], [aualc_regione], [aualc_regione_inps], [aualc_ISTAT_Codice_Regione]

create table #temp(cf varchar(16), posizione varchar(50), stato int, descr_stato varchar(100), area int, 
					descr_area varchar(50), forzalavoro int, dataforzalavoro int,
					cod_ateco91 int, ateco91 varchar(10), descr_ateco91 varchar(200),
					cod_ateco02 int, ateco02 varchar(10), descr_ateco02 varchar(200),
					cod_ateco07 int, ateco07 varchar(10), descr_ateco07 varchar(200)) on [primary];

-- inizio determinazione forza lavoro
insert into #temp(cf, posizione, stato, descr_stato, area, descr_area)
select @cf, aupoc_posizione, aupoc_auspc_codice_pk, auspc_descr, aupoc_aurea_codice_pk, aurea_descrizione
from tb_aupoc_pos_contr 
inner join tb_ausca_sog_contr_az on aupoc_ausca_codice_pk = ausca_codice_pk 
left join tb_auspc_stato_pos_contr_ct on aupoc_auspc_codice_pk = auspc_codice_pk
left join tb_aurea_area_gestione on aupoc_aurea_codice_pk = aurea_codice_pk
where ausca_codice_fiscale = @cf

create table #tempdataFL(posizione varchar(50), data int) on [primary]
insert into #tempdataFL(posizione, data)
select aufor_posizione, max(aufor_annomese) from tb_aufor_forze_lavoro
inner join #temp on #temp.posizione = aufor_posizione
group by aufor_posizione

update #temp
set dataforzalavoro = data
from #temp 
inner join #tempdataFL on #temp.posizione = #tempdataFL.posizione

update #temp
set forzalavoro = aufor_num_dip_dic
from #temp 
inner join tb_aufor_forze_lavoro on aufor_posizione = posizione and dataforzalavoro = aufor_annomese

--aggiornamento ateco 91 non per posizioni IVA
update #temp
set cod_ateco91 = aupoc_auate_1991_codice_pk,
	ateco91 = auate_cod_ateco_complessivo,
	descr_ateco91 = auate_cod_sottocategoria_tit
from #temp 
inner join tb_aupoc_pos_contr on aupoc_posizione = posizione
inner join tb_auate_cod_ateco_ct on aupoc_auate_1991_codice_pk = auate_codice_pk
where area <> 1

--aggiornamento ateco 2002 non per posizioni IVA
update #temp
set cod_ateco02 = aupoc_auate_2002_codice_pk,
	ateco02 = auate_cod_ateco_complessivo,
	descr_ateco02 = auate_cod_sottocategoria_tit
from #temp 
inner join tb_aupoc_pos_contr on aupoc_posizione = posizione
inner join tb_auate_cod_ateco_ct on aupoc_auate_2002_codice_pk = auate_codice_pk
where area <> 1

--aggiornamento ateco 2007 non per posizioni IVA
update #temp
set cod_ateco07 = aupoc_auate_2002_codice_pk,
	ateco07 = auate_cod_ateco_complessivo,
	descr_ateco07 = auate_cod_sottocategoria_tit
from #temp 
inner join tb_aupoc_pos_contr on aupoc_posizione = posizione
inner join tb_auate_cod_ateco_ct on aupoc_auate_2007_codice_pk = auate_codice_pk
where area <> 1

--aggiornamento ateco 91 per posizioni IVA
update #temp
set cod_ateco91 = aupco_auate_1991_codice_pk,
	ateco91 = auate_cod_ateco_complessivo,
	descr_ateco91 = auate_cod_sottocategoria_tit
from #temp 
inner join tb_aupoc_pos_contr on aupoc_posizione = posizione
inner join tb_aupco_periodo_contr on aupco_aupoc_codice_pk = aupoc_codice_pk
inner join tb_auate_cod_ateco_ct on aupco_auate_1991_codice_pk = auate_codice_pk
where area = 1 and convert(date,getdate()) >= convert(date,aupco_data_inizio_validita) 
				and convert(date,aupco_data_fine_validita) >= convert(date,getdate())

--aggiornamento ateco 2002 per posizioni IVA
update #temp
set cod_ateco02 = aupco_auate_2002_codice_pk,
	ateco02 = auate_cod_ateco_complessivo,
	descr_ateco02 = auate_cod_sottocategoria_tit
from #temp 
inner join tb_aupoc_pos_contr on aupoc_posizione = posizione
inner join tb_aupco_periodo_contr on aupco_aupoc_codice_pk = aupoc_codice_pk
inner join tb_auate_cod_ateco_ct on aupco_auate_2002_codice_pk = auate_codice_pk
where area = 1 and convert(date,getdate()) >= convert(date,aupco_data_inizio_validita) 
				and convert(date,aupco_data_fine_validita) >= convert(date,getdate())

--aggiornamento ateco 2007 per posizioni IVA
update #temp
set cod_ateco07 = aupco_auate_2007_codice_pk,
	ateco07 = auate_cod_ateco_complessivo,
	descr_ateco07 = auate_cod_sottocategoria_tit
from #temp 
inner join tb_aupoc_pos_contr on aupoc_posizione = posizione
inner join tb_aupco_periodo_contr on aupco_aupoc_codice_pk = aupoc_codice_pk
inner join tb_auate_cod_ateco_ct on aupco_auate_2007_codice_pk = auate_codice_pk
where area = 1 and convert(date,getdate()) >= convert(date,aupco_data_inizio_validita) 
				and convert(date,aupco_data_fine_validita) >= convert(date,getdate())

  SELECT        
 
 tb_ausca_sog_contr_az.ausca_codice_fiscale as CfSoggettoContribuente
,tb_ausca_sog_contr_az.ausca_denominazione as DenominazioneSoggettoContribuente
,tb_aungi_nat_giur_ct.aungi_codice_forma as CodiceFormaGiuridica
,tb_aungi_nat_giur_ct.aungi_descr_breve as FormaGiuridica
,tb_ausca_sog_contr_az.ausca_toponimo as PrefissoStradale_SL
,tb_ausca_sog_contr_az.ausca_indirizzo as NomeVia_SL
,tb_ausca_sog_contr_az.ausca_civico as NumeroCivico_SL
,tb_ausca_sog_contr_az.ausca_cap as CAP_SL
,tb_ausca_sog_contr_az.ausca_descr_comune as Comune_SL
,tb_ausca_sog_contr_az.ausca_sigla_provincia as Provincia_SL
,regione as CodiceRegione
,regioneIstat as CodiceRegioneIstat
,descrRegione as Regione
,ausca_cod_com_Belfiore as CodiceBelfioreSL
,tb_auate_cod_ateco_ct_91.auate_cod_ateco_complessivo as Ateco91SoggettoContribuente
,tb_auate_cod_ateco_ct_91.auate_cod_sottocategoria_tit as DescrizioneAteco91SoggettoContribuente
,tb_auate_cod_ateco_ct_02.auate_cod_ateco_complessivo AS Ateco02SoggettoContribuente
,tb_auate_cod_ateco_ct_02.auate_cod_sottocategoria_tit as DescrizioneAteco02SoggettoContribuente 
,tb_auate_cod_ateco_ct_07.auate_cod_ateco_complessivo AS Ateco07SoggettoContribuente
,tb_auate_cod_ateco_ct_07.auate_cod_sottocategoria_tit as DescrizioneAteco07SoggettoContribuente
,tb_ausca_sog_contr_az.ausca_pec as PEC
,posizione as Posizione
,descr_area as AreaPosizione
,descr_stato as DescrizioneStato
,forzalavoro as ForzaLavoro
,dataforzalavoro as DataForzaLavoro
,ateco91 as Ateco91Posizione
,descr_ateco91 as DescrAteco91Posizione
,ateco02 as Ateco02Posizione
,descr_ateco02 as DescrAteco02Posizione
,ateco07 as Ateco07Posizione
,descr_ateco07 as DescrAteco07Posizione
FROM  
tb_ausca_sog_contr_az WITH (READUNCOMMITTED)  --AUSCA
LEFT JOIN tb_aungi_nat_giur_ct WITH (READUNCOMMITTED) ON tb_ausca_sog_contr_az.ausca_aungi_codice_pk = tb_aungi_nat_giur_ct.aungi_codice_pk --AUNGI
LEFT JOIN tb_auate_cod_ateco_ct AS tb_auate_cod_ateco_ct_91 ON tb_ausca_sog_contr_az.ausca_auate_1991_codice_pk = tb_auate_cod_ateco_ct_91.auate_codice_pk 
LEFT JOIN tb_auate_cod_ateco_ct AS tb_auate_cod_ateco_ct_02 ON tb_ausca_sog_contr_az.ausca_auate_2002_codice_pk = tb_auate_cod_ateco_ct_02.auate_codice_pk 
LEFT JOIN tb_auate_cod_ateco_ct AS tb_auate_cod_ateco_ct_07 ON tb_ausca_sog_contr_az.ausca_auate_2007_codice_pk = tb_auate_cod_ateco_ct_07.auate_codice_pk
left join #tempprovregione on ausca_sigla_provincia = provincia
inner join #temp on @cf = cf
where ausca_codice_fiscale = @cf
END



