-- =============================================
-- Author:		Raffaele
-- Create date: 15.11.2011
-- Description:	Stored Procedure per caricare le aziende legate ad un soggetto delegato
-- =============================================
-- =============================================
-- Author:		Raffaele
-- Modifica date: 27-07-2012
-- Description:	Tolti i vincoli temporali 
-- =============================================
CREATE PROCEDURE [dbo].[AZ_ElencoAziendeDelegato]
	@codSoggetto int
AS
BEGIN

SELECT  
		DISTINCT(tb_ausca_sog_contr_az.ausca_codice_pk) AS DB_CodiceAzienda, 
		tb_audel_del.audel_codice_pk as DB_CodiceSoggetto,     
        tb_audel_del.audel_codice_fiscale AS DB_CodiceFiscale, 
        tb_audel_del.audel_cognome AS DB_Cognome, 
        tb_audel_del.audel_nome AS DB_Nome, 
        tb_audel_del.audel_tipo_persona AS DB_TipoPersona, 
		tb_ausca_sog_contr_az.ausca_denominazione AS DB_Denominazione, 
        tb_autid_tipo_del_ct.autid_descr AS DB_Carica,
		CONVERT(varchar(10),tb_aurad_rel_az_del.aurad_data_inizio_validita,103) AS DB_DataInizioValidita, 
		CONVERT(varchar(10),tb_aurad_rel_az_del.aurad_data_fine_validita,103) AS DB_DataFineValidita
FROM         tb_ausca_sog_contr_az INNER JOIN
                      tb_aupoc_pos_contr ON tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk INNER JOIN
                      tb_aurad_rel_az_del ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurad_rel_az_del.aurad_aupoc_codice_pk INNER JOIN
                      tb_audel_del ON tb_aurad_rel_az_del.aurad_audel_codice_pk = tb_audel_del.audel_codice_pk INNER JOIN
                      tb_autid_tipo_del_ct ON tb_aurad_rel_az_del.aurad_autid_codice_pk = tb_autid_tipo_del_ct.autid_codice_pk
WHERE     (tb_audel_del.audel_codice_pk = @codSoggetto)
-- Modificato da Raffaele 27 luglio 2012 per consentire la visualizzazione dei legami scaduti 
--            in quanto esistono aziende solo con legami scaduti che non si vedrebbero mai. 
      --AND 
      ----(tb_aurad_rel_az_del.aurad_data_fine_validita IS NULL)
      --( tb_aurad_rel_az_del.aurad_data_fine_validita >= GETDATE() AND tb_aurad_rel_az_del.aurad_data_inizio_validita <= GETDATE() )
ORDER BY DB_Denominazione
END
