-- =============================================
-- Author:		<Maurizio Picone>
-- Create date: <17 Settembre 2012>
-- Description:	<Seleziona lo storico dei periodi>
-- =============================================
-- ===================================================================
-- Author:			Letizia Bellantoni
-- Data Modifica :  20141010
-- Descrizione:     Aggiunti campi di aupco
-- ===================================================================
CREATE PROCEDURE [dbo].[SP_STORICOPERIODI_POS]
	@matricola varchar(50), 
	@data_dal varchar(10),
	@data_al varchar(10)
	with recompile
AS
BEGIN

	  if @data_dal = '' set @data_dal = '01/01/1900'
	  if @data_al = ''  set @data_al = '31/12/9999'

	   SELECT 
   	   aupco_codice_pk,
       aupco_cod_stat_contr,
       aupco_codici_autor,
  	   aupco_ateco_91,
       CONVERT(VARCHAR(10), aupco_data_inizio_validita, 103) as aupco_data_inizio_validita,
       CONVERT(VARCHAR(10), aupco_data_fine_validita, 103) as aupco_data_fine_validita
       --Letizia 20141010
				
		--richiesta Raffaele 2015.01.28:
		--,aupco_data_scad_autor
		,CONVERT(VARCHAR(10), aupco_data_scad_autor, 103) as aupco_data_scad_autor
		--richiesta Raffaele 2015.01.28.

        ,aupco_giorni_proroga 
        ,aupco_lavoratori_autonomi 
        ,[auate_cod_ateco_complessivo]
	  --Letizia 20141010
     
  FROM dbo.tb_aupco_periodo_contr
  
  INNER JOIN 
  tb_aupoc_pos_contr ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk
  
   --Letiza 20141010
	  left outer join [dbo].[tb_auate_cod_ateco_ct] -- AUATE
	  ON dbo.tb_aupco_periodo_contr.aupco_auate_2007_codice_pk = auate_codice_pk 
   --Letiza 20141010

  WHERE 
  tb_aupoc_pos_contr.aupoc_posizione = @matricola 
  AND
  
  ((
  --2013.10.29:
  
  --CONVERT(datetime, aupco_data_inizio_validita,103) >= CONVERT(datetime, @data_dal,103) 
  --AND 
  --CONVERT(datetime, aupco_data_inizio_validita,103) <= CONVERT(datetime, @data_al,103)
  --)
  --OR
  --(
  --CONVERT(datetime, aupco_data_fine_validita,103) >= CONVERT(datetime, @data_dal,103)
  --AND 
  --CONVERT(datetime, aupco_data_fine_validita,103) <= CONVERT(datetime, @data_al,103)
  
  --Peter 2014.10.20: talvolta si hanno errori
  CONVERT(datetime, aupco_data_inizio_validita,103) <= CONVERT(datetime, @data_al,103) 
  AND 
  CONVERT(datetime, aupco_data_fine_validita,103) >= CONVERT(datetime, @data_dal,103)
  --aupco_data_inizio_validita <= CONVERT(datetime, @data_al,103) 
  --AND 
  --aupco_data_fine_validita >= CONVERT(datetime, @data_dal,103)
  --Peter 2014.10.20.

  --2013.10.29.
  ))
  
  ORDER BY aupco_data_inizio_validita desc
  
  END
