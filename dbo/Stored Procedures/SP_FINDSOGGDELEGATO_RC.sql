-- ============================================================================================================
--  Author:		Martini & Picone per WS
--  Create date: 
--  Description:	I soggetti delegati vengono recuperati attraverso le posizioni contributive dell’azienda.
--  Accesso alla tabella tb_ausca in join con <tb_aupoc_pos_contr>, <tb_aurad_rel_az_del> e <tb_audel_del>

--  qualificando:
 
--	ausca_codice_fiscale  = codice fiscale di input
--	ausca_codice_pk       = aupoc_ausca_codice_pk
--	aupoc_codice_pk       = aurad_aupoc_codice_pk
--	aurad_audel_codice_pk = audel_codice_pk
--	data operazione inclusa tra aurad_data_inizio_validita e aurad_data_di_fine_validita
--  oppure
--  data operazione >= aurad_data_inizio_validita ed aurad_data_di_fine_validita non impostata
-- ============================================================================================================

CREATE PROCEDURE [dbo].[SP_FINDSOGGDELEGATO_RC] 
	@matricola varchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 
		audel_codice_fiscale,
		audel_cognome,
		audel_nome,
		audel_data_nascita,
		audel_comune_nascita,
		audel_prov_nascita,
		audel_indirizzo,
		audel_civico,
		audel_cap,
		audel_descr_comune,
		audel_provincia,
        audel_descr_comune as audel_localita,
  --AI 2020:
		audel_toponimo,
		audel_telefono1,
		audel_fax,
		audel_email,
		audel_PEC,
  --AI 2020.
        autid_tipo_delegato
	    


	  FROM [dbo].[tb_audel_del] 

	  INNER JOIN tb_aurad_rel_az_del 
	  ON aurad_audel_codice_pk = audel_codice_pk
	  
	  INNER JOIN tb_autid_tipo_del_ct
	  on autid_codice_pk = aurad_autid_codice_pk

	  INNER JOIN tb_aupoc_pos_contr 
	  ON aupoc_codice_pk = aurad_aupoc_codice_pk
                      

      WHERE aupoc_posizione = @matricola
    --  AND 
    --  (   
    --      -- Data odierna compresa nella validità (soggetto non scaduto)
		  --aurad_data_inizio_validita <= getdate()  
		  --and 
		  --aurad_data_fine_validita >= getdate()
    --  )
  
END
