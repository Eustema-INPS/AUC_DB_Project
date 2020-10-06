


-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  03/07/2018
-- Description:	Soggetto Contribuente - legge le regioni, province, comuni, belfiore, istat dalla vista "Competenze_AUC" del db AgendaSedi
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_RegioniProvinceComuni]

@RP varchar (200)

AS
BEGIN
	SET NOCOUNT ON;

SELECT  LTRIM(RTRIM([AgendaSedi].[dbo].[competenze_AUC].[regione]))  + ' # ' + LTRIM(RTRIM([ComuneI])) + ' (' + LTRIM(RTRIM([PROV]))+ ') '  + ' # '  + LTRIM(RTRIM([CAP])) + ' # ' + LTRIM(RTRIM([Belfiore])) + ' # ' + LTRIM(RTRIM([Common].[dbo].[Province].[Provincia])) + ' # ' + LTRIM(RTRIM([ComuneT]))  AS RegProv
FROM [AgendaSedi].[dbo].[competenze_AUC]
  inner join [Common].[dbo].[Province] on code_sigla = prov

WHERE [AgendaSedi].[dbo].[competenze_AUC].[regione] LIKE '%' + LTRIM(rtrim(@RP)) + '%' OR [Common].[dbo].[Province].[Provincia] LIKE '%' + LTRIM(rtrim(@RP)) + '%' OR [PROV] LIKE '%' + LTRIM(rtrim(@RP)) + '%'  OR [ComuneI] LIKE '%' + LTRIM(rtrim(@RP)) + '%' OR [CAP] LIKE '%' + LTRIM(rtrim(@RP)) + '%' OR [Belfiore] LIKE '%' + LTRIM(rtrim(@RP)) + '%' 
ORDER BY [ComuneI],[Common].[dbo].[Province].[Provincia]

END


