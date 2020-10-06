
-- Modificata da Raf il 02/07/2019
-- Introdotta la gestione degli attributi R1R e R2R

CREATE PROCEDURE [dbo].[SP_DMAG_INS_POS]
AS
BEGIN
	SET NOCOUNT ON;


/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT *
--  FROM [AUC].[dbo].[TB_AUPDI_POSIZIONI_DA_INSERIRE]

	DECLARE @pathEsecuzione as varchar(200)
	DECLARE @EsecuzioneST1 as varchar(200)
	DECLARE @EsecuzioneST2 as varchar(200)
	DECLARE @rit_Uniemens int
	DECLARE @rit_Codatori int
	DECLARE @rit_CA int

	DECLARE @AUTIS int
	DECLARE @AUTIS_CARICA varchar(3)
	DECLARE @NUMERO int
	DECLARE @DATA datetime
	DECLARE @IDMaxDA int
	DECLARE @TipoDitta1 int
	DECLARE @NumCAValidi int

	SELECT @pathEsecuzione = ausys_valore
	FROM   dbo.tb_ausys_sistema
	WHERE (ausys_parametro = 'AUC_5A')

	set @esecuzioneST1 = @pathEsecuzione + 'spWSgetDatiUniemens'
	set @esecuzioneST2 = @pathEsecuzione + 'spXauc'

	create table #temp_Dati (
				ZA_IstatComune varchar(6) null,
				ZA_ProgAzienda varchar(2) null,
				provinciaAzienda varchar(2) null,
				TipiDitta2 int null,
				TipiDitta1 int null,
				ZA_SomLav varchar(2) null,
				AZ_IdMaxDA int null,
				AN_Cognome varchar(300) null,
				AN_Nome varchar(300) null,
				IstatComuneRes varchar(6) null,
				CAPRes char(5) null,
				NumCivRes varchar(50),
				IndirizzoRes varchar(300) null,
				ComuneChiaroRes varchar(100) null,
				provinciaResidenza varchar(2),
				NumCAValidi int null,
				R1R int null,
				R2R int null
				) on [primary]

	create table #temp_SPXAUC_x_sede (
				CFazienda varchar(16) null,
				CIDA varchar(20) null,
				denominazione_dmag varchar(300) null,
				Nome_dmag varchar(300) null,
				DataInserimento datetime null,
				DataVariazione datetime null,
				Sede varchar(6),
				InizioAttivitaAzienda datetime,
				ateco varchar(6)
				) on [primary]

	create table #temp_SPXAUC_RL_totale (
				CFazienda varchar(16) null,
				CIDA varchar(20) null,
				data_valutazione datetime null,
				cf_rl varchar(16) null,
				denominazione_rl varchar(300) null,
				Nome_RL varchar(300) null,
				indirizzo_rl varchar(300) null,
				civico_rl varchar(50) null,
				cap_rl varchar(5) null,
				data_nasc_rl date,
				comune_rl varchar(300),
				Sede varchar(6),
				InizioAttivitaAzienda datetime,
				ateco varchar(6)
				) on [primary]

	create table #temp_SPXAUC_CIDA_RL (
				CFazienda varchar(16) null,
				CIDA varchar(20) null,
				data_valutazione datetime null,
				cf_rl varchar(16) null,
				denominazione_rl varchar(300) null,
				Nome_RL varchar(300) null,
				indirizzo_rl varchar(300) null,
				civico_rl varchar(50) null,
				cap_rl varchar(5) null,
				data_nasc_rl date,
				comune_rl varchar(300),
				Sede varchar(6),
				InizioAttivitaAzienda datetime,
				ateco varchar(6)
				) on [primary]

	create table #temp_SPXAUC_RL ( id int identity(1,1),
				CIDA varchar(20) null,
				data_valutazione datetime null,
				cf_rl varchar(16) null,
				cf_az varchar(16),
				id_fk int,
				data_inizio date,
				data_fine date,
				ausca_pk int,
				ausco_pk int,
				denominazione_rl varchar(300) null,
				Nome_rl varchar(300) null,
				indirizzo_rl varchar(300) null,
				civico_rl varchar(50) null,
				cap_rl varchar(5) null,
				data_nasc_rl date,
				comune_rl varchar(300),
				provincia varchar(2),
				comune_pulito varchar(300)
				) on [primary]

	--verifica presenza aupoc
	update [TB_AUPDI_POSIZIONI_DA_INSERIRE]
	set aupdi_stato = -1
	from [TB_AUPDI_POSIZIONI_DA_INSERIRE]
	inner join tb_aupoc_pos_contr on aupoc_posizione = aupdi_posizione
	where aupoc_aurea_codice_pk = 2

	--determina se esiste su AUSCA

	update [TB_AUPDI_POSIZIONI_DA_INSERIRE]
	set aupdi_flag_ausca = 'S', aupdi_ausca_codice_pk = ausca_codice_pk
	from [TB_AUPDI_POSIZIONI_DA_INSERIRE]
	inner join tb_ausca_sog_contr_az on ausca_codice_fiscale = aupdi_cf
	where aupdi_stato = 0

	DECLARE @DTINIZIO VARCHAR(30)
	DECLARE @DTFINE VARCHAR(30)
	DECLARE @UNIE VARCHAR(4)

	DECLARE @AUSCA INT
	DECLARE @FLAG CHAR
	DECLARE @AUPOC INT

	--DECLARE @id_cod_ateco02 integer = NULL
	--DECLARE @id_cod_ateco07 integer = NULL

	SET @UNIE = 'UNIE'
	SET @DTINIZIO = '1900-01-01'
	SET @DTFINE   = '2999-12-31'

	-- Inizia ciclo per gestire dati 
	Declare Cursore_CIDA Cursor
	For
			-- Seleziona il record valido da elaborare
			Select  aupdi_cf, aupdi_posizione, aupdi_ausca_codice_pk, aupdi_flag_ausca from [TB_AUPDI_POSIZIONI_DA_INSERIRE] where aupdi_stato = 0
			Open Cursore_CIDA
			    DECLARE @CF Varchar(16)    
				DECLARE @CIDA numeric(18,0)

			    FETCH NEXT FROM Cursore_CIDA INTO @CF, @CIDA, @AUSCA, @FLAG
				WHILE (@@FETCH_STATUS = 0)		
				BEGIN

					set @data = getdate()
					delete #temp_Dati
					--determina i dati della posizione su 5A
					insert into #temp_dati
					exec  @rit_Uniemens = @esecuzioneST1 @UNIE, @CF, @CIDA, @DTINIZIO, @DTFINE, null

					if @FLAG is null
					begin
						--Deve inserire record su AUSCA


					insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
					values ('1.0 dmag pos',
					'cf: '+@CF+
					' pos: '+convert(varchar(30),@CIDA),
					@data,'AUSCA DMAG')-- from #temp_SPXAUC_rl_totale

							INSERT INTO [dbo].[tb_ausca_sog_contr_az]
									   ([ausca_contro_codice]
									   ,[ausca_denominazione]
									   ,[ausca_cognome]
									   ,[ausca_nome]
									   ,[ausca_codice_fiscale]
									   ,[ausca_aungi_codice_pk]
									   ,[ausca_indirizzo]
									   ,[ausca_civico]
									   ,[ausca_descr_comune]
									   ,[ausca_sigla_provincia]
									   ,[ausca_cap]
									   ,ausca_soggetto_certificato
									   ,[ausca_auten_codice_pk]
									   ,[ausca_codice_entita_rif]
									   ,[ausca_note]
									   ,[ausca_data_modifica]
									   ,[ausca_descr_utente])
							select top(1)
									   null
									   ,AN_Cognome
									   ,AN_Cognome 
									   ,AN_Nome
									   ,@CF
									   ,case when (len(@cf) <= 11) then 106 else 10 end
									   ,IndirizzoRes
									   ,NumCivRes
									   ,substring(ComuneChiaroRes,1,30)
									   ,provinciaResidenza
									   ,CAPRes
									   ,'N'
									   ,3
									   ,9
									   ,'Inserito come recupero da DMAG'
									   ,getdate()
									   ,'Inserimento da DMAG'
										 from #temp_dati 
					
							--aggiorna lo stato ed il valore di ausca
							update [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							set aupdi_ausca_codice_pk = (select top(1) ausca_codice_pk from tb_ausca_sog_contr_az where ausca_codice_fiscale = @cf),
								aupdi_stato = 1
							from [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							where aupdi_stato = 0 and aupdi_cf = @cf
					end


					insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
					values ('2.0 dmag pos',
					'cf: '+@CF+
					' pos: '+convert(varchar(30),@CIDA),
					@data,'AUPOC DMAG')-- from #temp_SPXAUC_rl_totale

					--inserimento AUPOC
					INSERT INTO [dbo].[tb_aupoc_pos_contr]
					   ([aupoc_contro_codice]
					   ,[aupoc_ausca_codice_pk]
					   ,[aupoc_auapp_codice_pk]
					   ,[aupoc_auspc_codice_pk]
					   ,[aupoc_autdt_codice_pk]
					   ,[aupoc_autd2_codice_pk]
					   ,[aupoc_posizione]
					   ,[aupoc_denom_posiz_contr]
					   ,[aupoc_cod_prov_istat]
					   ,[aupoc_cod_comune_istat]
					   ,[aupoc_prog_azienda_agr]
					   ,[aupoc_cida]
					   ,[aupoc_note]
					   ,[aupoc_data_modifica]
					   ,[aupoc_descr_utente]
					   ,[aupoc_tipo_posizione]
					   ,aupoc_aurea_codice_pk
				)
				 select top(1)
					   null
					   ,aupdi_ausca_codice_pk
					   ,9
					   ,1
					   ,TipiDitta1
					   ,TipiDitta2
					   ,aupdi_posizione
					   ,aupdi_denominazione
					   ,substring(ZA_IstatComune,1,3)
					   ,substring(ZA_IstatComune,4,3)
					   ,ZA_ProgAzienda
					   ,aupdi_posizione
					   ,'Inserita da DMAG'
					   ,getdate()
					   ,'Inserita da stored DMAG'
					   ,0
					   ,2
						 from #temp_dati inner join TB_AUPDI_POSIZIONI_DA_INSERIRE on aupdi_posizione = @CIDA

							--aggiorna lo stato ed il valore di aupoc
							update [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							set aupdi_aupoc_codice_pk = (select aupoc_codice_pk from [tb_aupoc_pos_contr] where aupoc_posizione = @cida and aupoc_aurea_codice_pk = 2),
								aupdi_stato = 2
							from [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							where aupdi_stato IN (0,1) and aupdi_cf = @cf

				--Fase di determinazione e valorizzazione della sede Inps
				delete #temp_SPXAUC_x_sede

				insert into #temp_SPXAUC_x_sede
				exec  @esecuzioneST2 1, null, @cida, @cida, null, null

				--aggiornamento ateco su AUPOC
				update top(1) tb_aupoc_pos_contr
				set aupoc_auate_2002_codice_pk = ( SELECT TOP 1 auate_codice_pk
													FROM dbo.tb_auate_cod_ateco_ct
													inner join #temp_SPXAUC_x_sede on auate_cod_ateco_complessivo = ateco 
													AND auate_anno_riferimento = 2002 and cida= @cida
													where len(ateco) = 5 ),
				    aupoc_auate_2007_codice_pk = ( SELECT TOP 1 auate_codice_pk
													FROM dbo.tb_auate_cod_ateco_ct
													inner join #temp_SPXAUC_x_sede on auate_cod_ateco_complessivo = ateco 
													AND auate_anno_riferimento = 2007 and cida= @cida 
													where len(ateco) = 6),

					aupoc_ateco = ateco
				from tb_aupoc_pos_contr inner join #temp_SPXAUC_x_sede on aupoc_posizione = cida and aupoc_aurea_codice_pk = 2

				--aggiornamento ateco su AUSCA
				if @FLAG is NULL
				begin
					update top(1) tb_ausca_sog_contr_az
						set ausca_auate_2002_codice_pk = ( SELECT TOP 1 auate_codice_pk
															FROM dbo.tb_auate_cod_ateco_ct
															inner join #temp_SPXAUC_x_sede on auate_cod_ateco_complessivo = ateco 
															AND auate_anno_riferimento = 2002 and cida= @cida 
															where len(ateco) = 5),

						    ausca_auate_2007_codice_pk = ( SELECT TOP 1 auate_codice_pk
															FROM dbo.tb_auate_cod_ateco_ct
															inner join #temp_SPXAUC_x_sede on auate_cod_ateco_complessivo = ateco 
															AND auate_anno_riferimento = 2007 and cida= @cida 
															where len(ateco) = 6),

						ausca_ateco = ateco
					from tb_ausca_sog_contr_az inner join #temp_SPXAUC_x_sede on ausca_codice_fiscale = CFAzienda
				end


				--aggiorna la sede in chiaro
				update top(1) tb_aupoc_pos_contr
				set aupoc_cod_sede_INPS = #temp_SPXAUC_x_sede.sede,
				aupoc_data_inizio_attivita = InizioAttivitaAzienda
				from tb_aupoc_pos_contr inner join #temp_SPXAUC_x_sede on aupoc_posizione = cida and aupoc_aurea_codice_pk = 2

				--aggiorna la sede in codice
				update top(1) tb_aupoc_pos_contr
				set aupoc_ausin_codice_pk = ausin_codice_pk
				from tb_aupoc_pos_contr inner join tb_ausin_sedi_inps_ct on substring(aupoc_cod_sede_INPS,1,4) = ausin_codice_sede 
				where aupoc_posizione = @cida and aupoc_aurea_codice_pk = 2

				--Inserimento AUIND
				select @aupoc=aupoc_codice_pk from tb_aupoc_pos_contr
				where aupoc_posizione = @cida and aupoc_aurea_codice_pk = 2

					insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
					values ('3.0 dmag pos',
					'cf: '+@CF+
					' pos: '+convert(varchar(30),@CIDA),
					@data,'AUIND DMAG')-- from #temp_SPXAUC_rl_totale

				INSERT INTO [dbo].[tb_auind_indirizzi]
						   ([auind_lingua]
						   ,[auind_tabella]
						   ,[auind_tabella_codice_pk]
						   ,[auind_indirizzo]
						   ,[auind_civico]
						   ,[auind_descr_comune]
						   ,[auind_sigla_provincia]
						   ,[auind_cap]
						   ,[auind_chiave_interna]
						   ,[auind_gestore_indirizzo]
						   ,[auind_flag_operativo]
						   ,[auind_data_modifica]
						   ,[auind_descr_utente]
						   ,[auind_aurea_codice_pk])
					 select top(1)
						   'ITALIANO'
						   ,'AUPOC'
						   ,@AUPOC
							,IndirizzoRes
							,NumCivRes
							,substring(ComuneChiaroRes,1,30)
							,provinciaResidenza
							,CAPRes
						   ,@cida
						   ,'Agricoli'
						   ,1
						   ,getdate()
						   ,'Inserito da stored DMAG'
						   ,2
							 from #temp_dati 

							--aggiorna lo stato
							update [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							set aupdi_stato = 3
							from [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							where aupdi_stato = 2 and aupdi_cf = @cf

					--Gestione RL
					--Ricerca RL
					delete #temp_SPXAUC_RL_totale
					insert into #temp_SPXAUC_RL_totale
						exec  @esecuzioneST2 null, 1, @cida, @cida, null, null

					delete #temp_SPXAUC_RL
					select @numero=count(*) from #temp_SPXAUC_RL_totale
					if @numero > 0 
					begin
						--Ci sono rappresentanti Legali
						set @AUTIS = 35 
						set @AUTIS_CARICA = 'LER'
						insert into #temp_SPXAUC_RL(cida, data_valutazione, cf_rl, CF_AZ, denominazione_rl, nome_rl, indirizzo_rl, civico_rl, cap_rl, data_nasc_rl, comune_rl)
						select cida, data_valutazione, cf_rl, CFazienda, upper(denominazione_rl), 
						upper(nome_RL), 
						upper(indirizzo_rl), 
						upper(civico_rl), cap_rl, data_nasc_rl, upper(comune_rl)
						from #temp_SPXAUC_RL_totale
						order by cida asc, data_valutazione asc

						-- aggiornamento indice
						update #temp_SPXAUC_RL
						set id_fk = id-1,
						data_inizio = convert(date,data_valutazione)

						--determina data fine
						update #temp_SPXAUC_RL
						set #temp_SPXAUC_RL.data_fine = dateadd(day, -1, #temp_SPXAUC_RL_1.data_inizio)
						from #temp_SPXAUC_RL  
						inner join #temp_SPXAUC_RL as #temp_SPXAUC_RL_1 on #temp_SPXAUC_RL.id = #temp_SPXAUC_RL_1.id_fk
						and #temp_SPXAUC_RL.cida = #temp_SPXAUC_RL_1.cida

					end
					else
					begin
							--Non ci sono rappresentanti Legali ma solo il Titolare
						set @AUTIS = 89 
						set @AUTIS_CARICA = 'TI'

						insert into #temp_SPXAUC_RL(cida, cf_rl, CF_AZ, denominazione_rl, nome_rl, indirizzo_rl, civico_rl, cap_rl, comune_rl)
						select @cida, @cf, @cf, upper(AN_Cognome), upper(AN_Nome), upper(IndirizzoRes), upper(NumCivRes), CAPRes, upper(substring(ComuneChiaroRes,1,30))
						from #temp_dati

						update #temp_SPXAUC_RL
						set data_inizio = InizioAttivitaAzienda
						from #temp_SPXAUC_RL inner join #temp_SPXAUC_x_sede on #temp_SPXAUC_x_sede.cida = #temp_SPXAUC_RL.cida
					end
						--tappo alto per data fine non presente
						update #temp_SPXAUC_RL
						set data_fine = '2999-12-31'
						where data_fine is null

						--aggiornamento chiave verso ausca
						update #temp_SPXAUC_RL 
						set ausca_pk = ausca_codice_pk
						from #temp_SPXAUC_RL 
						inner join tb_ausca_sog_contr_az on ausca_codice_fiscale = cf_az

						--aggiornamento chiave verso ausco
						update #temp_SPXAUC_RL 
						set ausco_pk = ausco_codice_pk
						from #temp_SPXAUC_RL 
						inner join tb_ausco_sog_contr_col on ausco_codice_fiscale = cf_rl

						--estrazione provincia
						update #temp_SPXAUC_RL 
						set provincia = substring(comune_rl,charindex('(', comune_rl)+1,2)
						where charindex('(',comune_rl)>0

						--estrazione comune
						update #temp_SPXAUC_RL 
						set comune_pulito = substring(comune_rl,1, charindex('(', comune_rl)-1)
						where charindex('(',comune_rl)>0

					insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
					SELECT '4.0 dmag pos',
					'cf: '+@CF+
					' pos: '+convert(varchar(30),@CIDA)+
					' CFRL: ' + cf_rl,
					@data,'AUSCO DMAG' from #temp_SPXAUC_RL
						where ausco_pk is null
						group by cf_rl

						--Inserimento in AUSCO i soggetti provenienti da DMAG raggruppati per cf e prelevando la data inizio più recente
						INSERT INTO [dbo].[tb_ausco_sog_contr_col]
						   ([ausco_codice_fiscale]
						   ,[ausco_data_modifica]
						   ,[ausco_aurea_codice_pk])
						select upper(cf_rl), 
							max(data_inizio),
							2
						from #temp_SPXAUC_RL
						where ausco_pk is null
						group by cf_rl

					insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
					SELECT '5.0 dmag pos',
					'cf: '+@CF+
					' pos: '+convert(varchar(30),@CIDA)+
					' CFRL: ' + cf_rl,
					@data,'UDP AUSCO DMAG' 	from [tb_ausco_sog_contr_col] inner join #temp_SPXAUC_RL on cf_rl = ausco_codice_fiscale and ausco_data_modifica = data_inizio and
						ausco_aurea_codice_pk = 2

						----aggiornamento di AUSCO per gli altri dati
						UPDATE[dbo].[tb_ausco_sog_contr_col]
						   set [ausco_cognome] = substring(denominazione_rl,1,255)
						   ,[ausco_nome] = substring(Nome_rl,1,150)
						   ,[ausco_data_nascita] = data_nasc_rl
						   ,[ausco_tipo_persona] = case when len(ausco_codice_fiscale) = 16 then 'F' else 'G' end
						   ,[ausco_localita] = case when isnull(comune_pulito,'')='' then substring(comune_rl,1,50) else substring(comune_pulito,1,50) end
						   ,[ausco_indirizzo] = substring(indirizzo_rl,1,100)
						   ,[ausco_civico] = substring(civico_rl,1,50)
						   ,[ausco_cap] = substring(cap_rl,1,5)
						   ,[ausco_provincia] = provincia
						   ,[ausco_data_modifica] = getdate()
						   ,[ausco_descr_utente] = 'Inserimento da stored DMAG'
						from    [tb_ausco_sog_contr_col] inner join #temp_SPXAUC_RL on cf_rl = ausco_codice_fiscale and ausco_data_modifica = data_inizio and
						ausco_aurea_codice_pk = 2

							--aggiorna lo stato
							update [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							set aupdi_stato = 4
							from [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							where aupdi_stato = 3 and aupdi_cf = @cf

						--aggiornamento chiave verso ausco dei record appena inseriti
						update #temp_SPXAUC_RL 
						set ausco_pk = ausco_codice_pk
						from #temp_SPXAUC_RL 
						inner join tb_ausco_sog_contr_col on ausco_codice_fiscale = cf_rl
						where ausco_pk is null


						--Inserimento su AURSS
						if not EXISTS (select aurss_codice_pk from tb_aurss_rel_sog_sog inner join #temp_SPXAUC_RL on ausca_pk = aurss_ausca_codice_PK and
											ausco_pk = aurss_ausco_codice_pk and data_inizio = aurss_data_inizio_validita and data_fine = [aurss_data_di_fine_validita] and
											aurss_autis_codice_pk = @autis and [aurss_auten_codice_pk] = 3 and [aurss_codice_entita_rif] = 9
										where ausco_pk is not null and ausca_pk is not null )

						begin
							insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
							SELECT '5.0 dmag pos',
							'cf: '+@CF+
							' pos: '+convert(varchar(30),@CIDA)+
							' CFRL: ' + cf_rl,
							@data,'AURSS DMAG' from #temp_SPXAUC_RL 
							where ausco_pk is not null and ausca_pk is not null 

							INSERT INTO [dbo].tb_aurss_rel_sog_sog
									   (
										[aurss_ausca_codice_pk]
									   ,[aurss_ausco_codice_pk]
									   ,[aurss_aussu_codice_pk]
									   ,[aurss_autis_codice_pk]
									   ,[aurss_data_inizio_validita]
									   ,[aurss_data_di_fine_validita]
									   ,[aurss_note]
									   ,[aurss_rappresentante_legale]
									   ,[aurss_data_modifica]
									   ,[aurss_descr_utente]
									   ,[aurss_relazione_certificata]
									   ,[aurss_auten_codice_pk]
									   ,[aurss_codice_entita_rif]
									   ,[aurss_codice_carica]
									   ,[aurss_provenienza]
									   ,aurss_posizione
							)
							select   ausca_pk, ausco_pk, 1, @AUTIS, data_inizio, data_fine, 'Inserito da stored DMAG', 'S', getdate(), 'Allineamento DMAG', 'N', 3, 9, @AUTIS_CARICA ,'DMAG', @CIDA
							from #temp_SPXAUC_RL 
							where ausco_pk is not null and ausca_pk is not null 
							--aggiorna lo stato
							update [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							set aupdi_stato = 5
							from [TB_AUPDI_POSIZIONI_DA_INSERIRE]
							where aupdi_stato = 4 and aupdi_cf = @cf
						end


					FETCH NEXT FROM Cursore_CIDA INTO @CF, @CIDA, @AUSCA, @FLAG
				END
		CLOSE Cursore_CIDA
		DEALLOCATE Cursore_CIDA

END

--------------------------------
