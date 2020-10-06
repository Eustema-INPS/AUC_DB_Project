


-- ===================================================================
-- Author:			Dimpflmeier & Palmieri 
-- Create date:		01/07/2016
-- Description:		Estrazione dati di una posizione contributiva IVA
-- Modificata:		Raffaele
-- Data modifica:	26/06/2017
-- Descrizione:		Impostata la lunghezza di settore, classe e categoria
-- ===================================================================

CREATE PROCEDURE [dbo].[SP_MLPS_DATI_POSCONTR] 

	@posizione varchar(50),
	@data_riferimento date 
	
AS
BEGIN
declare @stringa varchar(200)

	SET NOCOUNT ON;

	SET FMTONLY OFF;

create table #temp_pos(
posizione varchar (50),
denom_posiz_contr varchar(405),
SL_toponimo varchar(50),
SL_indirizzo varchar(255),
SL_civico varchar(50),
SL_cap varchar(10),
SL_sigla_provincia varchar(2),
SL_descr_comune varchar(30),
P_toponimo varchar(50),
P_indirizzo varchar(255),
P_civico varchar(50),
P_cap varchar(10),
P_sigla_provincia varchar(2),
P_descr_comune varchar(50),
attivita_dichiarata varchar(80),
cod_ateco_complessivo varchar(15),
data_inizio_attivita date,
descr_stato varchar(50),
data_ultimo_stato date,
cod_tipo varchar(2),
descr_tipo varchar(200),
cod_stat_contr varchar(5),
settore varchar(1),
classe varchar(2),
categoria varchar(2),
ca01 varchar(2),
descr_ca01 varchar(200),
ca02 varchar(2),
descr_ca02 varchar(200),
ca03 varchar(2),
descr_ca03 varchar(200),
ca04 varchar(2),
descr_ca04 varchar(200),
ca05 varchar(2),
descr_ca05 varchar(200),
ca06 varchar(2),
descr_ca06 varchar(200),
ca07 varchar(2),
descr_ca07 varchar(200),
ca08 varchar(2),
descr_ca08 varchar(200),
ca09 varchar(2),
descr_ca09 varchar(200),
ca10 varchar(2),
descr_ca10 varchar(200),
ca11 varchar(2),
descr_ca11 varchar(200),
ca12 varchar(2),
descr_ca12 varchar(200),
ca13 varchar(2),
descr_ca13 varchar(200),
ca14 varchar(2),
descr_ca14 varchar(200),
ca15 varchar(2),
descr_ca15 varchar(200),
ca16 varchar(2),
descr_ca16 varchar(200),
ca17 varchar(2),
descr_ca17 varchar(200),
ca18 varchar(2),
descr_ca18 varchar(200),
ca19 varchar(2),
descr_ca19 varchar(200),
ca20 varchar(2),
descr_ca20 varchar(200)
) on [primary]

set @stringa = (select  [aupco_codici_autor] from    [dbo].[tb_aupoc_pos_contr] 
   WITH (READUNCOMMITTED)    left outer join tb_aupco_periodo_contr WITH (READUNCOMMITTED) on aupco_aupoc_codice_pk = aupoc_codice_pk
   where 	  aupoc_posizione = @posizione 
	  and aupoc_aurea_codice_pk = 1 -- Posizione di IVA
	  and left([aupoc_posizione],1) <> 'Z'
	  and convert(date,[aupco_data_inizio_validita]) <= @data_riferimento
	  and convert(date,[aupco_data_fine_validita]) >= @data_riferimento
)

create table #temp_ca (prog int, ca varchar(2), descr varchar(200)) on [primary]
insert into #temp_ca(prog, ca, descr)
select * from [FN_MLPS_SPLIT_CA](@stringa, @data_riferimento)

insert into #temp_pos(
posizione ,
denom_posiz_contr ,
SL_toponimo ,
SL_indirizzo ,
SL_civico ,
SL_cap ,
SL_sigla_provincia ,
SL_descr_comune ,
P_toponimo ,
P_indirizzo ,
P_civico ,
P_cap ,
P_sigla_provincia ,
P_descr_comune ,
attivita_dichiarata ,
cod_ateco_complessivo ,
data_inizio_attivita,
descr_stato ,
data_ultimo_stato ,
cod_tipo,
descr_tipo ,
cod_stat_contr ,
settore ,
classe ,
categoria 
)
   SELECT 	 [aupoc_posizione],
			 [aupoc_denom_posiz_contr],
			 ausca_toponimo,
			 ausca_indirizzo,
			 ausca_civico,
			 ausca_cap,
			 ausca_sigla_provincia,
			 ausca_descr_comune,
			 auind_toponimo,
			 auind_indirizzo,
			 auind_civico,
			 auind_cap,
			 auind_sigla_provincia,
			 auind_descr_comune,
			 [aupoc_attivita_dichiarata],
			 [auate_cod_ateco_complessivo],
			 aupoc_data_inizio_attivita,
			 auspc_codice,
			 aupoc_data_ultimo_stato,
			 autia_codice,
			 autia_descrizione,
			 [aupco_cod_stat_contr],
			 substring(aucsc_settore,1,1),
			 substring(aucsc_classe,1,2),
			 substring(aucsc_categoria,1,2)
   FROM  [dbo].[tb_aupoc_pos_contr] 
   WITH (READUNCOMMITTED) Inner join Tb_ausca_sog_contr_az on aupoc_ausca_codice_pk = ausca_codice_pk
   left outer join tb_auind_indirizzi WITH (READUNCOMMITTED) on aupoc_codice_pk = auind_tabella_codice_pk and auind_tabella = 'AUPOC'
   left outer join tb_auate_cod_ateco_ct WITH (READUNCOMMITTED) on aupoc_auate_2007_codice_pk = auate_codice_pk
   left outer join tb_auspc_stato_pos_contr_ct WITH (READUNCOMMITTED) on auspc_codice_pk = aupoc_auspc_codice_pk
   left outer join tb_autia_tipo_accentr_ct WITH (READUNCOMMITTED) on aupoc_autia_codice_pk = autia_codice_pk
   left outer join tb_aupco_periodo_contr WITH (READUNCOMMITTED) on aupco_aupoc_codice_pk = aupoc_codice_pk 
   left outer join tb_aucsc_cod_stat_contr_ct WITH (READUNCOMMITTED) on [aupco_cod_stat_contr] = aucsc_codice
   WHERE 
	  aupoc_posizione = @posizione 
	  and aupoc_aurea_codice_pk = 1 -- Posizione di IVA
	  and left([aupoc_posizione],1) <> 'Z'
	  and convert(date,[aupco_data_inizio_validita]) <= @data_riferimento
	  and convert(date,[aupco_data_fine_validita]) >= @data_riferimento

