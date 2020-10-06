-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 27.12.2013
-- Description:	Stored Procedure per caricare Altri Responsabili

-- Modificata da: Letizia
-- Data:		2014.04.09
-- Descrizione:	Inserita aurss_relazione_certificata
-- =============================================
-- =============================================
-- Modificata da: Letizia
-- Data:		2015.04.24
-- Descrizione:	AI 3106
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoAltroResponsabileFiltro]
	@codiceAzienda int
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT
		distinct
		tb_ausco_sog_contr_col.ausco_codice_pk as DB_CodiceSoggetto,     
		tb_ausco_sog_contr_col.ausco_codice_fiscale AS DB_CodiceFiscale, 
		tb_ausco_sog_contr_col.ausco_cognome AS DB_Cognome, 
		tb_ausco_sog_contr_col.ausco_nome AS DB_Nome, 
		tb_ausco_sog_contr_col.ausco_tipo_persona AS DB_TipoPersona, 
		tb_ausca_sog_contr_az.ausca_denominazione as DB_Denominazione, 
		tb_autis_tipo_sog_col_ct.autis_descr AS DB_Carica, 
			--aggiornata da Letizia 20140409 
		'N'	 AS DB_Relazione_Certificata,
		case
			when (tb_aursp_rel_sog_pos.aursp_data_inizio_validita IS null) then 
				CONVERT(varchar(10),'01/01/1900',103) 
			else CONVERT(varchar(10),tb_aursp_rel_sog_pos.aursp_data_inizio_validita,103)
		end AS DB_DataInizioValidita,
		
		case
			when (tb_aursp_rel_sog_pos.aursp_data_di_fine_validita  IS null) then 
				CONVERT(varchar(10),'31/12/2999',103) 
			else CONVERT(varchar(10),tb_aursp_rel_sog_pos.aursp_data_di_fine_validita ,103)
		end AS DB_DataFIneValidita

	FROM         
		           tb_ausco_sog_contr_col INNER JOIN
                      tb_aursp_rel_sog_pos ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk INNER JOIN
                      tb_autis_tipo_sog_col_ct ON tb_aursp_rel_sog_pos.aursp_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk INNER JOIN
                      tb_aupoc_pos_contr ON tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk INNER JOIN
                      tb_ausca_sog_contr_az ON tb_aupoc_pos_contr.aupoc_ausca_codice_pk = tb_ausca_sog_contr_az.ausca_codice_pk 
                    	  
	WHERE 

	ausca_codice_pk = @codiceAzienda 

	--AI 3106
	--non si prendono in considerazione i collaboratori (artigiani e commercianti)
	and aursp_autis_codice_pk<>163
	--AI 3106
ORDER BY   DB_DataFineValidita desc,DB_Carica asc, DB_Cognome asc, DB_Nome
	
	
END

