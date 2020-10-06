CREATE PROCEDURE [dbo].[SP_Osiride_TR13_1_Gestione_AUARA] 
AS
BEGIN

	-- 2018 12 03
	UPDATE tb_auara_arl_ausca SET auara_dt_domanda = null WHERE auara_dt_domanda = '1900-01-01';	
	UPDATE tb_auara_arl_ausca SET auara_dt_delibera = null WHERE auara_dt_delibera = '1900-01-01';
	UPDATE tb_auara_arl_ausca SET auara_dt_cessazione = null WHERE auara_dt_cessazione  = '2999-12-31';
	UPDATE tb_auara_arl_ausca SET auara_dt_iscrizione = null WHERE auara_dt_iscrizione = '1900-01-01';	

	TRUNCATE TABLE Import_auara_arl_ausca
		
	-- determina i ruoli a livello di soggetto contribuente
	INSERT INTO [dbo].[Import_auara_arl_ausca]
			([St_auara_codice_fiscale_ausca]
			,[St_auara_c_tipo]
			,[St_auara_tipo]
			,[st_auara_c_forma]
			,[St_auara_forma]
			,[St_auara_n_ruolo]
			,[St_auara_ruolo_provincia]
			,[St_auara_c_ente_rilascio]
			,[St_auara_ente_rilascio]
			,[St_auara_dt_iscrizione]
			,[St_auara_dt_domanda]
			,[St_auara_dt_delibera]
			,[St_auara_dt_cessazione]
			,[St_auara_c_causale]
			,[St_auara_data_modifica]
			,[St_auara_descr_utente])	
	SELECT   
		dati_id.value('@c-fiscale', 'varchar(16)') AS CodiceFiscale,
		ruoli.value('@c-tipo', 'varchar(2)') AS c_tipo,
		ruoli.value('@tipo', 'varchar(100)') AS tipo,
		ruoli.value('@c-forma', 'varchar(5)') AS c_forma,
		ruoli.value('@forma', 'varchar(100)') AS forma,
		ruoli.value('@n', 'varchar(7)') AS n_ruolo,
		ruoli.value('@provincia', 'varchar(2)') as provincia,
		ruoli.value('@c-ente-rilascio', 'varchar(2)') AS c_ente_rilascio,
		ruoli.value('@ente-rilascio', 'varchar(50)') AS ente_rilascio,
		CASE WHEN ruoli.value('@dt-iscrizione', 'varchar(10)') is null then '1900-01-01'
			ELSE SUBSTRING(ruoli.value('@dt-iscrizione', 'varchar(10)'),7,4)+'-'+ SUBSTRING(ruoli.value('@dt-iscrizione', 'varchar(10)'),4,2) + '-' +
				SUBSTRING(ruoli.value('@dt-iscrizione', 'varchar(10)'),1,2) END AS dt_iscrizione,		
		CASE WHEN ruoli.value('@dt-domanda', 'varchar(10)') is null then '1900-01-01'
			ELSE SUBSTRING(ruoli.value('@dt-domanda', 'varchar(10)'),7,4)+'-'+SUBSTRING(ruoli.value('@dt-domanda', 'varchar(10)'),4,2) + '-' +
				SUBSTRING(ruoli.value('@dt-domanda', 'varchar(10)'),1,2) END AS dt_domanda,
		CASE WHEN ruoli.value('@dt-delibera', 'varchar(10)') is null then '1900-01-01'
			ELSE SUBSTRING(ruoli.value('@dt-delibera', 'varchar(10)'),7,4)+'-'+SUBSTRING(ruoli.value('@dt-delibera', 'varchar(10)'),4,2) + '-' +
				SUBSTRING(ruoli.value('@dt-delibera', 'varchar(10)'),1,2) END AS dt_delibera,
		CASE WHEN ruoli.value('@dt-cessazione', 'varchar(10)') is null then '2999-12-31'
			ELSE SUBSTRING(ruoli.value('@dt-cessazione', 'varchar(10)'),7,4)+'-'+SUBSTRING(ruoli.value('@dt-cessazione', 'varchar(10)'),4,2) + '-' +
				SUBSTRING(ruoli.value('@dt-cessazione', 'varchar(10)'),1,2) END AS dt_cessazione,
		
		ruoli.value('@c-causale', 'varchar(2)') AS c_causale,
		GetDate(),
		'Inserito da Visura'		
		FROM tb_auvis_visure 
			CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/dati-identificativi') AS T1(dati_id)
			--CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/info-attivita') AS T2(info_attivita)
			CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/albi-ruoli-licenze/ruoli/ruolo') as T4(Ruoli)	

	-- 2018 12 03 -- Sbianchettamento delle date tappo/alto/basso
	UPDATE Import_auara_arl_ausca SET  St_auara_dt_iscrizione = null WHERE St_auara_dt_iscrizione = '1900-01-01';
	UPDATE Import_auara_arl_ausca SET  St_auara_dt_iscrizione = null WHERE St_auara_dt_iscrizione = '2999-12-31';
	UPDATE Import_auara_arl_ausca SET  St_auara_dt_domanda    = null WHERE St_auara_dt_domanda    = '1900-01-01';
	UPDATE Import_auara_arl_ausca SET  St_auara_dt_domanda    = null WHERE St_auara_dt_domanda    = '2999-12-31';
	UPDATE Import_auara_arl_ausca SET  St_auara_dt_delibera   = null WHERE St_auara_dt_delibera   = '1900-01-01';
	UPDATE Import_auara_arl_ausca SET  St_auara_dt_delibera   = null WHERE St_auara_dt_delibera   = '2999-12-31';
	UPDATE Import_auara_arl_ausca SET  St_auara_dt_cessazione = null WHERE St_auara_dt_cessazione = '1900-01-01';
	UPDATE Import_auara_arl_ausca SET  St_auara_dt_cessazione = null WHERE St_auara_dt_cessazione = '2999-12-31';

	UPDATE Import_auara_arl_ausca SET  [St_auara_n_ruolo] = ltrim(rtrim([St_auara_n_ruolo])) WHERE [St_auara_n_ruolo] is not null;

	-- Valorizzazione chiave esterna verso AUSCA	
	UPDATE Import_auara_arl_ausca
	SET st_auara_ausca_codice_pk = ausca_codice_pk
	FROM Import_auara_arl_ausca 
	INNER JOIN tb_ausca_sog_contr_az ON ausca_codice_fiscale = st_auara_codice_fiscale_ausca
		
	-- Cancellazione record su tabella target	
	DELETE tb_auara_arl_ausca
	FROM tb_auara_arl_ausca INNER JOIN import_auara_arl_ausca ON 
		 st_auara_ausca_codice_pk = auara_ausca_codice_pk 
	
	-- Inserimento in tabella target	
	INSERT INTO [dbo].[tb_auara_arl_ausca]
			([auara_ausca_codice_pk]
			,[auara_c_tipo]
			,[auara_tipo]
			,[auara_c_forma]
			,[auara_forma]
			,[auara_n_ruolo]
			,[auara_ruolo_provincia]
			,[auara_c_ente_rilascio]
			,[auara_ente_rilascio]
			,[auara_dt_iscrizione]
			,[auara_dt_domanda]
			,[auara_dt_delibera]
			,[auara_dt_cessazione]
			,[auara_c_causale]
			,[auara_data_modifica]
			,[auara_descr_utente])	
	SELECT   [St_auara_ausca_codice_pk]
			,[St_auara_c_tipo]
			,[St_auara_tipo]
			,[St_auara_c_forma]
			,[St_auara_forma]
			,[St_auara_n_ruolo]
			,[St_auara_ruolo_provincia]
			,[St_auara_c_ente_rilascio]
			,[St_auara_ente_rilascio]
			,[St_auara_dt_iscrizione]
			,[St_auara_dt_domanda]
			,[St_auara_dt_delibera]
			,[St_auara_dt_cessazione]
			,[St_auara_c_causale]
			,[St_auara_data_modifica]
			,[St_auara_descr_utente]
	FROM [dbo].[Import_auara_arl_ausca]	
	WHERE [St_auara_ausca_codice_pk] IS NOT NULL 			
END
