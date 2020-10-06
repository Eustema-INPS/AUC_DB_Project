


-- =============================================
-- Author:		Palmieri-Paletta
-- Create date: 
-- Data:		2019.07.30
-- Descrizione:	report AURAZ Storico Totalizzazioni Modelli AZST
-- =============================================
CREATE PROCEDURE [dbo].[SP_Rep_AURAZ]

AS
BEGIN
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [auraz_codice_modello] as CodiceModello
      ,[auraz_guid_trasmissione] as IdTrasmissione
      ,[auraz_azregion] as Regione
      ,[auraz_azstapro] as Provincia
      ,[auraz_azstazon] as Zona
      ,[auraz_gi] as Giacenza
      ,[auraz_perv1] as Pervenuto1
      ,[auraz_perv2] as Pervenuto2
      ,[auraz_defa] as DefA
      ,[auraz_defr1] as DefR1
      ,[auraz_defr2] as DefR2
      ,[auraz_data_modifica] as Data
      ,[Auraz_stato] as Stato
      ,[Auraz_esito_elab_codice] as CodiceEsitoElaborazione
      ,[Auraz_esito_elab_descrizione] as DescrizioneEsitoElaborazione
      ,[Auraz_data_inizio] as DataInizio
      ,[Auraz_data_fine] as DataFine
  FROM [AUC].[dbo].[tb_auraz_report_azst]
  order by 1,3,4,5
  END



