






create VIEW [dbo].[VI_AU_VCLASSIFICAZIONE]
AS
SELECT     
	dbo.tb_aungi_nat_giur_ct.aungi_codice_forma AS Codice,
	substring(dbo.tb_aungi_nat_giur_ct.aungi_descr_altern,1,50) as Descrizione
FROM  [dbo].tb_aungi_nat_giur_ct
where dbo.tb_aungi_nat_giur_ct.aungi_descr_altern is not null 




