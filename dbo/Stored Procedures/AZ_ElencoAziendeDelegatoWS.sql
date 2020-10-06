-- ==========================================================================================
-- Author:		Maurizio Picone
-- Create date: 29 Novembre 2012
-- Description:	Prende le aziende di appartenenza ad un soggetto delegato partendo dal suo CF
-- ==========================================================================================
CREATE PROCEDURE [dbo].[AZ_ElencoAziendeDelegatoWS] 
	@aupoc_posizione varchar(50)
AS
BEGIN
	
SELECT DISTINCT
		ausca_codice_pk AS DB_CodiceAzienda, 
		audel_codice_pk as DB_CodiceSoggetto,     
        audel_codice_fiscale AS DB_CodiceFiscale, 
        audel_cognome AS DB_Cognome, 
        audel_nome AS DB_Nome, 
        audel_tipo_persona AS DB_TipoPersona, 
		ausca_denominazione AS DB_Denominazione, 
        autid_descr AS DB_Carica,
		CONVERT(varchar(10),aurad_data_inizio_validita,103) AS DB_DataInizioValidita,

		--Case aurad_data_fine_validita
		--when convert(varchar(10),'2999/12/31',103) then ''
		--else CONVERT(varchar(10),aurad_data_fine_validita,103)
		--end AS DB_DataFineValidita

		CONVERT(varchar(10),aurad_data_fine_validita,103) AS DB_DataFineValidita

FROM         
dbo.tb_aupoc_pos_contr 
INNER JOIN
dbo.tb_ausca_sog_contr_az ON dbo.tb_aupoc_pos_contr.aupoc_ausca_codice_pk = dbo.tb_ausca_sog_contr_az.ausca_codice_pk
INNER JOIN
tb_aurad_rel_az_del ON tb_aupoc_pos_contr.aupoc_codice_pk = tb_aurad_rel_az_del.aurad_aupoc_codice_pk
INNER JOIN
tb_audel_del ON tb_aurad_rel_az_del.aurad_audel_codice_pk = tb_audel_del.audel_codice_pk
INNER JOIN
tb_autid_tipo_del_ct ON tb_aurad_rel_az_del.aurad_autid_codice_pk = tb_autid_tipo_del_ct.autid_codice_pk

WHERE aupoc_posizione = @aupoc_posizione

ORDER BY DB_Denominazione

END
