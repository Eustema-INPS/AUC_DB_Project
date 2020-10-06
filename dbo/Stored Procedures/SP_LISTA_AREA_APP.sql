

-- ===================================================================
-- Author:		Letizia Bellantoni
-- Create date: 2014.07.01
-- Description:	estrae elenco area applicazione per azienda
-- Modificata da Raffaele il 2015.03.25
-- Cambiato il puntamento non più all'applicazione ma all'area.
-- ===================================================================
CREATE PROCEDURE [dbo].[SP_LISTA_AREA_APP] 
	
    @codice_fiscale_azienda varchar(16) -- CF Azienda
	
AS
BEGIN
   SET NOCOUNT ON;
	  
--SELECT     distinct(tb_auapp_appl.auapp_descr) as DB_AreaApp
--FROM            tb_ausca_sog_contr_az INNER JOIN
--                tb_aupoc_pos_contr ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk INNER JOIN
--                tb_auapp_appl ON tb_aupoc_pos_contr.aupoc_auapp_codice_pk = tb_auapp_appl.auapp_codice_pk
-- where  tb_ausca_sog_contr_az.ausca_codice_fiscale=@codice_fiscale_azienda

SELECT     distinct(tb_aurea_area_gestione.aurea_descrizione) as DB_AreaApp
FROM            tb_ausca_sog_contr_az INNER JOIN
                tb_aupoc_pos_contr ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk INNER JOIN
                tb_aurea_area_gestione ON tb_aupoc_pos_contr.aupoc_aurea_codice_pk = tb_aurea_area_gestione.aurea_codice_pk
 where  tb_ausca_sog_contr_az.ausca_codice_fiscale=@codice_fiscale_azienda
		    
	  
  
 
END



