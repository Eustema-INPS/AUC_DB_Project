
-- =============================================
-- Author: Almaviva
-- Create date: 
-- Description:	AI 2063
--
-- Modificata da: 
-- Data: 24 settembre 2015
-- Descrizione: La stored ritorna i dati riguardanti le verifiche automatiche degli inquadramenti automatizzati.
--
-- Modificata da: Peter
-- Data: 22 dicembre 2015
-- Descrizione: aggiunti parametri @csc, @DataInizio, @DataFine.
--
-- Modificata da: Raffaele
-- Data: 13 settembre 2017
-- Descrizione: Modificato il criterio di estrazione dei record nel caso di KO, prima estraeva i record non esitati e quelli
--				esistati negativamente, adesso estrae i soli record non esistati dall'operatore di sede.
-- =============================================

CREATE PROCEDURE [dbo].[SP_FINDLISTACONTRINQAUTO] 
	-- parameters for the stored procedure 
	@esito_controllo int = null,
	@esito_verifica_oper_min int = null,
	@esito_verifica_oper_max int = null,
	@codice_provincia int,
	@codice_zona int,
	@csc varchar(5),
	@DataInizio datetime,
	@DataFine datetime

	AS
BEGIN

	SET NOCOUNT ON;

	--CODICE_FISCALE         
	--POSIZIONE              
	--ESITO                  
	--DATA_ULTIMO_CONTROLLO  
	--CODICE_ERRORE          
	--DESCRIZIONE_ERRORE     
	--ESITO_OPERATORE        
	--DATA_ESITO_OPERATORE   
	--MATRICOLA_OPERATORE    
	--NOTE_OPERATORE         

-- Almaviva 2015.12.21: differenziazione colonne selezionate a seconda del tipo di ricerca
if (@esito_controllo is null) 
begin

SELECT 
	   [ausca_codice_fiscale] as "CODICE FISCALE"
      ,[aupoc_posizione] as POSIZIONE
	  ,[aupco_cod_stat_contr] as "CSC"
      --,[AUPOC_INQ_ESITO_CONTROL] as COD_ESITO
      ,CASE [AUPOC_INQ_ESITO_CONTROL] when 1 then 'OK' when 2 then 'KO' else '' END as ESITO
      ,[AUPOC_INQ_DATA_PRIMO_CONTROL] as "PRIMO CONTROLLO"
      ,[AUPOC_INQ_DATA_ULTIMO_CONTROL] as "ULTIMO CONTROLLO"
      --,[AUPOC_INQ_COD_ERRORE_CONTROL] as "CODICE ERRORE"
      ,[AUPOC_INQ_DESCR_ERRORE] as "DESCRIZIONE ERRORE"
      --,[AUPOC_INQ_ESITO_VERIFICA_OPER] as COD_ESITO_OPERATORE
      ,CASE [AUPOC_INQ_ESITO_VERIFICA_OPER] when 1 then 'OK' when 2 then 'KO' when 3 then 'Da ricontrollare' else '' END as "ESITO OPERATORE"
      ,[AUPOC_INQ_DATA_ESITO_VERIFICA_OPER] as "DATA ESITO OPERATORE"
      ,[AUPOC_INQ_COD_OPER] as "MATRICOLA OPERATORE"
      --,[AUPOC_INQ_NOTE] as "NOTE OPERATORE"

  FROM [dbo].[tb_aupoc_pos_contr]
  INNER JOIN [dbo].[tb_ausca_sog_contr_az] ON aupoc_ausca_codice_pk = ausca_codice_pk
  LEFT OUTER JOIN [dbo].[tb_aupco_periodo_contr] ON 
  (aupco_aupoc_codice_pk = aupoc_codice_pk AND convert(date,getdate(),103) between aupco_data_inizio_validita and aupco_data_fine_validita)

  WHERE 
  1=1
  --AND AUPOC_INQ_ESITO_CONTROL = isnull(@esito_controllo, AUPOC_INQ_ESITO_CONTROL)
  AND AUPOC_INQ_ESITO_VERIFICA_OPER >= isnull(@esito_verifica_oper_min, AUPOC_INQ_ESITO_VERIFICA_OPER)
  AND AUPOC_INQ_ESITO_VERIFICA_OPER <= isnull(@esito_verifica_oper_max, AUPOC_INQ_ESITO_VERIFICA_OPER)
  AND aupoc_sede_provinciale = @codice_provincia
  AND convert(int, aupoc_sede_zonale) = @codice_zona

  AND aupco_cod_stat_contr like @csc
  AND CONVERT(date, AUPOC_INQ_DATA_ULTIMO_CONTROL) between @DataInizio and @DataFine

   ORDER BY [aupoc_posizione]
  
