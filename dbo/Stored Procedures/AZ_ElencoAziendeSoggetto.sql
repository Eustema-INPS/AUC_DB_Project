-- =============================================
-- Author:		Chiara Pugliese
-- Create date: 01.07.2011
-- Description:	Stored Procedure per caricare le aziende legate ad un soggetto
-- =============================================
-- =============================================
-- Author:		Raffaele
-- Modifica date: 27-07-2012
-- Description:	Tolti i vincoli temporali 
-- Modificata da: Raffaele
-- Data:		25.10.2012
-- Descrizione:	Modificata l'origine di DB_Cognome
-- Modificata da: Raffaele
-- Data:		01.18.2013
-- Descrizione:	Modificato il criterio di ordinamento
-- Modificata da: Letizia
-- Data:		2014.05.13
-- Descrizione:	Inserita aurss_relazione_certificata
-- =============================================
-- Modificata da: Letizia
-- Data:		2014.06.23
-- Descrizione:	Inserito codice fiscale azienda
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoAziendeSoggetto]
	@codSoggetto int
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
		----aggiornata da Letizia 20140513 
		case
			when (tb_aurss_rel_sog_sog.aurss_relazione_certificata IS null) then 
				'N'
			else tb_aurss_rel_sog_sog.aurss_relazione_certificata
		end AS DB_Relazione_Certificata,
		
		CONVERT(varchar(10),tb_aurss_rel_sog_sog.aurss_data_inizio_validita,103) AS DB_DataInizioValidita,
		CONVERT(varchar(10),tb_aurss_rel_sog_sog.aurss_data_di_fine_validita,103) AS DB_DataFineValidita
	FROM         
		tb_ausca_sog_contr_az INNER JOIN
		tb_aurss_rel_sog_sog ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aurss_rel_sog_sog.aurss_ausca_codice_pk INNER JOIN
		tb_ausco_sog_contr_col ON tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk INNER JOIN
		tb_autis_tipo_sog_col_ct ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
	WHERE ausco_codice_pk = @codSoggetto 
-- Modificato da Raffaele 27 luglio 2012 per consentire la visualizzazione dei legami scaduti 
--            in quanto esistono aziende solo con legami scaduti che non si vedrebbero mai. 
	--WHERE ausco_codice_pk = @codSoggetto AND
	--((tb_aurss_rel_sog_sog.aurss_data_di_fine_validita >= GETDATE() )  and
	--(tb_aurss_rel_sog_sog.aurss_data_inizio_validita <= GETDATE() ))   

	--ORDER BY DB_Denominazione
    ORDER BY aurss_data_di_fine_validita desc, DB_Carica desc, DB_Denominazione asc 

END

