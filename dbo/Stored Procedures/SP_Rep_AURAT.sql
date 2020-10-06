


-- =============================================
-- Author:		Palmieri-Paletta
-- Create date: 
-- Data:		2019.07.30
-- Descrizione:	report AURAT Trasmissioni Monitoraggio Produzione AZST
-- =============================================
CREATE PROCEDURE [dbo].[SP_Rep_AURAT]

AS
BEGIN
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [aurat_identificativo_trasmissione] as IdTrasmissione
      ,[aurat_anno] as Anno
      ,[aurat_mese] as Mese
      ,[aurat_data_invio] as DataInvio
      ,[aurat_esito_invio_codice] as CodiceEsitoInvio
      ,[aurat_esito_invio_descrizione] as DescrizioneEsitoInvio
--      ,[aurat_xml_invio_request]
--      ,[aurat_xml_invio_response]
  FROM [AUC].[dbo].[tb_aurat_report_azst_tra]
  order by 2,3
  END



