-- =================================================================
-- Author:		<Maurizio Picone>
-- Create date: <02 Ottobre 2012>

-- Description:	
-- <Seleziona lo storico delle variazioni di stato di una PosContr>
-- Modificato da Raffaele il 15-01-2015
-- Estrae i soli record di variazioni di stato afferenti le interruzioni

CREATE PROCEDURE [dbo].[SP_STORICOVARIAZIONI_CC]
	@aupoc_codice_pk int

AS
BEGIN

	  SELECT 
   	   auvas_aupoc_codice_pk as aupoc_codice_pk,
	   --2013.07.08:
   	   --auvas_auspc_codice_pk as codice_stato,
   	   auspc_codice as codice_stato,
	   --2013.07.08.
   	   auspc_descr as descrizione_stato,
   	   CONVERT(VARCHAR(10), auvas_data_variazione_stato, 103) as data_variazione_stato
   	 
   	   
      FROM dbo.tb_auvas_var_stato_pos
  
	  INNER JOIN 
	  tb_auspc_stato_pos_contr_ct 
	  --2013.07.08:
	  --on tb_auspc_stato_pos_contr_ct.auspc_codice = auvas_auspc_codice_pk
	  on tb_auspc_stato_pos_contr_ct.auspc_codice_pk = auvas_auspc_codice_pk
	  --2013.07.08.
  
  	  --2016.07.22 AI 1088:
      INNER JOIN
      tb_aupoc_pos_contr
      on tb_aupoc_pos_contr.aupoc_codice_pk = auvas_aupoc_codice_pk
	  --2016.07.22 AI 1088.

  
	  WHERE 
	  tb_auvas_var_stato_pos.auvas_aupoc_codice_pk = @aupoc_codice_pk  and auvas_interruzioni = 1
  	  --2015.09.09 AI 6092:
	  and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
	  --2015.09.09 AI 6092.
	  --2016.07.22 AI 1088:
	  and (aupoc_auspc_codice_pk <> 1)
	  --2016.07.22 AI 1088.

      ORDER BY auvas_data_variazione_stato desc
  
  END
