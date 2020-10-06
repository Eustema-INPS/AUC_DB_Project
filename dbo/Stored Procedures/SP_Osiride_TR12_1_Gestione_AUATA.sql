CREATE PROCEDURE [dbo].[SP_Osiride_TR12_1_Gestione_AUATA] 
AS
BEGIN
	-- Inserimento in import_ateco_ausca dei codici 2002
	TRUNCATE TABLE Import_auata_ateco_ausca

	INSERT INTO [dbo].[Import_auata_ateco_ausca]
			([St_auata_codice_fiscale_ausca]
			,[St_auata_classificazione_ateco]
			,[St_auata_cod_att_input]
			,[St_auata_descr_attivita]
			,[St_auata_cod_importanza]
			,[St_auata_importanza]
			,[St_auata_dt_inizio]
			,[St_auata_dt_fine]
			,[St_auata_dt_riferimento]
			,[St_auata_data_modifica]
			,[St_auata_descr_utente]
	)
	SELECT   
		dati_id.value('@c-fiscale', 'varchar(16)') AS CodiceFiscale,
		'2002' As classificazione_ateco,
		ateco2002.value('@c-attivita','varchar(10)') AS CodAteco2002,
		ateco2002.value('@attivita','varchar(200)') AS DesAteco2002,
		ateco2002.value('@c-importanza','varchar(1)') AS cImportanza2002,
		ateco2002.value('@importanza','varchar(50)') AS Importanza2002,
		CASE WHEN ateco2002.value('@dt-inizio','varchar(10)') is null then '1900-01-01'
				ELSE substring(ateco2002.value('@dt-inizio','varchar(10)'),7,4)+'-'+substring(ateco2002.value('@dt-inizio','varchar(10)'),4,2)+'-'+
					 substring(ateco2002.value('@dt-inizio','varchar(10)'),1,2) end AS dtInizio2002,
		CASE WHEN ateco2002.value('@dt-fine','varchar(10)') is null then '2999-12-31'
				ELSE substring(ateco2002.value('@dt-fine','varchar(10)'),7,4)+'-'+substring(ateco2002.value('@dt-fine','varchar(10)'),4,2)+'-'+
					 substring(ateco2002.value('@dt-fine','varchar(10)'),1,2) end AS dtFine2002,
		CASE WHEN ateco2002.value('@dt-riferimento','varchar(10)') is null then '1900-01-01'
				ELSE substring(ateco2002.value('@dt-riferimento','varchar(10)'),7,4)+'-'+substring(ateco2002.value('@dt-riferimento','varchar(10)'),4,2)+'-'+
					 substring(ateco2002.value('@dt-riferimento','varchar(10)'),1,2) end AS dtRiferimento2002,
		getdate() As DataSistema,
	    'Inserimento da visura' As Nota
	FROM tb_auvis_visure 
		CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/dati-identificativi') AS T1(dati_id)
		CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/info-attivita') AS T2(info_attivita)
		CROSS APPLY info_attivita.nodes('classificazioni-ateco-2002/classificazione-ateco-2002') as T3(ateco2002)
	where ateco2002.value('@c-importanza','varchar(1)') IN ('P','S','I')

  -- Inserimento in import_ateco_ausca dei codici 2007
	
	INSERT INTO [dbo].[Import_auata_ateco_ausca]
			([St_auata_codice_fiscale_ausca]	
			,[St_auata_classificazione_ateco]
			,[St_auata_cod_att_input]	
			,[St_auata_descr_attivita]
			,[St_auata_cod_importanza]
			,[St_auata_importanza]
			,[St_auata_dt_inizio]
			,[St_auata_dt_fine]
			,[St_auata_dt_riferimento]
			,[St_auata_data_modifica]
			,[St_auata_descr_utente]
	)
	SELECT   
		dati_id.value('@c-fiscale', 'varchar(16)') As CodiceFiscale,
		'2007' As classificazione_ateco,
		ateco2007.value('@c-attivita','varchar(10)')  As CodAteco2007,
		ateco2007.value('@attivita','varchar(200)')   As DesAteco2007,
		ateco2007.value('@c-importanza','varchar(1)') As cImportanza2007,
		ateco2007.value('@importanza','varchar(50)')  As Importanza2007,
		CASE WHEN ateco2007.value('@dt-inizio','varchar(10)') is null then '1900-01-01'
			ELSE substring(ateco2007.value('@dt-inizio','varchar(10)'),7,4)+'-'+substring(ateco2007.value('@dt-inizio','varchar(10)'),4,2)+'-'+
				 substring(ateco2007.value('@dt-inizio','varchar(10)'),1,2) end As dtInizio2007,
		CASE WHEN ateco2007.value('@dt-fine','varchar(10)') is null then '2999-12-31'
				else substring(ateco2007.value('@dt-fine','varchar(10)'),7,4)+'-'+substring(ateco2007.value('@dt-fine','varchar(10)'),4,2)+'-'+
					 substring(ateco2007.value('@dt-fine','varchar(10)'),1,2) end As dtFine2007,
		CASE WHEN ateco2007.value('@dt-riferimento','varchar(10)') is null then '1900-01-01'
				ELSE substring(ateco2007.value('@dt-riferimento','varchar(10)'),7,4)+'-'+substring(ateco2007.value('@dt-riferimento','varchar(10)'),4,2)+'-'+
					 substring(ateco2007.value('@dt-riferimento','varchar(10)'),1,2) end As dtRiferimento2007,
		getdate() As DataSistema,
		'Inserimento da visura' As Nota 	
	FROM tb_auvis_visure 
		CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/dati-identificativi') As T1(dati_id)
		CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/info-attivita') As T2(info_attivita)
		CROSS APPLY info_attivita.nodes('classificazioni-ateco/classificazione-ateco') As T3(ateco2007)
	WHERE ateco2007.value('@c-importanza','varchar(1)') IN ('P','S','I')
	
	-- Valorizzazione chiave esterna verso AUSCA	
	UPDATE import_auata_ateco_ausca
	SET st_auata_ausca_codice_pk = ausca_codice_pk
	FROM import_auata_ateco_ausca inner join tb_ausca_sog_contr_az ON 
		 ausca_codice_fiscale = st_auata_codice_fiscale_ausca
	
	-- Valorizzazione codice ateco output	
	UPDATE import_auata_ateco_ausca
	SET st_auata_cod_att_output = SUBSTRING(st_auata_cod_att_input,1,2)+SUBSTRING(st_auata_cod_att_input,4,2)+SUBSTRING(st_auata_cod_att_input,7,2)
	
	-- Cancellazione record su tabella target	
	DELETE tb_auata_ateco_ausca
	FROM tb_auata_ateco_ausca INNER JOIN import_auata_ateco_ausca ON 
		 st_auata_ausca_codice_pk = auata_ausca_codice_pk 
		 --AND st_auata_classificazione_ateco = auata_classificazione_ateco
	
	-- Inserimento record in tabella target	
	INSERT INTO [dbo].[tb_auata_ateco_ausca]
			([auata_ausca_codice_pk]
			,auata_ausca_codice_fiscale
			,[auata_classificazione_ateco]
			,[auata_cod_att_output]
			,[auata_descr_attivita]
			,[auata_cod_importanza]
			,[auata_importanza]
			,[auata_dt_inizio]
			,[auata_dt_fine]
			,[auata_dt_riferimento]
			,[auata_data_modifica]
			,[auata_descr_utente])
	  SELECT [St_auata_ausca_codice_pk]
	        ,[st_auata_codice_fiscale_ausca]
	        ,[St_auata_classificazione_ateco]
	        ,[St_auata_cod_att_output]
	        ,[St_auata_descr_attivita]
	        ,[St_auata_cod_importanza]
	        ,[St_auata_importanza]
	        ,[St_auata_dt_inizio]
	        ,[St_auata_dt_fine]
	        ,[St_auata_dt_riferimento]
	        ,[St_auata_data_modifica]
	        ,[St_auata_descr_utente]   
	   FROM [dbo].[Import_auata_ateco_ausca]
	   WHERE st_auata_ausca_codice_pk is not null 
	   AND st_auata_classificazione_ateco is not null 
	   AND st_auata_cod_att_output is not null	 
	   				
	--Print '*** Elaborazione Terminata !! ***'
		
END
