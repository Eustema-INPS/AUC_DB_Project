
-- =============================================
-- Author:		Letizia Belllantoni
-- Create date: 2014.09.03
-- Description:	carica lista nomi attore applicazione
-- =============================================
CREATE PROCEDURE [dbo].[AP_LoadListaNomeAttore] 
@nomeattore varchar(25)
AS
BEGIN
	
	SET NOCOUNT ON;


	/****** Script for SelectTopNRows command from SSMS  ******/
	SELECT Upper([auapp_app_name]) as [aulog_nome_attore]
      
  FROM [AUC].[dbo].[tb_auapp_appl]
  where [auapp_app_name] is not null


 --   select DISTINCT Upper([aulog_nome_attore]) as [aulog_nome_attore]
	--from [tb_aulog_log] 
	--where aulog_nome_attore LIKE @nomeattore+'%'
END

