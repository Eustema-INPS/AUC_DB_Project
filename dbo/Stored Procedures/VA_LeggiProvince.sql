

CREATE PROCEDURE [dbo].[VA_LeggiProvince]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT
	  P.Code_Sigla AS SiglaProvincia
	  ,P.Provincia + ' (' + LTRIM(RTRIM(P.Code_Sigla)) + ')' AS NomeProvincia
      ,P.Regione AS RegioneProvincia
	FROM 
		[Common].[dbo].[Province] AS P
	ORDER BY 2 ASC;
END

