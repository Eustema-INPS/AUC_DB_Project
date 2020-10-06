-- =============================================
-- Author:		<Maurizio Picone>
-- Create date: <02 Ottobre 2012>
-- Description:	<Seleziona lo storico delle variazioni di stato>
-- Modificato da Raffaele il 15-01-2015
-- Estrae i soli record di variazioni di stato afferenti le interruzioni
-- =============================================
CREATE PROCEDURE [dbo].[SP_STORICOVARIAZIONI_POS]
	@aupoc_posizione varchar(50) -- matricola
AS
BEGIN

	  SELECT 
   	   aupoc_posizione as matricola,
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
 
 
      INNER JOIN
      tb_aupoc_pos_contr
      on tb_aupoc_pos_contr.aupoc_codice_pk = auvas_aupoc_codice_pk
      
      WHERE tb_aupoc_pos_contr.aupoc_posizione = @aupoc_posizione  and auvas_interruzioni = 1
	  --2015.09.09 AI 6092:
	  and (auvas_dispositivo_utente is null or auvas_dispositivo_utente <> 'VARIAZ')
	  --2015.09.09 AI 6092.
	  --2016.07.22 AI 1088: se la posizione è attiva a oggi, non può aver avuto variazioni di stato
	  and (aupoc_auspc_codice_pk <> 1)
	  --2016.07.22 AI 1088.
    
	  ORDER BY auvas_data_variazione_stato desc  
  END
