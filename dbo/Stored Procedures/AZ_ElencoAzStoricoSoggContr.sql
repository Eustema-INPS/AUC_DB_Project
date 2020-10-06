




-- =============================================
-- Author:		Emanuela Paletta
-- Create date: 08.11.2017
-- Description:	Stored Procedure per caricare lo storico delle variazioni sogg contr
-- =============================================

CREATE PROCEDURE [dbo].[AZ_ElencoAzStoricoSoggContr]
	@codSoggetto int
	/*,
	@codAzienda int*/
AS
BEGIN
	SELECT
		tb_ausca_sog_contr_az.ausca_codice_pk as DB_CodiceAzienda,
		tb_ausca_sog_contr_az.[ausca_codice_fiscale] as DB_CodiceFiscaleAzienda,
		tb_ausco_sog_contr_col.ausco_codice_pk as DB_CodiceSoggetto,     
		tb_ausco_sog_contr_col.ausco_codice_fiscale AS DB_CodiceFiscale, 

		Case ausco_tipo_persona
		when 'G' then substring(ausco_denominazione,1,255) 
		else  ausco_cognome
		end	AS DB_Cognome,

		--tb_ausco_sog_contr_col.ausco_cognome AS DB_Cognome, 
		tb_ausco_sog_contr_col.ausco_nome AS DB_Nome, 
		tb_ausco_sog_contr_col.ausco_tipo_persona AS DB_TipoPersona, 
		tb_ausca_sog_contr_az.ausca_denominazione as DB_Denominazione, 
		--tb_ausco_sog_contr_col.ausco_denominazione as DB_Denominazione, 
		tb_autis_tipo_sog_col_ct.autis_descr AS DB_Carica, 

		case
			when ( tb_ausrs_storico_rel_sog.ausrs_relazione_certificata IS null) then 
				'N'
			else  tb_ausrs_storico_rel_sog.ausrs_relazione_certificata
		end AS DB_Relazione_Certificata,
		
		CONVERT(varchar(10), tb_ausrs_storico_rel_sog.ausrs_data_inizio_validita,103) AS DB_DataInizioValidita,
		CONVERT(varchar(10), tb_ausrs_storico_rel_sog.ausrs_data_di_fine_validita,103) AS DB_DataFineValidita
	FROM         
		tb_ausca_sog_contr_az INNER JOIN
		 tb_ausrs_storico_rel_sog ON tb_ausca_sog_contr_az.ausca_codice_pk =  tb_ausrs_storico_rel_sog.ausrs_ausca_codice_pk INNER JOIN
		tb_ausco_sog_contr_col ON  tb_ausrs_storico_rel_sog.ausrs_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk INNER JOIN
		tb_autis_tipo_sog_col_ct ON  tb_ausrs_storico_rel_sog.ausrs_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
	WHERE ausco_codice_pk = @codSoggetto 
	/*and ausca_codice_pk = @codAzienda*/

    ORDER BY ausrs_data_di_fine_validita desc, DB_Carica desc, DB_Denominazione asc 

END


