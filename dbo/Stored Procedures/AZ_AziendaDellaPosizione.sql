-- ==========================================================================================
-- Author:		Raffaele
-- Create date: 16 gennaio 2013
-- Description:	Ritorna l'azienda di appartenenza di una Posizione
-- ==========================================================================================
CREATE PROCEDURE [dbo].[AZ_AziendaDellaPosizione] 
	@aupoc_posizione varchar(50)
AS
BEGIN
	
SELECT DISTINCT
		ausca_codice_pk AS DB_CodiceAzienda, 
		ausca_denominazione AS DB_Denominazione,
		ausca_cognome as DB_Cognome_AZ,
		ausca_nome as DB_Nome_AZ,
		aupoc_posizione as DB_Posizione, 
		str(aupoc_codice_pk)+aupoc_contro_codice as DB_Aupoc_codice

FROM         
dbo.tb_aupoc_pos_contr 
INNER JOIN
dbo.tb_ausca_sog_contr_az ON dbo.tb_aupoc_pos_contr.aupoc_ausca_codice_pk = dbo.tb_ausca_sog_contr_az.ausca_codice_pk

WHERE aupoc_posizione = @aupoc_posizione
--where aupoc_posizione = '0100000304'
ORDER BY DB_Denominazione

END
