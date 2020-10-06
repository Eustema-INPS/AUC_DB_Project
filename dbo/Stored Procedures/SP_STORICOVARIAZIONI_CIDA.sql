-- =============================================
-- Author:		<Maurizio Picone>
-- Create date: <05 Ottobre 2012>
-- Description:	<Seleziona lo storico delle variazioni di stato>
-- =============================================
create PROCEDURE [dbo].[SP_STORICOVARIAZIONI_CIDA]
	@aupoc_cida varchar(10) -- cida
AS
BEGIN

	  SELECT 
   	   aupoc_cida as aupoc_cida,
   	   auvas_auspc_codice_pk as codice_stato,
   	   auspc_descr as descrizione_stato,
   	   CONVERT(VARCHAR(10), auvas_data_variazione_stato, 103) as data_variazione_stato
   	   
      FROM dbo.tb_auvas_var_stato_pos
  
	  INNER JOIN 
	  tb_auspc_stato_pos_contr_ct 
	  on tb_auspc_stato_pos_contr_ct.auspc_codice = auvas_auspc_codice_pk
  
      INNER JOIN
      tb_aupoc_pos_contr
      on tb_aupoc_pos_contr.aupoc_codice_pk = auvas_aupoc_codice_pk
  
      WHERE tb_aupoc_pos_contr.aupoc_cida = @aupoc_cida
  
      ORDER BY auvas_data_variazione_stato desc  
  END