end

else if (@esito_controllo = 2) --KO
begin

SELECT 
      --CASE [AUPOC_INQ_ESITO_VERIFICA_OPER] when 1 then 'OK' when 2 then 'KO' when 3 then 'Da ricontrollare' else '' END as "ESITO OPERATORE"
	  [ausca_codice_fiscale] as "CODICE FISCALE"
      ,[aupoc_posizione] as POSIZIONE
	  ,[aupco_cod_stat_contr] as "CSC"
      ,CASE [AUPOC_INQ_ESITO_CONTROL] when 1 then 'OK' when 2 then 'KO' else '' END as ESITO
      ,[AUPOC_INQ_DESCR_ERRORE] as "DESCRIZIONE ERRORE"
      ,[AUPOC_INQ_DATA_PRIMO_CONTROL] as "PRIMO CONTROLLO"
      ,[AUPOC_INQ_DATA_ULTIMO_CONTROL] as "ULTIMO CONTROLLO"

  FROM [dbo].[tb_aupoc_pos_contr]
  INNER JOIN [dbo].[tb_ausca_sog_contr_az] ON aupoc_ausca_codice_pk = ausca_codice_pk
  LEFT OUTER JOIN [dbo].[tb_aupco_periodo_contr] ON 
  (aupco_aupoc_codice_pk = aupoc_codice_pk AND convert(date,getdate(),103) between aupco_data_inizio_validita and aupco_data_fine_validita)

  WHERE 
  1=1
  AND AUPOC_INQ_ESITO_CONTROL = @esito_controllo
  --AND AUPOC_INQ_ESITO_VERIFICA_OPER >= isnull(@esito_verifica_oper_min, AUPOC_INQ_ESITO_VERIFICA_OPER)
  --AND AUPOC_INQ_ESITO_VERIFICA_OPER <= isnull(@esito_verifica_oper_max, AUPOC_INQ_ESITO_VERIFICA_OPER)
  AND aupoc_sede_provinciale = @codice_provincia
  AND convert(int, aupoc_sede_zonale) = @codice_zona

  AND aupco_cod_stat_contr like @csc
  AND CONVERT(date, AUPOC_INQ_DATA_ULTIMO_CONTROL) between @DataInizio and @DataFine

--  AND AUPOC_INQ_ESITO_CONTROL = 2 
--  AND AUPOC_INQ_ESITO_VERIFICA_OPER <> 1

  AND AUPOC_INQ_ESITO_CONTROL = 2 
  AND AUPOC_INQ_ESITO_VERIFICA_OPER = 0


   ORDER BY [aupoc_posizione]

end


else if (@esito_controllo = 1) --OK
begin

SELECT 
	   [ausca_codice_fiscale] as "CODICE FISCALE"
      ,[aupoc_posizione] as POSIZIONE
	  ,[aupco_cod_stat_contr] as "CSC"
      ,CASE [AUPOC_INQ_ESITO_CONTROL] when 1 then 'OK' when 2 then 'KO' else '' END as ESITO
      ,[AUPOC_INQ_DATA_PRIMO_CONTROL] as "PRIMO CONTROLLO"
      ,[AUPOC_INQ_DATA_ULTIMO_CONTROL] as "ULTIMO CONTROLLO"

  FROM [dbo].[tb_aupoc_pos_contr]
  INNER JOIN [dbo].[tb_ausca_sog_contr_az] ON aupoc_ausca_codice_pk = ausca_codice_pk
  LEFT OUTER JOIN [dbo].[tb_aupco_periodo_contr] ON 
  (aupco_aupoc_codice_pk = aupoc_codice_pk AND convert(date,getdate(),103) between aupco_data_inizio_validita and aupco_data_fine_validita)

  WHERE 
  AUPOC_INQ_ESITO_CONTROL = @esito_controllo
  --AND AUPOC_INQ_ESITO_VERIFICA_OPER >= isnull(@esito_verifica_oper_min, AUPOC_INQ_ESITO_VERIFICA_OPER)
  --AND AUPOC_INQ_ESITO_VERIFICA_OPER <= isnull(@esito_verifica_oper_max, AUPOC_INQ_ESITO_VERIFICA_OPER)
  AND aupoc_sede_provinciale = @codice_provincia
  AND convert(int, aupoc_sede_zonale) = @codice_zona
  AND aupco_cod_stat_contr like @csc
  AND CONVERT(date, AUPOC_INQ_DATA_ULTIMO_CONTROL) between @DataInizio and @DataFine

   ORDER BY [aupoc_posizione]

end

END

