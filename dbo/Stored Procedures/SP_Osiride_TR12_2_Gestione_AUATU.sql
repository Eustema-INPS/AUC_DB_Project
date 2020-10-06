
CREATE PROCEDURE [dbo].[SP_Osiride_TR12_2_Gestione_AUATU] 
AS
BEGIN

--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
--    VALUES (10, 'B', 'OSIRIDE', Getdate(),'6.1','TR12_2_Gestione_AUATU - Inizio', Getdate(), 'AdminPlus' )
	
TRUNCATE TABLE Import_auatu_ateco_auulo
               
-- Inserimento in import_auatu_ateco_auulo dei codici 2002
INSERT INTO [dbo].[Import_auatu_ateco_auulo]
           ([St_auatu_codice_fiscale_ausca]
           ,[St_auatu_progressivo]
		   ,[St_auatu_dt_aperturaUL] 
	       ,[St_auatu_cod_comuneUL] 
	       ,[St_auatu_provinciaUL] 
	       ,[St_auatu_dt_chiusuraUL] 
           ,[St_auatu_classificazione_ateco]
           ,[St_auatu_cod_att_input]
           ,[St_auatu_descr_attivita]
           ,[St_auatu_cod_importanza]
           ,[St_auatu_importanza]
           ,[St_auatu_dt_inizio]
           ,[St_auatu_dt_fine]
           ,[St_auatu_dt_riferimento]
           ,[St_auatu_data_modifica]
           ,[St_auatu_descr_utente])
SELECT   
	  dati_id.value('@c-fiscale', 'varchar(16)') AS CodiceFiscale,
	  localizzazione.value('@progressivo','varchar(5)') as ProgressivoUL,
	--  localizzazione.value('@dt-apertura','varchar(10)') as DataApertura,
	  case when localizzazione.value('@dt-apertura','varchar(10)') is null then '1900-01-01'
		 else substring(localizzazione.value('@dt-apertura','varchar(10)'),7,4)+'-'+substring(localizzazione.value('@dt-apertura','varchar(10)'),4,2)+'-'+
			  substring(localizzazione.value('@dt-apertura','varchar(10)'),1,2) end as DataCessazione,
	  indirizzo.value('@c-comune','varchar(3)') as CodiceComune,
	  indirizzo.value('@provincia','varchar(2)') as Provincia,
	  case when cessazione.value('@dt-cessazione','varchar(10)') is null then '2999-12-31'
		 else substring(cessazione.value('@dt-cessazione','varchar(10)'),7,4)+'-'+substring(cessazione.value('@dt-cessazione','varchar(10)'),4,2)+'-'+
			  substring(cessazione.value('@dt-cessazione','varchar(10)'),1,2) end as DataCessazione,
	  '2002' as annoAteco,
	  ateco2002.value('@c-attivita','varchar(10)') as CodAteco2002,
	  ateco2002.value('@attivita','varchar(200)') as DesAteco2002,
	  ateco2002.value('@c-importanza','varchar(1)') as cImportanza2002,
	  ateco2002.value('@importanza','varchar(50)') as Importanza2002,
	  case when ateco2002.value('@dt-inizio','varchar(10)') is null then '1900-01-01'
		   else substring(ateco2002.value('@dt-inizio','varchar(10)'),7,4)+'-'+substring(ateco2002.value('@dt-inizio','varchar(10)'),4,2)+'-'+
			substring(ateco2002.value('@dt-inizio','varchar(10)'),1,2) end as dtInizio2002,
	  case when ateco2002.value('@dt-fine','varchar(10)') is null then '2999-12-31'
			else substring(ateco2002.value('@dt-fine','varchar(10)'),7,4)+'-'+substring(ateco2002.value('@dt-fine','varchar(10)'),4,2)+'-'+
			substring(ateco2002.value('@dt-fine','varchar(10)'),1,2) end as dtFine2002,
	  case when ateco2002.value('@dt-riferimento','varchar(10)') is null then '1900-01-01'
			else substring(ateco2002.value('@dt-riferimento','varchar(10)'),7,4)+'-'+substring(ateco2002.value('@dt-riferimento','varchar(10)'),4,2)+'-'+
			substring(ateco2002.value('@dt-riferimento','varchar(10)'),1,2) end as dtRiferimento2002,
	  getdate(),
	  'Inserimento da visura'
	  FROM tb_auvis_visure 
	  CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/dati-identificativi') AS T1(dati_id)
	  --CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/info-attivita') AS T2(info_attivita)
	  CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/localizzazioni/localizzazione') AS T3(localizzazione)
	  CROSS APPLY localizzazione.nodes('classificazioni-ateco-2002/classificazione-ateco-2002') as T4(ateco2002)
	  OUTER APPLY localizzazione.nodes('indirizzo-localizzazione') as T5(Indirizzo)
	  OUTER APPLY localizzazione.nodes('cessazione-localizzazione') as T6(cessazione)
