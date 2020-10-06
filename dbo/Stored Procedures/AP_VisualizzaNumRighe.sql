-- =============================================
-- Author:		Letizia Belllantoni
-- Create date: 2014.09.05
-- Description:	Carica Num occorrenze per ciascun attore
-- =============================================
CREATE PROCEDURE [dbo].[AP_VisualizzaNumRighe] 
@nomeattore varchar(50),
@tipologia varchar(50),
@datainizio varchar(10),
@datafine varchar(10)
AS

BEGIN



SELECT     Upper( [aulog_nome_attore]) as [aulog_nome_attore], 
            count(*) as num_occorrenza
FROM [tb_aulog_log] WHERE aulog_tipo_contesto = @tipologia 
AND [aulog_data_log]
BETWEEN Convert(DateTime,@datainizio + ' 00:00',103)
AND Convert(DateTime,@datafine+' 23:59',103)
AND (aulog_nome_attore=@nomeattore or @nomeattore is null or @nomeattore='')
group by [aulog_nome_attore]
END

