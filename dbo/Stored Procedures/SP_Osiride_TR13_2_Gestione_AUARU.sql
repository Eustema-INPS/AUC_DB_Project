CREATE PROCEDURE [dbo].[SP_Osiride_TR13_2_Gestione_AUARU] 
AS
BEGIN

	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (10, 'B', 'OSIRIDE', Getdate(),'10.1','TR13_2_Gestione_AUARU - Inizio', Getdate(), 'AdminPlus' )
	
	-- 2018 12 03
	UPDATE tb_auaru_arl_auulo SET auaru_dt_iscrizione = null WHERE auaru_dt_iscrizione = '1900-01-01';	
	UPDATE tb_auaru_arl_auulo SET auaru_dt_domanda = null WHERE auaru_dt_domanda = '1900-01-01';
	UPDATE tb_auaru_arl_auulo SET auaru_dt_delibera = null WHERE auaru_dt_delibera  = '1900-01-01';
	UPDATE tb_auaru_arl_auulo SET auaru_dt_cessazione = null WHERE auaru_dt_cessazione = '2999-12-31';

	TRUNCATE TABLE Import_auaru_arl_auulo;	

	INSERT INTO [dbo].[Import_auaru_arl_auulo]
			([St_auaru_codice_fiscale_ausca]
			,[St_auaru_progressivo]
			,[St_auaru_dt_aperturaUL] 
			,[St_auaru_cod_comuneUL] 
			,[St_auaru_provinciaUL] 
			,[St_auaru_dt_chiusuraUL] 
			,[St_auaru_c_tipo]
			,[St_auaru_tipo]
			,[St_auaru_c_forma]
			,[St_auaru_forma]
			,[St_auaru_n_ruolo]
			,[St_auaru_ruolo_provincia]
			,[St_auaru_c_ente_rilascio]
			,[St_auaru_ente_rilascio]
			,[St_auaru_dt_iscrizione]
			,[St_auaru_dt_domanda]
			,[St_auaru_dt_delibera]
			,[St_auaru_dt_cessazione]
			,[St_auaru_c_causale]
			,[St_auaru_data_modifica]
			,[St_auaru_descr_utente])
	SELECT   
		dati_id.value('@c-fiscale', 'varchar(16)') AS CodiceFiscale,
		localizzazione.value('@progressivo','varchar(5)') as Progressivo,
		CASE WHEN localizzazione.value('@dt-apertura','varchar(10)') is null then '1900-01-01'
			 ELSE SUBSTRING(localizzazione.value('@dt-apertura','varchar(10)'),7,4)+'-'+ SUBSTRING(localizzazione.value('@dt-apertura','varchar(10)'),4,2) +'-'+
				SUBSTRING(localizzazione.value('@dt-apertura','varchar(10)'),1,2) END AS DataCessazione,		
		indirizzo.value('@c-comune','varchar(3)') as CodiceComune,
		indirizzo.value('@provincia','varchar(2)') as Provincia,
		CASE WHEN cessazione.value('@dt-cessazione','varchar(10)') is null then '2999-12-31'
			 ELSE SUBSTRING(cessazione.value('@dt-cessazione','varchar(10)'),7,4)+'-'+ SUBSTRING(cessazione.value('@dt-cessazione','varchar(10)'),4,2) +'-'+
				  SUBSTRING(cessazione.value('@dt-cessazione','varchar(10)'),1,2) END AS DataCessazione,
		ruoli.value('@c-tipo', 'varchar(2)') as c_tipo,
		ruoli.value('@tipo', 'varchar(100)') as tipo,
		ruoli.value('@c-forma', 'varchar(5)') as c_forma,
		ruoli.value('@forma', 'varchar(100)') as forma,
		ruoli.value('@n', 'varchar(7)') as n_ruolo,
		ruoli.value('@provincia', 'varchar(2)') as provincia,
		ruoli.value('@c-ente-rilascio', 'varchar(2)') as c_ente_rilascio,
		ruoli.value('@ente-rilascio', 'varchar(50)') as ente_rilascio,
		CASE WHEN ruoli.value('@dt-iscrizione', 'varchar(10)') is null then '1900-01-01'
			ELSE SUBSTRING(ruoli.value('@dt-iscrizione', 'varchar(10)'),7,4)+'-'+ SUBSTRING(ruoli.value('@dt-iscrizione', 'varchar(10)'),4,2) +'-'+
				SUBSTRING(ruoli.value('@dt-iscrizione', 'varchar(10)'),1,2) END AS dt_iscrizione,		
		CASE WHEN ruoli.value('@dt-domanda', 'varchar(10)') IS NULL THEN '1900-01-01'
			ELSE SUBSTRING(ruoli.value('@dt-domanda', 'varchar(10)'),7,4)+'-'+ SUBSTRING(ruoli.value('@dt-domanda', 'varchar(10)'),4,2)+'-'+
				SUBSTRING(ruoli.value('@dt-domanda', 'varchar(10)'),1,2) END AS dt_domanda,
		CASE WHEN ruoli.value('@dt-delibera', 'varchar(10)') IS NULL THEN '1900-01-01'
			ELSE SUBSTRING(ruoli.value('@dt-delibera', 'varchar(10)'),7,4)+'-'+ SUBSTRING(ruoli.value('@dt-delibera', 'varchar(10)'),4,2) +'-'+
				SUBSTRING(ruoli.value('@dt-delibera', 'varchar(10)'),1,2) END AS dt_delibera,
		CASE WHEN ruoli.value('@dt-cessazione', 'varchar(10)') IS NULL THEN '2999-12-31'
			ELSE SUBSTRING(ruoli.value('@dt-cessazione', 'varchar(10)'),7,4)+'-'+ SUBSTRING(ruoli.value('@dt-cessazione', 'varchar(10)'),4,2)+'-'+
				SUBSTRING(ruoli.value('@dt-cessazione', 'varchar(10)'),1,2) END AS dt_cessazione,
		ruoli.value('@c-causale', 'varchar(2)') as c_causale,
		GetDate(),
		'Inserito da Visura'
	FROM tb_auvis_visure CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/dati-identificativi') AS T1(dati_id)
		--CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/info-attivita') AS T2(info_attivita)
		CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/localizzazioni/localizzazione') AS T3(localizzazione)
		CROSS APPLY localizzazione.nodes('albi-ruoli-licenze/ruoli/ruolo') AS T4(Ruoli)
		OUTER APPLY localizzazione.nodes('indirizzo-localizzazione') AS T5(Indirizzo)
		OUTER APPLY localizzazione.nodes('cessazione-localizzazione') AS T6(cessazione)
	
	-- 2018 12 03 -- Sbianchettamento delle date tappo/alto/basso
	UPDATE Import_auaru_arl_auulo SET  St_auaru_dt_aperturaUL = null WHERE St_auaru_dt_aperturaUL = '1900-01-01';
	UPDATE Import_auaru_arl_auulo SET  St_auaru_dt_aperturaUL = null WHERE St_auaru_dt_aperturaUL = '2999-12-31';	
	UPDATE Import_auaru_arl_auulo SET  St_auaru_dt_iscrizione = null WHERE St_auaru_dt_iscrizione = '1900-01-01';
	UPDATE Import_auaru_arl_auulo SET  St_auaru_dt_iscrizione = null WHERE St_auaru_dt_iscrizione = '2999-12-31';
	UPDATE Import_auaru_arl_auulo SET  St_auaru_dt_domanda    = null WHERE St_auaru_dt_domanda    = '1900-01-01';
	UPDATE Import_auaru_arl_auulo SET  St_auaru_dt_domanda    = null WHERE St_auaru_dt_domanda    = '2999-12-31';
	UPDATE Import_auaru_arl_auulo SET  St_auaru_dt_cessazione = null WHERE St_auaru_dt_cessazione = '1900-01-01';
	UPDATE Import_auaru_arl_auulo SET  St_auaru_dt_cessazione = null WHERE St_auaru_dt_cessazione = '2999-12-31';

	UPDATE Import_auaru_arl_auulo SET  [St_auaru_n_ruolo] = ltrim(rtrim([St_auaru_n_ruolo])) WHERE [St_auaru_n_ruolo] is not null;
	
	-- Valorizzazione chiave esterna verso AUSCA
	UPDATE Import_auaru_arl_auulo
	SET st_auaru_ausca_codice_pk = ausca_codice_pk
	FROM Import_auaru_arl_auulo 
	INNER JOIN tb_ausca_sog_contr_az ON ausca_codice_fiscale = st_auaru_codice_fiscale_ausca

	-- Cancellazione record su tabella target
	DELETE tb_auaru_arl_auulo
	FROM tb_auaru_arl_auulo 
	INNER JOIN import_auaru_arl_auulo ON st_auaru_ausca_codice_pk = auaru_ausca_codice_pk 
	--	 AND st_auaru_progressivo = auaru_progressivo 

	-- Valorizzazione chiave esterna verso AUULO
	UPDATE import_auaru_arl_auulo
	SET st_auaru_auulo_codice_pk = auulo_codice_pk
	FROM import_auaru_arl_auulo INNER JOIN tb_auulo_unita_locale ON 
		 auulo_ausca_codice_pk = st_auaru_ausca_codice_pk 
		 AND auulo_Progressivo_localizz = st_auaru_progressivo 
		 AND ( (auulo_data_apertura = St_auaru_dt_aperturaUL) 
				OR (auulo_data_apertura IS NULL AND IsNull(St_auaru_dt_aperturaUL,'1900-01-01') = '1900-01-01')
			 ) 
		 AND ( (auulo_codice_comune = St_auaru_cod_comuneUL) 
				OR (auulo_codice_comune = '' AND St_auaru_cod_comuneUL IS NULL)
			 ) 
		 AND ( (auulo_sigla_prov = St_auaru_provinciaUL) 
				OR (auulo_sigla_prov = '' AND St_auaru_cod_comuneUL IS NULL) 
			 ) 
		 AND ( (auulo_data_cessazione = St_auaru_dt_chiusuraUL) 
				OR (St_auaru_dt_chiusuraUL = '2999-12-31' AND IsNull([auulo_data_cessazione],'2999-12-31') = '2999-12-31')
			 )
	-- Inserimento in tabella target
	INSERT INTO [dbo].[tb_auaru_arl_auulo]
			([auaru_progressivo]
			,[auaru_ausca_codice_pk]
			,[auaru_auulo_codice_pk]
			,[auaru_c_tipo]
			,[auaru_tipo]
			,[auaru_c_forma]
			,[auaru_forma]
			,[auaru_n_ruolo]
			,[auaru_ruolo_provincia]
			,[auaru_c_ente_rilascio]
			,[auaru_ente_rilascio]
			,[auaru_dt_iscrizione]
			,[auaru_dt_domanda]
			,[auaru_dt_delibera]
			,[auaru_dt_cessazione]
			,[auaru_c_causale]
			,[auaru_data_modifica]
			,[auaru_descr_utente])
	SELECT [St_auaru_progressivo]
		,[St_auaru_ausca_codice_pk]
		,[st_auaru_auulo_codice_pk]
		,[St_auaru_c_tipo]
		,[St_auaru_tipo]
		,[St_auaru_c_forma]
		,[St_auaru_forma]
		,[St_auaru_n_ruolo]
		,[St_auaru_ruolo_provincia]
		,[St_auaru_c_ente_rilascio]
		,[St_auaru_ente_rilascio]
		,[St_auaru_dt_iscrizione]
		,[St_auaru_dt_domanda]
		,[St_auaru_dt_delibera]
		,[St_auaru_dt_cessazione]
		,[St_auaru_c_causale]
		,[St_auaru_data_modifica]
		,[St_auaru_descr_utente]
	FROM [dbo].[Import_auaru_arl_auulo]
	WHERE [St_auaru_ausca_codice_pk] IS NOT NULL 
	AND [st_auaru_auulo_codice_pk] IS NOT NULL
	
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (10, 'B', 'OSIRIDE', Getdate(),'10.2','TR13_2_Gestione_AUARU - Fine', Getdate(), 'AdminPlus' )
	
END
