-- =============================================
-- Author:		Quirino Vannimartini
-- Create date: 27.07.2011
-- Description:	Stored Procedure per caricare i Rappresentanti Legali dell'azienda
-- Modificata da: Raffaele
-- Data:		18.10.2012
-- Descrizione:	Inserita la gestione dei campi null per le date.
-- Modificata da: Raffaele
-- Data:		01.18.2013
-- Descrizione:	Modificato il criterio di ordinamento
-- Modificata da: Letizia
-- Data:		2014.04.09
-- Descrizione:	Inserita aurss_relazione_certificata
-- Modificata da: Stefano
-- Data:		2017.07.19
-- Descrizione:	Aggiunta logica per il recupero della provenienza
-- ======================================================================
CREATE PROCEDURE [dbo].[AZ_ElencoRappresentantiLegaliFiltro]
	@codiceAzienda int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT
		tb_ausco_sog_contr_col.ausco_codice_pk as DB_CodiceSoggetto,     
		tb_ausco_sog_contr_col.ausco_codice_fiscale AS DB_CodiceFiscale, 
		tb_ausco_sog_contr_col.ausco_cognome AS DB_Cognome, 
		tb_ausco_sog_contr_col.ausco_nome AS DB_Nome, 
		tb_ausco_sog_contr_col.ausco_tipo_persona AS DB_TipoPersona, 
		tb_ausca_sog_contr_az.ausca_denominazione as DB_Denominazione, 
		tb_autis_tipo_sog_col_ct.autis_descr AS DB_Carica, 
		--aggiornata da Letizia 20140409 
		case
			when (tb_aurss_rel_sog_sog.aurss_relazione_certificata IS null) then 
				'N'
			else tb_aurss_rel_sog_sog.aurss_relazione_certificata
		end AS DB_Relazione_Certificata,
		
		case
			when (tb_aurss_rel_sog_sog.aurss_data_inizio_validita IS null) then 
				CONVERT(varchar(10),'01/01/1900',103) 
			else CONVERT(varchar(10),tb_aurss_rel_sog_sog.aurss_data_inizio_validita,103)
		end AS DB_DataInizioValidita,
		--aggiornata da Letizia 20140409 
		case
			when (tb_aurss_rel_sog_sog.aurss_relazione_certificata IS null) then 
				'N'
			else tb_aurss_rel_sog_sog.aurss_relazione_certificata
		end AS DB_Relazione_Certificata,
		
		case
			when (tb_aurss_rel_sog_sog.aurss_data_di_fine_validita IS null) then 
				CONVERT(varchar(10),'31/12/2999',103) 
			else CONVERT(varchar(10),tb_aurss_rel_sog_sog.aurss_data_di_fine_validita,103)
		end AS DB_DataFIneValidita,
		DB_Provenienza = case 
			when aurss_auten_codice_pk = 1 then 
			(
					SELECT auute_utenza 
					FROM tb_auute_ute_sistema
					WHERE auute_codice_pk = aurss_codice_entita_rif
				)
				when aurss_auten_codice_pk = 2 then 
				(
					SELECT auece_descr 
					FROM tb_auece_ente_cert 
				WHERE auece_codice_pk = aurss_codice_entita_rif
				)
				when aurss_auten_codice_pk = 3 then 
				(
				SELECT     tb_aurea_area_gestione.aurea_descrizione
				FROM        tb_auapp_appl LEFT OUTER JOIN
					tb_aurea_area_gestione ON 
						tb_auapp_appl.auapp_aurea_codice_pk = tb_aurea_area_gestione.aurea_codice_pk
				WHERE     (tb_auapp_appl.auapp_codice_pk = aurss_codice_entita_rif)
				) end,
				tb_aurss_rel_sog_sog.aurss_codice_pk AS DB_CodiceAurss,
				tb_aurss_rel_sog_sog.aurss_posizione AS DB_Posizione

		--CONVERT(varchar(10),tb_aurss_rel_sog_sog.aurss_data_inizio_validita,103) AS DB_DataInizioValidita, 
		--CONVERT(varchar(10),tb_aurss_rel_sog_sog.aurss_data_di_fine_validita,103) AS DB_DataFineValidita
	FROM         
		tb_ausca_sog_contr_az INNER JOIN
		tb_aurss_rel_sog_sog ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aurss_rel_sog_sog.aurss_ausca_codice_pk INNER JOIN
		tb_ausco_sog_contr_col ON tb_aurss_rel_sog_sog.aurss_ausco_codice_pk = tb_ausco_sog_contr_col.ausco_codice_pk INNER JOIN
		tb_autis_tipo_sog_col_ct ON tb_aurss_rel_sog_sog.aurss_autis_codice_pk = tb_autis_tipo_sog_col_ct.autis_codice_pk
	WHERE ausca_codice_pk = @codiceAzienda 
	AND aurss_rappresentante_legale = 'S' 
	ORDER BY aurss_data_di_fine_validita desc, DB_Carica asc, DB_Cognome asc, DB_Nome 
--	ORDER BY DB_Cognome, DB_Nome 
	
END
