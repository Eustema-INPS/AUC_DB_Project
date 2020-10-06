

CREATE PROCEDURE [dbo].[SP_BELF_VALIDATI]
AS
BEGIN
	SET NOCOUNT ON;

-- Identifica i record da gestire
UPDATE TB_AUVIN_VERIFICA_INDIRIZZO
SET AUVIN_LAVORAZIONE_AUC = '1' 
FROM TB_AUVIN_VERIFICA_INDIRIZZO  INNER JOIN
                      tb_ausca_sog_contr_az ON TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_CHIAVE_AUC = tb_ausca_sog_contr_az.ausca_codice_pk
WHERE     (TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_STATO_RECORD = 'V') and auvin_provenienza = 'AUSCA' and
		AUVIN_LAVORAZIONE_AUC is null and
		((ausca_cod_com_Belfiore is null) or ((ausca_cod_com_Belfiore is not null) and 
											 ((ausca_data_validazione_anagrafica <= auvin_data_lavorazione) or ausca_data_validazione_anagrafica is null)))

-- Storicizza i dati che saranno modificati
INSERT INTO [dbo].[TB_AUSSI_STORICO_INDIRIZZO]
           (AUSSI_AUVIN_CODICE_PK
		   ,[AUSSI_CHIAVE_AUC]
           ,[AUSSI_PROVENIENZA]
           ,[AUSSI_CODICE_FISCALE]
           ,[AUSSI_DENOMINAZIONE]
           ,[AUSSI_COGNOME]
           ,[AUSSI_NOME]
           ,[AUSSI_TOPONIMO]
           ,[AUSSI_INDIRIZZO]
           ,[AUSSI_CIVICO]
           ,[AUSSI_CAP]
           ,[AUSSI_COMUNE]
           ,[AUSSI_PROVINCIA]
           ,[AUSSI_CODICE_COMUNE_BELFIORE]
           ,[AUSSI_FONTE_VALIDAZIONE]
           ,[AUSSI_MOTIVO_SCARTO]
           ,[AUSSI_DATA_INSERIMENTO]
           ,[AUSSI_DATA_LAVORAZIONE]
		   ,AUSSI_lavorazione_AUC
           ,[AUSSI_DATA_LAVORAZIONE_AUC]
           ,[AUSSI_RICHIEDENTE])
SELECT		TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_CODICE_PK, 
			TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_CHIAVE_AUC, 
			TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_PROVENIENZA, 
            TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_CODICE_FISCALE, 
			ausca_denominazione,
			ausca_cognome,
			ausca_nome,
			tb_ausca_sog_contr_az.ausca_toponimo, 
			tb_ausca_sog_contr_az.ausca_indirizzo, 
			tb_ausca_sog_contr_az.ausca_civico, 
            tb_ausca_sog_contr_az.ausca_cap, 
			tb_ausca_sog_contr_az.ausca_descr_comune, 
			tb_ausca_sog_contr_az.ausca_sigla_provincia, 
			tb_ausca_sog_contr_az.ausca_cod_com_Belfiore, 
			TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_FONTE_VALIDAZIONE, 
			TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_MOTIVO_SCARTO, 
            TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_DATA_INSERIMENTO, 
			TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_DATA_LAVORAZIONE, 
			AUVIN_LAVORAZIONE_AUC, 
			AUVIN_DATA_LAVORAZIONE_AUC, 
            TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_RICHIEDENTE
FROM         TB_AUVIN_VERIFICA_INDIRIZZO INNER JOIN
                      tb_ausca_sog_contr_az ON TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_CHIAVE_AUC = tb_ausca_sog_contr_az.ausca_codice_pk
WHERE     (TB_AUVIN_VERIFICA_INDIRIZZO.AUVIN_STATO_RECORD = 'V') and auvin_provenienza = 'AUSCA' and
		AUVIN_LAVORAZIONE_AUC = '1' and
		((ausca_cod_com_Belfiore is null) or ((ausca_cod_com_Belfiore is not null) and 
											 ((ausca_data_validazione_anagrafica <= auvin_data_lavorazione) or ausca_data_validazione_anagrafica is null)))



--Aggiorna i dati su AUSCA
update tb_ausca_sog_contr_az
set 
			ausca_denominazione = ISNULL(auvin_v_denominazione,[ausca_denominazione]),
			ausca_cognome = ISNULL(auvin_v_cognome,ausca_cognome),
			ausca_nome = ISNULL(auvin_v_nome,ausca_nome),
			ausca_toponimo = auvin_v_toponimo,
			ausca_indirizzo= auvin_v_indirizzo,
			ausca_civico= auvin_v_civico,
            ausca_cap= auvin_v_cap,
			ausca_descr_comune= substring(auvin_v_comune,1,30),
			ausca_comune_esteso_ita = auvin_v_comune,
			ausca_sigla_provincia= auvin_v_provincia,
			ausca_cod_com_Belfiore= auvin_v_codice_comune_belfiore,
			ausca_data_validazione_anagrafica = auvin_data_lavorazione,
			ausca_fonte_validazione_anagrafica = auvin_fonte_validazione,
			ausca_data_modifica = getdate(),
			ausca_descr_utente = 'Aggiornato da Belfiore'
from tb_ausca_sog_contr_az inner join TB_AUVIN_VERIFICA_INDIRIZZO on ausca_codice_pk = auvin_chiave_AUC
where AUVIN_LAVORAZIONE_AUC = '1' and auvin_provenienza = 'AUSCA' and
(auvin_v_indirizzo is not null and rtrim(ltrim(auvin_v_indirizzo)) <> '') 

-- Memorizza i dati di dettaglio modificati
declare @codice as int
		Declare Cursore_sincronizza Cursor
		For
			Select  auvin_chiave_auc from TB_AUVIN_VERIFICA_INDIRIZZO where AUVIN_LAVORAZIONE_AUC = '1' and auvin_provenienza = 'AUSCA'
			Open Cursore_sincronizza
			    FETCH NEXT FROM Cursore_sincronizza INTO @codice
				WHILE (@@FETCH_STATUS = 0)		
				BEGIN
					exec  AZ_1_sincronizza @codice, 1, 29, null
					FETCH NEXT FROM Cursore_sincronizza INTO @codice
				END
		CLOSE Cursore_sincronizza
		DEALLOCATE Cursore_sincronizza

-- Chiude la lavorazione
update TB_AUVIN_VERIFICA_INDIRIZZO
set AUVIN_LAVORAZIONE_AUC = 'S',
	AUVIN_DATA_LAVORAZIONE_AUC = getdate()
where AUVIN_LAVORAZIONE_AUC = '1' and auvin_provenienza = 'AUSCA'
END
