



-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  14/03/2018
-- Description:		Elenco dati Tabella da Gestire.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaStorDaGest]
@codiceTab as int

AS
BEGIN


	SET NOCOUNT ON;
	
	--DECLARE @DATA int
	--SET @DATA = 1

	declare @tb as varchar(500)
	declare @str as varchar(500)

	SELECT top 1 @tb = CASE (@codiceTab) 
	WHEN 1 THEN ' TB_AUSSS_SISTEMA_STORICO order by ausss_data_storicizza desc '
	WHEN 2 THEN 'TB_AUFZS_FUNZIONI_STORICO'
	WHEN 3 THEN 'TB_AUACS_ATECO_STORICO'
	WHEN 4 THEN 'TB_AUCAU_COD_AUTOR_CT'
	WHEN 5 THEN 'TB_AUCSC_COD_STAT_CONTR_CT'
	WHEN 6 THEN 'TB_AUCME_CODICI_MES_ERR'
	WHEN 7 THEN 'TB_AUSIS_AUSIN_STORICO'
	WHEN 14 THEN 'TB_AUPOE_POSIZIONIERRATE'
	WHEN 15 THEN 'TB_AURAT_REPORT_AZST_TRA'
	END 
	
	set @str= 'select * from ' + @tb

	exec(@str)
	--print @str


	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100


END


/****** Object:  StoredProcedure [dbo].[VA_TabellaDaGest]    Script Date: 16/09/2019 10:10:02 ******/
SET ANSI_NULLS ON
