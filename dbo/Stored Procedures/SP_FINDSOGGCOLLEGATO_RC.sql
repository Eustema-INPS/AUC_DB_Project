
-- ======================================================================================
-- Author:		Maurizio Picone
-- Create date: 15 Novembre 2012
-- Description:	Dati Soggetto Collegato per WsLettura - Metodo EstraiDettagliAziendaRC
-- Modificata da: Raffaele
-- Data:		2016.10.03
-- Descrizione:	Conversione getdate
-- ======================================================================================

CREATE PROCEDURE [dbo].[SP_FINDSOGGCOLLEGATO_RC] 
	@codice_fiscale_azienda varchar(16)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1
		 ausco_codice_fiscale, 
		 ausco_cognome, 
		 ausco_nome, 
		 ausco_comune_nascita, 
		 ausco_data_nascita, 
		 ausco_prov_nascita, 
		 ausco_indirizzo, 
		 ausco_civico, 
		 ausco_cap, 
		 ausco_localita, 
		 ausco_provincia,
  --AI 2020:
		 ausco_toponimo,
		 ausco_telefono,
		 ausco_fax,
		 ausco_email,
		 ausco_PEC,
  --AI 2020.
		 CASE 
			  when tb_autis_tipo_sog_col_ct.autis_codice_carica='TI'  then 1 -- TITOLARE
			  when tb_autis_tipo_sog_col_ct.autis_codice_carica='LER' then 2 -- LEGALE RAPPRESENTANTE
			  when tb_autis_tipo_sog_col_ct.autis_codice_carica='ARE' then 3 -- ALTRO RESPONSABILE
			  else 999 
		 END
         AS autis_codice_carica
  
  FROM  [dbo].[tb_ausco_sog_contr_col]
  
  left outer join  [dbo].[tb_aurss_rel_sog_sog]
  on aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk
  
  left outer join  [dbo].[tb_ausca_sog_contr_az]
  on ausca_codice_pk = tb_aurss_rel_sog_sog.aurss_ausca_codice_pk
  
  left outer join  [dbo].tb_autis_tipo_sog_col_ct
  on autis_codice_pk = tb_aurss_rel_sog_sog.aurss_autis_codice_pk
  
  WHERE ausca_codice_fiscale = @codice_fiscale_azienda
  
  AND -- Tipo soggetto = <titolare> oppure <legale rappresentante> oppure <altro responsabile>
  (
	(	
	  tb_autis_tipo_sog_col_ct.autis_codice_carica='TI'    OR
	  tb_autis_tipo_sog_col_ct.autis_codice_carica='LER'   OR
	  tb_autis_tipo_sog_col_ct.autis_codice_carica='ARE'
	)
  ) 
  AND -- Data odierna compresa nelle date di inizio e fine validità
  (
		   convert(date,GETDATE(),103) BETWEEN aurss_data_inizio_validita AND aurss_data_di_fine_validita
--  	   (getdate() >= aurss_data_inizio_validita AND getdate() <= aurss_data_di_fine_validita)
	   or	 
	   (getdate() >= aurss_data_inizio_validita AND aurss_data_di_fine_validita IS NULL)
  ) 	
   
  ORDER BY autis_codice_carica	
END