update #temp_pos
set ca01 = ca, descr_ca01 = descr
from #temp_pos inner join #temp_ca on prog=1

update #temp_pos
set ca02 = ca, descr_ca02 = descr
from #temp_pos inner join #temp_ca on prog=2

update #temp_pos
set ca03 = ca, descr_ca03 = descr
from #temp_pos inner join #temp_ca on prog=3

update #temp_pos
set ca04 = ca, descr_ca04 = descr
from #temp_pos inner join #temp_ca on prog=4

update #temp_pos
set ca05 = ca, descr_ca05 = descr
from #temp_pos inner join #temp_ca on prog=5

update #temp_pos
set ca06 = ca, descr_ca06 = descr
from #temp_pos inner join #temp_ca on prog=6

update #temp_pos
set ca07 = ca, descr_ca07 = descr
from #temp_pos inner join #temp_ca on prog=7

update #temp_pos
set ca08 = ca, descr_ca08 = descr
from #temp_pos inner join #temp_ca on prog=8

update #temp_pos
set ca09 = ca, descr_ca09 = descr
from #temp_pos inner join #temp_ca on prog=9

update #temp_pos
set ca10 = ca, descr_ca10 = descr
from #temp_pos inner join #temp_ca on prog=10

update #temp_pos
set ca11 = ca, descr_ca11 = descr
from #temp_pos inner join #temp_ca on prog=11

update #temp_pos
set ca12 = ca, descr_ca12 = descr
from #temp_pos inner join #temp_ca on prog=12

update #temp_pos
set ca13 = ca, descr_ca13 = descr
from #temp_pos inner join #temp_ca on prog=13

update #temp_pos
set ca14 = ca, descr_ca14 = descr
from #temp_pos inner join #temp_ca on prog=14

update #temp_pos
set ca15 = ca, descr_ca15 = descr
from #temp_pos inner join #temp_ca on prog=15

update #temp_pos
set ca16 = ca, descr_ca16 = descr
from #temp_pos inner join #temp_ca on prog=16

update #temp_pos
set ca17 = ca, descr_ca17 = descr
from #temp_pos inner join #temp_ca on prog=17

update #temp_pos
set ca18 = ca, descr_ca18 = descr
from #temp_pos inner join #temp_ca on prog=18

update #temp_pos
set ca19 = ca, descr_ca19 = descr
from #temp_pos inner join #temp_ca on prog=19

update #temp_pos
set ca20 = ca, descr_ca20 = descr
from #temp_pos inner join #temp_ca on prog=20

select 
posizione                  ,
denom_posiz_contr          ,
SL_toponimo                ,
SL_indirizzo               ,
SL_civico                  ,
SL_cap                     ,
SL_sigla_provincia         ,
SL_descr_comune            ,
P_toponimo                 ,
P_indirizzo                ,
P_civico                   ,
P_cap                      ,
P_sigla_provincia          ,
P_descr_comune             ,
attivita_dichiarata        ,
cod_ateco_complessivo      ,
data_inizio_attivita       ,
descr_stato                ,
data_ultimo_stato          ,
cod_tipo                   ,
descr_tipo                 ,
cod_stat_contr             ,
settore                    ,
classe                     ,
categoria                  ,
ca01                       ,
descr_ca01                 ,
ca02                       ,
descr_ca02                 ,
ca03                       ,
descr_ca03                 ,
ca04                       ,
descr_ca04                 ,
ca05                       ,
descr_ca05                 ,
ca06                       ,
descr_ca06                 ,
ca07                       ,
descr_ca07                 ,
ca08                       ,
descr_ca08                 ,
ca09                       ,
descr_ca09                 ,
ca10                       ,
descr_ca10                 ,
ca11                       ,
descr_ca11                 ,
ca12                       ,
descr_ca12                 ,
ca13                       ,
descr_ca13                 ,
ca14                       ,
descr_ca14                 ,
ca15                       ,
descr_ca15                 ,
ca16                       ,
descr_ca16                 ,
ca17                       ,
descr_ca17                 ,
ca18                       ,
descr_ca18                 ,
ca19                       ,
descr_ca19                 ,
ca20                       ,
descr_ca20                 
from #temp_pos

END

