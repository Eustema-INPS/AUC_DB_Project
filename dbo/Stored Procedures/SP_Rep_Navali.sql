-- =============================================
-- Author:		Palmieri-Paletta
-- Create date: 
-- Data:		2018.11.30
-- Descrizione:	report navali
-- =============================================
CREATE PROCEDURE [dbo].[SP_Rep_Navali]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   
   create table #temp_richieste(
                [TIPORICH] [smallint] NOT NULL,
                [MATAZI] [varchar](10) NOT NULL,
                [DATARICH] [datetime] NOT NULL,
                [QUESTIONARIO_xml] [xml] NULL,
                [QUESTIONARIO_var] varchar(max) NULL) on [primary];

execute as login = 'AUC'
insert into #temp_richieste( [TIPORICH],[MATAZI],[DATARICH],[QUESTIONARIO_var])
SELECT  *   FROM  OPENQUERY([SQLSERVER500],
'SELECT  [TIPORICH]
      ,[MATAZI]
      ,[DATARICH]
      ,cast([QUESTIONARIO] as varchar (max) ) FROM [DMAnagrafica].[dbo].[RichiesteInternet_DatiNavali]') 

update #temp_richieste
set [QUESTIONARIO_xml] = cast([QUESTIONARIO_var] as xml)

create table #temp_navali(matricola varchar(10) null, data datetime null, quest xml null)

insert into #temp_navali (matricola, data)
SELECT [MATAZI], max (datarich)
  FROM #temp_richieste
  group by matazi

update #temp_navali
set quest = questionario_xml
from #temp_navali
inner join #temp_richieste on matricola collate SQL_Latin1_General_CP1_CI_AS = matazi and data = datarich


  create table #temp_quest (matricola varchar(10) null, data datetime null, codice_dom varchar(1) null, domanda varchar(200) null, risposta varchar(100) null) on [primary];
  
;WITH XMLNAMESPACES( 
                'urn:schemas-microsoft-com:xml-msdata' AS ns,
                'urn:schemas-microsoft-com:xml-diffgram-v1' AS diffgr )
insert into #temp_quest (matricola, data, codice_dom, domanda, risposta)
SELECT matricola, data as datacompilazione,
  datatable.value('codiceDomanda[1]', 'varchar(16)') AS CodiceDomanda,
  replace(replace(datatable.value('domanda[1]','varchar(200)'),'<br />a',''),'<br />','') as Domanda,
  datatable.value('risposta[1]','varchar(100)') as Risposta
  FROM #temp_navali 
  CROSS APPLY quest.nodes('/DataTable/diffgr:diffgram/DocumentElement/RisposteDate') AS T1(datatable)
  order by matricola, datatable.value('codiceDomanda[1]', 'varchar(16)') asc

  create table #temp_finale (matricola varchar(10) null, data datetime null,
  domanda1 varchar(200) null,
  risposta1 varchar(100) null,
  domanda2 varchar(200) null,
  risposta2 varchar(100) null,
  domanda3 varchar(200) null,
  risposta3 varchar(100) null,
  domanda4 varchar(200) null,
  risposta4 varchar(100) null,
  domanda5 varchar(200) null,
  risposta5 varchar(100) null,
  domanda6 varchar(200) null,
  risposta6 varchar(100) null,
  domanda7 varchar(200) null,
  risposta7 varchar(100) null,
  domanda8 varchar(200) null,
  risposta8 varchar(100) null,
  domanda9 varchar(200) null,
  risposta9 varchar(100) null,
  domanda10 varchar(200) null,
  risposta10 varchar(100) null) on [primary];

  insert into #temp_finale (matricola, data, domanda1, risposta1)
( 
SELECT matricola, data, domanda, risposta
  FROM #temp_quest 
where codice_dom = 1)

update #temp_finale
set domanda2 = domanda,
risposta2 = risposta
from #temp_finale
inner join #temp_quest on #temp_quest.matricola = #temp_finale.matricola and #temp_quest.data = #temp_finale.data 
where codice_dom = 2

update #temp_finale
set domanda3 = domanda,
risposta3 = risposta
from #temp_finale
inner join #temp_quest on #temp_quest.matricola = #temp_finale.matricola and #temp_quest.data = #temp_finale.data 
where codice_dom = 3

update #temp_finale
set domanda4 = domanda,
risposta4 = risposta
from #temp_finale
inner join #temp_quest on #temp_quest.matricola = #temp_finale.matricola and #temp_quest.data = #temp_finale.data 
where codice_dom = 4

update #temp_finale
set domanda5 = domanda,
risposta5 = risposta
from #temp_finale
inner join #temp_quest on #temp_quest.matricola = #temp_finale.matricola and #temp_quest.data = #temp_finale.data 
where codice_dom = 5

update #temp_finale
set domanda6 = domanda,
risposta6 = risposta
from #temp_finale
inner join #temp_quest on #temp_quest.matricola = #temp_finale.matricola and #temp_quest.data = #temp_finale.data 
where codice_dom = 6

update #temp_finale
set domanda7 = domanda,
risposta7 = risposta
from #temp_finale
inner join #temp_quest on #temp_quest.matricola = #temp_finale.matricola and #temp_quest.data = #temp_finale.data 
where codice_dom = 7

select matricola as Posizione
                ,data as DataUltimaCompilazione
                ,aupco_cod_stat_contr as CscAttuale 
                ,aupco_codici_autor as CaAttuale
                ,auspc_descr as StatoAttuale
                ,domanda1, risposta1
                ,domanda2, risposta2
                ,domanda3, risposta3
                ,domanda4, risposta4
                ,domanda5, risposta5
                ,domanda6, risposta6
                ,domanda7, risposta7
from #temp_finale
left outer join tb_aupoc_pos_contr on aupoc_posizione = matricola and aupoc_aurea_codice_pk = 1
left outer join tb_aupco_periodo_contr on aupco_aupoc_codice_pk = aupoc_codice_pk
left outer join tb_auspc_stato_pos_contr_ct on aupoc_auspc_codice_pk = auspc_codice_pk
where convert(date,aupco_data_inizio_validita) <= convert(date,getdate())  and convert(date,aupco_data_fine_validita) >= convert(date,getdate())
END


