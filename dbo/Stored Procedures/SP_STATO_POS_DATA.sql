

-- ===================================================================
-- Author:		Peter Dimpflmeier
-- Action Item: 2074
-- Create date: 2016.06.27
-- 
-- ===================================================================

CREATE PROCEDURE [dbo].[SP_STATO_POS_DATA] 
	@posizione varchar(50),
	@data_riferimento datetime	
AS
BEGIN
	SET NOCOUNT ON;	
	
SELECT 
--*
top 1 auspc_codice as codice, auspc_descr as descrizione, convert(date,data_stato) as data
FROM

(

--Fonte 1: Variazioni di stato (AUVAS)
SELECT 
    'auvas' as fonte
    ,auvas_aupoc_codice_pk as codice_posizione
    ,auvas_auspc_codice_pk as stato
    ,auvas_data_variazione_stato as data_stato
	,aupoc_posizione as posizione
  FROM             
	tb_auvas_var_stato_pos INNER JOIN
	tb_aupoc_pos_contr ON tb_auvas_var_stato_pos.auvas_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk 
  WHERE aupoc_posizione = @posizione 
	--AI 1088:
  and aupoc_auspc_codice_pk <> 1
	--AI 1088.

UNION

--Fonte 2: stato corrente su AUPOC
SELECT 
	'aupoc_curr' as fonte
	,aupoc_codice_pk as codice_posizione
	,[aupoc_auspc_codice_pk] as stato
	,ISNULL([aupoc_data_ultimo_stato], CONVERT(date, getdate())) as data_stato
	,[aupoc_posizione] as posizione
from tb_aupoc_pos_contr
  WHERE aupoc_posizione = @posizione 
  	--AI 1088:
  and aupoc_auspc_codice_pk <> 1
	--AI 1088.

UNION

--Fonte 3: stato "attiva" alla data inizio attività di AUPOC
SELECT 
	'aupoc_iniz' as fonte
	,aupoc_codice_pk as codice_posizione
	,1 as stato
	,[aupoc_data_inizio_attivita] as data_stato
	,[aupoc_posizione] as posizione
from tb_aupoc_pos_contr
  WHERE aupoc_posizione = @posizione

) STATI

INNER JOIN
tb_auspc_stato_pos_contr_ct ON STATI.stato = tb_auspc_stato_pos_contr_ct.auspc_codice_pk

where data_stato <= @data_riferimento

order by data_stato desc, stato desc


END


