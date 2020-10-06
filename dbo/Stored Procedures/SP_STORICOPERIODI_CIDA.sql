-- =============================================
-- Author:		<Maurizio Picone>
-- Create date: <17 Settembre 2012>
-- Description:	<Seleziona lo storico dei periodi>
-- =============================================
CREATE PROCEDURE [dbo].[SP_STORICOPERIODI_CIDA]
	@cida varchar(10), 
	@data_dal varchar(10),
	@data_al varchar(10)
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
      
     
  FROM dbo.tb_aupco_periodo_contr
  
  INNER JOIN 
  tb_aupoc_pos_contr ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk
  
  WHERE 
  tb_aupoc_pos_contr.aupoc_cida = @cida 
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
  
  CONVERT(datetime, aupco_data_inizio_validita,103) <= CONVERT(datetime, @data_al,103) 
  AND 
  CONVERT(datetime, aupco_data_fine_validita,103) >= CONVERT(datetime, @data_dal,103)

  --2013.10.29.

  ))
  
  ORDER BY aupco_data_inizio_validita desc
  
  END

