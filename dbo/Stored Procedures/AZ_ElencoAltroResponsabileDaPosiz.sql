-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 14.01.2014
-- Description:	Stored Procedure per caricare Altri Responsabili dal codice posizione

-- =============================================
-- =============================================
-- Author:		Letizia Bellantoni
-- Create date: 2015.04.23
-- Description:	AI3106

-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoAltroResponsabileDaPosiz]
	@codicePosizione int
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
		tb_autis_tipo_sog_col_ct.autis_descr AS DB_Carica, 
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
		--AI3106
		,aursp_autis_codice_pk  as DB_AurspAutis_Cod
		,aursp_tipo_soggetto    as DB_TipoSoggetto
		,CONVERT(varchar(10),aursp_data_domanda,103 )as DB_DataDomanda
		,aursp_tipo_domanda 	as DB_TipoDomanda
		--AI3106
	FROM         
		           tb_ausco_sog_contr_col INNER JOIN
                      tb_aursp_rel_sog_pos ON tb_ausco_sog_contr_col.ausco_codice_pk = tb_aursp_rel_sog_pos.aursp_ausco_codice_pk INNER JOIN
                      tb_autis_tipo_sog_col_ct ON tb_aursp_rel_sog_pos.aursp_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk INNER JOIN
                      tb_aupoc_pos_contr ON tb_aursp_rel_sog_pos.aursp_aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk 
						  
	WHERE 

	tb_aupoc_pos_contr.aupoc_codice_pk = @codicePosizione 
	--AND 
	--                  (tb_aursp_rel_sog_pos.aursp_data_di_fine_validita >= GETDATE()) AND 
 --                     (tb_aursp_rel_sog_pos.aursp_data_inizio_validita <= GETDATE()) OR
 --                     (tb_aursp_rel_sog_pos.aursp_data_di_fine_validita IS NULL) OR
 --                     (tb_aursp_rel_sog_pos.aursp_data_inizio_validita IS NULL)

ORDER BY   DB_DataFineValidita desc,DB_Carica asc, DB_Cognome asc, DB_Nome
	
	
END

