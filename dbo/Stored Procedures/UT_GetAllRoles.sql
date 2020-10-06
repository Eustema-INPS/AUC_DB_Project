-- =============================================
-- Author:		Mpicone
-- =============================================
CREATE PROCEDURE [dbo].[UT_GetAllRoles] 

AS
BEGIN
	SELECT 
	dbo.tb_auruo_ruolo.auruo_codice_pk as DB_Codice,
	dbo.tb_auruo_ruolo.auruo_descr as DB_Descrizione
	
	from dbo.tb_auruo_ruolo
END
