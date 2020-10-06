-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 27.12.2013
-- Description:	Stored Procedure per caricare tutte le aziende di cui il sogg. è altro responsabile

-- =============================================
-- Modificata da: Letizia
-- Data:		2014.06.23
-- Descrizione:	Inserito codice fiscale azienda
-- =============================================
-- =============================================
-- Modificata da: Letizia
-- Data:		2015.04.24
-- Descrizione:	AI 3106
-- =============================================


CREATE PROCEDURE [dbo].[AZ_ElencoAziendeSoggettoAltroResp]
	@codSoggetto int
AS
BEGIN
	SELECT distinct
		tb_ausca_sog_contr_az.ausca_codice_pk as DB_CodiceAzienda,
	    tb_ausca_sog_contr_az.[ausca_codice_fiscale] as DB_CodiceFiscaleAzienda,
		tb_ausco_sog_contr_col.ausco_codice_pk as DB_CodiceSoggetto,     
		tb_ausco_sog_contr_col.ausco_codice_fiscale AS DB_CodiceFiscale, 

		Case ausco_tipo_persona
		when 'G' then substring(ausco_denominazione,1,255) 
		else  ausco_cognome
		end	AS DB_Cognome,

		
		tb_ausco_sog_contr_col.ausco_nome AS DB_Nome, 
		tb_ausco_sog_contr_col.ausco_tipo_persona AS DB_TipoPersona, 
		tb_ausca_sog_contr_az.ausca_denominazione as DB_Denominazione, 
	
		tb_autis_tipo_sog_col_ct.autis_descr AS DB_Carica, 
		CONVERT(varchar(10),tb_aursp_rel_sog_pos.aursp_data_inizio_validita,103) AS DB_DataInizioValidita,
		CONVERT(varchar(10),tb_aursp_rel_sog_pos.aursp_data_di_fine_validita ,103) AS DB_DataFineValidita
	FROM         
		   tb_ausco_sog_contr_col INNER JOIN
                      tb_aursp_rel_sog_pos ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk INNER JOIN
                      tb_autis_tipo_sog_col_ct ON tb_aursp_rel_sog_pos.aursp_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk INNER JOIN
                      tb_aupoc_pos_contr ON tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk INNER JOIN
                      tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk 
               
	WHERE ausco_codice_pk = @codSoggetto 
	--AI 3106
	--non si prendono in considerazione i collaboratori (artigiani e commercianti)
	and aursp_autis_codice_pk<>163
	--AI 3106

    ORDER BY DB_DataFineValidita  desc, DB_Carica desc, DB_Denominazione asc 

END

