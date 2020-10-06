



-- =============================================
-- Author:		Emanuela Paletta
-- Create date: 08.11.2017
-- Description:	Stored Procedure per caricare lo storico delle variazioni sogg contr
-- =============================================

CREATE PROCEDURE [dbo].[AZ_ElencoAzStoricoSoggColl]
	@codSoggetto int,
	@codiceTipo varchar(1),
	@codiceFiscale varchar(16)
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
 
		tb_ausco_sog_contr_col.ausco_nome AS DB_Nome, 
		tb_ausco_sog_contr_col.ausco_tipo_persona AS DB_TipoPersona, 
		tb_ausca_sog_contr_az.ausca_denominazione as DB_Denominazione, 
		--tb_ausco_sog_contr_col.ausco_denominazione as DB_Denominazione, 
		tb_autis_tipo_sog_col_ct.autis_descr AS DB_Carica, 

		case
			when (tb_ausrs_storico_rel_sog.ausrs_relazione_certificata IS null) then 
				'N'
			else tb_ausrs_storico_rel_sog.ausrs_relazione_certificata
		end AS DB_Relazione_Certificata,
		
		CONVERT(varchar(10),tb_ausrs_storico_rel_sog.ausrs_data_inizio_validita,103) AS DB_DataInizioValidita,
		CONVERT(varchar(10),tb_ausrs_storico_rel_sog.ausrs_data_di_fine_validita,103) AS DB_DataFineValidita,
		case
			when (tb_ausrs_storico_rel_sog.ausrs_causa_storicizzazione = 'M') then 
				'Modifica'
				when (tb_ausrs_storico_rel_sog.ausrs_causa_storicizzazione = 'E') then 
				'Elimina'
			else tb_ausrs_storico_rel_sog.ausrs_causa_storicizzazione
		end AS DB_TipoVariaz,

		case
			when (tb_ausrs_storico_rel_sog.ausrs_data_storicizzazione IS null) then 
				CONVERT(varchar(10),'01/01/1900',103) 
			else CONVERT(varchar(10),tb_ausrs_storico_rel_sog.ausrs_data_storicizzazione,103)
		end AS DB_DataStoric,


		tb_ausrs_storico_rel_sog.ausrs_motivo_storicizzazione as DB_Motivo,	
		tb_ausrs_storico_rel_sog.ausrs_utente_storicizzazione as DB_Utente
	FROM         
		tb_ausca_sog_contr_az INNER JOIN
		tb_ausrs_storico_rel_sog ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_ausrs_storico_rel_sog.ausrs_ausca_codice_pk INNER JOIN
		tb_ausco_sog_contr_col ON tb_ausrs_storico_rel_sog.ausrs_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk INNER JOIN
		tb_autis_tipo_sog_col_ct ON tb_ausrs_storico_rel_sog.ausrs_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
	WHERE ausco_codice_pk = @codSoggetto 
		 
	AND ausrs_causa_storicizzazione LIKE '%' + rtrim(@codiceTipo) + '%'
    AND ausca_codice_fiscale LIKE '%' + rtrim(@codiceFiscale) + '%'

    ORDER BY ausrs_data_di_fine_validita desc, DB_Carica desc, DB_Denominazione asc 

END


