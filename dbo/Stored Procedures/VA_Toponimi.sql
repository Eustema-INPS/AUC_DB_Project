





-- =============================================
-- Author:		E.PALETTA
-- =============================================

-- =========================================================================================================
-- Data modifica:  18/10/2017
-- Description:	Soggetto Contribuente - legge i toponimi dalla tabella tb_autop_toponimi su AUC 
-- ---------A REGIME ------dalla vista "Competenze_AUC" del db AgendaSedi
-- =========================================================================================================
CREATE PROCEDURE [dbo].[VA_Toponimi]

@RP varchar (200)

AS
BEGIN
	SET NOCOUNT ON;

SELECT  distinct  rtrim(autop_toponimo)  + ' - ' +  rtrim(autop_toponimo_breve) as Toponimo

FROM    tb_autop_toponimi

WHERE autop_toponimo LIKE '%' + LTRIM(rtrim(@RP)) + '%' 

order by Toponimo


END




