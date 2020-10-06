



-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  03/07/2018
-- Description:	Soggetto Contribuente - legge le regioni, province, comuni, belfiore, istat dalla vista "Competenze_AUC" del db AgendaSedi
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_RegioniProvinceComuni1]

@RP varchar (200)

AS
BEGIN
	SET NOCOUNT ON;

SELECT  LTRIM(RTRIM([AgendaSedi].[dbo].[competenze_AUC].[regione]))  + ' # ' + LTRIM(RTRIM([ComuneI])) + ' (' + LTRIM(RTRIM([PROV]))+ ') '  + ' # '  + LTRIM(RTRIM([CAP])) + ' # ' + LTRIM(RTRIM([Belfiore])) + ' # ' + LTRIM(RTRIM([Common].[dbo].[Province].[Provincia])) + ' # ' + LTRIM(RTRIM([ComuneT]))  AS RegProv
FROM [AgendaSedi].[dbo].[competenze_AUC]
  inner join [Common].[dbo].[Province] on code_sigla = prov

WHERE [AgendaSedi].[dbo].[competenze_AUC].[regione] LIKE '%' + LTRIM(rtrim(@RP)) + '%' OR [Common].[dbo].[Province].[Provincia] LIKE '%' + LTRIM(rtrim(@RP)) + '%' OR [PROV] LIKE '%' + LTRIM(rtrim(@RP)) + '%'  OR [ComuneI] LIKE '%' + LTRIM(rtrim(@RP)) + '%' OR [CAP] LIKE '%' + LTRIM(rtrim(@RP)) + '%' OR [Belfiore] LIKE '%' + LTRIM(rtrim(@RP)) + '%' 

UNION
SELECT        '99 # ' + LTRIM(RTRIM(Stato_estero)) + '(EE) # 00000 #' + LTRIM(RTRIM(Codice_Belfiore)) + '# STATO ESTERO #' AS RegProv
FROM            [AUC].[dbo].[TB_AUEEE_Stati_Esteri]

WHERE Stato_estero LIKE '%' + LTRIM(rtrim(@RP)) + '%' OR Codice_Belfiore LIKE '%' + LTRIM(rtrim(@RP)) + '%' 

ORDER BY  RegProv

END




