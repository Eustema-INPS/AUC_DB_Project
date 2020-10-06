CREATE procedure [dbo].[AZ_ViewListCodiciSede]
AS
SELECT     ausin_codice_pk, ausin_codice_sede +' - '+ ausin_descr AS Sede,ausin_descr
FROM         dbo.tb_ausin_sedi_inps_ct
order by ausin_codice_sede