WHERE ateco2002.value('@c-importanza','varchar(1)') IN ('P','S','I')

  -- Inserimento in import_auatu_ateco_auulo dei codici 2007
  --select * from dbo.[Import_auatu_ateco_auulo]
INSERT INTO [dbo].[Import_auatu_ateco_auulo]
           ([St_auatu_codice_fiscale_ausca]
           ,[St_auatu_progressivo]
		   ,[St_auatu_dt_aperturaUL] 
	       ,[St_auatu_cod_comuneUL] 
	       ,[St_auatu_provinciaUL] 
	       ,[St_auatu_dt_chiusuraUL] 
           ,[St_auatu_classificazione_ateco]
           ,[St_auatu_cod_att_input]
           ,[St_auatu_descr_attivita]
           ,[St_auatu_cod_importanza]
           ,[St_auatu_importanza]
           ,[St_auatu_dt_inizio]
           ,[St_auatu_dt_fine]
           ,[St_auatu_dt_riferimento]
           ,[St_auatu_data_modifica]
           ,[St_auatu_descr_utente])
SELECT   
	  dati_id.value('@c-fiscale', 'varchar(16)') AS CodiceFiscale,
	  localizzazione.value('@progressivo','varchar(5)') as ProgressivoUL,
	--  localizzazione.value('@dt-apertura','varchar(10)') as DataApertura,
	  CASE WHEN localizzazione.value('@dt-apertura','varchar(10)') is null then '1900-01-01'
	       ELSE substring(localizzazione.value('@dt-apertura','varchar(10)'),7,4)+'-'+substring(localizzazione.value('@dt-apertura','varchar(10)'),4,2)+'-'+
	            substring(localizzazione.value('@dt-apertura','varchar(10)'),1,2) END AS DataCessazione,	
	  indirizzo.value('@c-comune','varchar(3)') as CodiceComune,
	  indirizzo.value('@provincia','varchar(2)') as Provincia,
	  CASE WHEN cessazione.value('@dt-cessazione','varchar(10)') is null then '2999-12-31'
	     ELSE substring(cessazione.value('@dt-cessazione','varchar(10)'),7,4)+'-'+substring(cessazione.value('@dt-cessazione','varchar(10)'),4,2)+'-'+
	          substring(cessazione.value('@dt-cessazione','varchar(10)'),1,2) END AS DataCessazione,	
	  '2007' as annoAteco,
	  ateco2007.value('@c-attivita','varchar(10)') AS CodAteco2007,
	  ateco2007.value('@attivita','varchar(200)') AS DesAteco2007,
	  ateco2007.value('@c-importanza','varchar(1)') AS cImportanza2007,
	  ateco2007.value('@importanza','varchar(50)') AS Importanza2007,
	  CASE WHEN ateco2007.value('@dt-inizio','varchar(10)') is null then '1900-01-01'
	       ELSE substring(ateco2007.value('@dt-inizio','varchar(10)'),7,4)+'-'+substring(ateco2007.value('@dt-inizio','varchar(10)'),4,2)+'-'+
			substring(ateco2007.value('@dt-inizio','varchar(10)'),1,2) end as dtInizio2007,
	  CASE WHEN ateco2007.value('@dt-fine','varchar(10)') is null then '2999-12-31'
			ELSE substring(ateco2007.value('@dt-fine','varchar(10)'),7,4)+'-'+substring(ateco2007.value('@dt-fine','varchar(10)'),4,2)+'-'+
			substring(ateco2007.value('@dt-fine','varchar(10)'),1,2) end as dtFine2007,
	  CASE WHEN ateco2007.value('@dt-riferimento','varchar(10)') is null then '1900-01-01'
			ELSE substring(ateco2007.value('@dt-riferimento','varchar(10)'),7,4)+'-'+substring(ateco2007.value('@dt-riferimento','varchar(10)'),4,2)+'-'+
				 substring(ateco2007.value('@dt-riferimento','varchar(10)'),1,2) end as dtRiferimento2007,
	  GetDate() As DataSistema,
	  'Inserimento da visura' As Note

  FROM tb_auvis_visure 
	CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/dati-identificativi') AS T1(dati_id)
	--CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/info-attivita') AS T2(info_attivita)
	CROSS APPLY auvis_visura_xml.nodes('/blocchi-impresa/localizzazioni/localizzazione') AS T3(localizzazione)
	CROSS APPLY localizzazione.nodes('classificazioni-ateco/classificazione-ateco') as T4(ateco2007)
	outer APPLY localizzazione.nodes('indirizzo-localizzazione') as T5(Indirizzo)
	outer APPLY localizzazione.nodes('cessazione-localizzazione') as T6(cessazione)
