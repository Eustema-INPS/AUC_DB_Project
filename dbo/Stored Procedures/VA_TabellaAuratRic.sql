





-- =============================================
-- Author:		Emanuela Paletta
-- =============================================

-- =========================================================================================================
-- Creata da:  Emanuela
-- Data modifica:  17/06/2019
-- Description:		Elenco dati Tabella tb_aurat_report_azst_tra
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_TabellaAuratRic]
@anno as varchar(4),
@mese varchar(2)

AS
BEGIN


	SET NOCOUNT ON;
	

	IF RTRIM(@anno) = ''
	BEGIN
		SET @anno = '%%'
	END	

		IF RTRIM(@mese) = ''
	BEGIN
		SET @mese = '%%'
	END	


		select * from tb_aurat_report_azst_tra

		--IF RTRIM(@anno)<> ''  or RTRIM(@mese)<> '' 
		where  Convert(varchar, aurat_anno )  LIKE '%' + LTRIM(rtrim(@anno)) + '%'  and Convert(varchar, aurat_mese )  LIKE '%' + LTRIM(rtrim(@mese)) + '%' 
	
	
	 

END

