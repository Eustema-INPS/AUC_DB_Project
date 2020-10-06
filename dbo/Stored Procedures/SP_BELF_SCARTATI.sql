
CREATE PROCEDURE [dbo].[SP_BELF_SCARTATI]
AS
BEGIN
	SET NOCOUNT ON;

-- Identifica i record da gestire
UPDATE TB_AUVIN_VERIFICA_INDIRIZZO
SET AUVIN_LAVORAZIONE_AUC = '2'
FROM TB_AUVIN_VERIFICA_INDIRIZZO  INNER JOIN
                      tb_ausca_sog_contr_az ON TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_CHIAVE_AUC = tb_ausca_sog_contr_az.ausca_codice_pk
WHERE     (TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_STATO_RECORD = 'S') and auvin_provenienza = 'AUSCA' and AUVIN_LAVORAZIONE_AUC is null


--Aggiorna i dati su AUSCA
update tb_ausca_sog_contr_az
set 
			ausca_data_scarto = auvin_data_lavorazione,
			ausca_motivo_scarto = auvin_motivo_scarto,
			ausca_fonte_validazione_anagrafica = auvin_fonte_validazione,
			ausca_data_modifica = getdate(),
			ausca_descr_utente = 'Aggiornato da Belfiore'
from tb_ausca_sog_contr_az inner join TB_AUVIN_VERIFICA_INDIRIZZO on ausca_codice_pk = auvin_chiave_AUC
where AUVIN_LAVORAZIONE_AUC = '2' and auvin_provenienza = 'AUSCA'


-- Chiude la lavorazione
update TB_AUVIN_VERIFICA_INDIRIZZO
set AUVIN_LAVORAZIONE_AUC = 'S',
	AUVIN_DATA_LAVORAZIONE_AUC = getdate()
where AUVIN_LAVORAZIONE_AUC = '2' and auvin_provenienza = 'AUSCA'
END


