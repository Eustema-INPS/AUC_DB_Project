


-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  14/03/2018
-- Description:		Elenco dati Tabella da Gestire.
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaDaGest]
@codiceTab as int

AS
BEGIN


	SET NOCOUNT ON;
	

	--DECLARE @DATA int
	--SET @DATA = 1

	declare @tb as varchar(500)
	declare @str as varchar(500)

	SELECT top 1 @tb = CASE (@codiceTab) 
	WHEN 1 THEN 'TB_AUSYS_SISTEMA a left join (SELECT ausys_codice_pk, MAX(ausss_data_storicizza) AS ausss_data_storicizza
				 FROM tb_ausss_sistema_storico
				 GROUP BY ausys_codice_pk) b on a.Ausys_codice_pk = b.Ausys_codice_pk order by b.ausss_data_storicizza desc'
	WHEN 2 THEN 'TB_AUFUN_FUNZ_SISTEMA'
	WHEN 3 THEN 'TB_AUATE_COD_ATECO_CT'
	WHEN 4 THEN 'TB_AUCAU_COD_AUTOR_CT'
	WHEN 5 THEN 'TB_AUCSC_COD_STAT_CONTR_CT'
	WHEN 6 THEN 'TB_AUCME_CODICI_MES_ERR order by Aucme_codice_pk desc'
	WHEN 7 THEN 'TB_AUSIN_SEDI_INPS_CT'
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




/****** Object:  StoredProcedure [dbo].[VA_TabellaAuratRic]    Script Date: 18/06/2019 11:08:22 ******/
SET ANSI_NULLS ON