WHERE ateco2007.value('@c-importanza','varchar(1)') IN ('P','S','I')

--select * from import_auatu_ateco_auulo where st_auatu_auulo_codice_pk is null

-- Valorizzazione chiave esterna verso AUSCA
UPDATE import_auatu_ateco_auulo
SET st_auatu_ausca_codice_pk = ausca_codice_pk
FROM import_auatu_ateco_auulo inner join tb_ausca_sog_contr_az on ausca_codice_fiscale = st_auatu_codice_fiscale_ausca

-- Valorizzazione chiave esterna verso AUULO
UPDATE import_auatu_ateco_auulo
SET st_auatu_auulo_codice_pk = auulo_codice_pk
FROM import_auatu_ateco_auulo inner join tb_auulo_unita_locale on auulo_ausca_codice_pk = st_auatu_ausca_codice_pk 
AND [auulo_Progressivo_localizz] = st_auatu_progressivo 
AND (
		([auulo_data_apertura] = [St_auatu_dt_aperturaUL]) OR
		([auulo_data_apertura] IS NULL AND [St_auatu_dt_aperturaUL] = '1900-01-01')
	) 
AND	(
		([auulo_codice_comune] = [St_auatu_cod_comuneUL]) OR
		([auulo_codice_comune] = '' AND [St_auatu_cod_comuneUL] is null)
	) 
AND (
		([auulo_sigla_prov] = [St_auatu_provinciaUL]) OR
		([auulo_sigla_prov] = '' AND [St_auatu_cod_comuneUL] is null) 
	) 
AND (
		([auulo_data_cessazione] = [St_auatu_dt_chiusuraUL]) OR 
		([St_auatu_dt_chiusuraUL] = '2999-12-31' AND [auulo_data_cessazione] is null)
	)

-- Valorizzazione codice ateco output

UPDATE import_auatu_ateco_auulo
SET st_auatu_cod_att_output = substring(st_auatu_cod_att_input,1,2)+substring(st_auatu_cod_att_input,4,2)+substring(st_auatu_cod_att_input,7,2)

-- Cancellazione record su tabella target

DELETE tb_auatu_ateco_auulo
FROM tb_auatu_ateco_auulo inner join import_auatu_ateco_auulo ON 
	st_auatu_ausca_codice_pk = auatu_ausca_codice_pk 
--	AND st_auatu_auulo_codice_pk = auatu_auulo_codice_pk 
--	AND st_auatu_classificazione_ateco = auatu_classificazione_ateco

-- Inserimento record in tabella target

INSERT INTO [dbo].[tb_auatu_ateco_auulo]
           ([auatu_ausca_codice_pk]
           ,[auatu_ausca_codice_fiscale]
		   ,[auatu_auulo_codice_pk]		   
           ,[auatu_classificazione_ateco]
           ,[auatu_cod_att_output]
           ,[auatu_descr_attivita]
           ,[auatu_cod_importanza]
           ,[auatu_importanza]
           ,[auatu_dt_inizio]
           ,[auatu_dt_fine]
           ,[auatu_dt_riferimento]
           ,[auatu_data_modifica]
           ,[auatu_descr_utente])
SELECT [St_auatu_ausca_codice_pk]
      ,[St_auatu_codice_fiscale_ausca]
      ,[st_auatu_auulo_codice_pk]
      ,[St_auatu_classificazione_ateco]
      ,[St_auatu_cod_att_output]
      ,[St_auatu_descr_attivita]
      ,[St_auatu_cod_importanza]
      ,[St_auatu_importanza]
      ,[St_auatu_dt_inizio]
      ,[St_auatu_dt_fine]
      ,[St_auatu_dt_riferimento]
      ,[St_auatu_data_modifica]
      ,[St_auatu_descr_utente]
FROM [dbo].[Import_auatu_ateco_auulo]
WHERE st_auatu_ausca_codice_pk is not null and 
	  st_auatu_auulo_codice_pk is not null and 
	  st_auatu_classificazione_ateco is not null and 
	  st_auatu_cod_att_output is not null
				
	--Print '*** Elaborazione Terminata !! ***'
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (10, 'B', 'OSIRIDE', Getdate(),'6.2','TR12_2_Gestione_AUATU - Fine', Getdate(), 'AdminPlus' )
		
END
