-- =============================================
-- Author:		Letizia Belllantoni
-- Create date: 2014.09.05
-- Description:	Carica visualizzazione del log
-- =============================================
CREATE PROCEDURE [dbo].[AP_VisualizzaLog] 
@nomeattore varchar(50),
@tipologia varchar(50),
@datainizio varchar(10),
@datafine varchar(10),
@topparam int

AS
BEGIN

if (@topparam=null or @topparam=0)
set @topparam=1000

SELECT top (@topparam) [aulog_codice_pk], 
            [aulog_tipo_contesto], 
            Upper([aulog_nome_attore]) as [aulog_nome_attore], 
            [aulog_data_log], 
            [aulog_aucme_codice_pk], 
            [aulog_descr_breve], 
            [aulog_descr_lunga] 
FROM [tb_aulog_log] WHERE aulog_tipo_contesto = @tipologia 
AND [aulog_data_log]
BETWEEN Convert(DateTime,@datainizio + ' 00:00',103)
AND Convert(DateTime,@datafine+' 23:59',103)
AND (aulog_nome_attore=@nomeattore or @nomeattore is null or @nomeattore='')
ORDER BY [aulog_data_log] DESC
END

