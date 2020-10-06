
CREATE PROCEDURE [dbo].[EX_DatiElencoPosizioni] 
	@ElencoPosizioni MatricoleList READONLY
AS
SET NOCOUNT ON;

BEGIN
	
	SELECT taag.aurea_descrizione AS Gestione,
		   tapc.aupoc_posizione AS Posizione, 
		   tapc.aupoc_denom_posiz_contr AS DenominazionePosizione,
		   tasca.ausca_denominazione AS DenominazioneAzienda,
		   tasca.ausca_codice_fiscale AS CodiceFiscaleAzienda
	FROM dbo.tb_aupoc_pos_contr tapc
		 JOIN dbo.tb_ausca_sog_contr_az tasca ON tapc.aupoc_ausca_codice_pk = tasca.ausca_codice_pk
		 JOIN dbo.tb_aurea_area_gestione taag ON tapc.aupoc_aurea_codice_pk = taag.aurea_codice_pk
		JOIN @ElencoPosizioni m ON m.matricola=tapc.aupoc_posizione	
END
