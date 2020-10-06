-- =============================================
-- Author:		Maurizio Picone
-- =============================================
CREATE PROCEDURE [dbo].[AP_CheckAssociazioni]	
	@aufun_codice_pk int
AS
BEGIN

SELECT     
 dbo.tb_aufun_funz_sistema.aufun_codice_pk, 
 dbo.tb_auref_rel_entita_funz.auref_codice_entita_rif, 
 dbo.tb_auapp_appl.auapp_descr, 
 dbo.tb_auapp_appl.auapp_app_name

FROM         
 dbo.tb_auref_rel_entita_funz 
 INNER JOIN
 dbo.tb_aufun_funz_sistema ON dbo.tb_auref_rel_entita_funz.auref_aufun_codice_pk = dbo.tb_aufun_funz_sistema.aufun_codice_pk 
 INNER JOIN
 dbo.tb_auapp_appl ON dbo.tb_auref_rel_entita_funz.auref_codice_entita_rif = dbo.tb_auapp_appl.auapp_codice_pk
                      
WHERE tb_aufun_funz_sistema.aufun_codice_pk = @aufun_codice_pk

END
