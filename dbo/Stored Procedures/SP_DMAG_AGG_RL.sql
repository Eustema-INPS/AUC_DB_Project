
CREATE PROCEDURE [dbo].[SP_DMAG_AGG_RL]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @pathEsecuzione as varchar(200)
	DECLARE @EsecuzioneST4 as varchar(200)
	DECLARE @EsecuzioneST1 as varchar(200)

	declare @data datetime
	DECLARE @CIDA numeric(18,0)
	DECLARE @data_rif as date

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
				ATECO VARCHAR(6)
				) on [primary]

	create table #temp_SPXAUC_CIDA (
				CIDA varchar(20) null,
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
				comune_nascita varchar(300), --aggiunto 28062018
				prov_nascita varchar(2),	 --aggiunto 28062018
				telefono varchar(30),		 --aggiunto 28062018
				sesso char(1),				 --aggiunto 28062018
				comune_rl varchar(300),
				provincia varchar(2),
				comune_pulito varchar(300)
				) on [primary]

		create table #temp_anagrafica (
			cf varchar(16) null,
			cognome varchar(300) null,
			Nome varchar(300) null,
			sesso char(1) null,
			data_nascita date null,
			comune_nascita varchar(300) null,
			prov_nascita varchar(2),
			indirizzo varchar(300) null,
			civico varchar(50) null,
			cap varchar(5) null,
			comune varchar(300) null,
			codIstat varchar(6) null,
			provincia varchar(2) null,
			telefono varchar(30) null,
			mail varchar(300) null,
			pec varchar(300) null,
			valido char(1)
			) on [primary];

		SELECT @pathEsecuzione = ausys_valore
		FROM   dbo.tb_ausys_sistema
		WHERE (ausys_parametro = 'AUC_5A')
		set @esecuzioneST4 = @pathEsecuzione + 'spXauc'
		set @esecuzioneST1 = @pathEsecuzione + 'spPrelevaAnagrafica'

		SELECT @data_rif = convert(date,ausys_valore)
		FROM   dbo.tb_ausys_sistema
		WHERE (ausys_parametro = 'DMAG_DT_AGG_RL')

		--Cerca i record variati
		insert into #temp_SPXAUC_CIDA_RL
			exec  @esecuzioneST4 null, 1, null, null, @data_rif, '2999-12-31'

		--estrae i cida univoci dei record variati
		insert into #temp_SPXAUC_CIDA
		select cida from #temp_SPXAUC_CIDA_RL group by cida

		--determina i RL associati ai cida variati
		Declare Cursore_CIDA Cursor
		For
			Select  cida from #temp_SPXAUC_CIDA
			Open Cursore_CIDA
			    FETCH NEXT FROM Cursore_CIDA INTO @CIDA
				WHILE (@@FETCH_STATUS = 0)		
				BEGIN
					insert into #temp_SPXAUC_RL_totale
					exec  @esecuzioneST4 null, 1, @cida, @cida, null, null

					--reperimento informazioni anagrafiche
					insert into #temp_anagrafica
					exec  @esecuzioneST1 @cida

					FETCH NEXT FROM Cursore_CIDA INTO @CIDA
				END
		CLOSE Cursore_CIDA
		DEALLOCATE Cursore_CIDA

		set @data = getdate()

		insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
		select '1.0 dmag rl',
		'cf: '+CFazienda+
		' pos: '+CIDA+
		' cf rl: '+isnull(cf_rl,'-')+
		' data valut: '+convert(varchar(30),data_valutazione),
		@data,'RL DMAG' from #temp_SPXAUC_rl_totale

		insert into #temp_SPXAUC_RL(cida, data_valutazione, cf_rl, CF_AZ, denominazione_rl, nome_rl, indirizzo_rl, civico_rl, cap_rl, data_nasc_rl, comune_rl)
		select cida, data_valutazione, cf_rl, CFazienda, upper(denominazione_rl), 
		upper(nome_RL), 
		upper(indirizzo_rl), 
		upper(civico_rl), cap_rl, data_nasc_rl, upper(comune_rl)
		from #temp_SPXAUC_RL_totale
		order by cida asc, data_valutazione asc

		set @data = getdate()
		insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
		select '2.0 dmag rl',
		'cf: '+CF_az+
		' pos: '+CIDA+
		' cf rl: '+isnull(cf_rl,'-')+
		' data valut: '+convert(varchar(30),data_valutazione),
		@data,'RL DMAG' from #temp_SPXAUC_RL

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

		set @data = getdate()
		insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
		select '3.0 dmag rl',
		'cf: '+CF_rl,
		@data,'RL DMAG' from #temp_SPXAUC_RL
		where ausco_pk is null
		group by cf_rl

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
           ,[ausco_provincia] = #temp_SPXAUC_RL.provincia
           ,[ausco_data_modifica] = getdate()
           ,[ausco_descr_utente] = 'Inserimento da DMAG'
--		   ,ausco_comune_nascita = substring(comune_nascita,1,50)
--		   ,ausco_sesso = sesso
--		   ,ausco_prov_nascita = substring(provincia_nascita,1,2)
--		   ,ausco_telefono2 = substring(telefono,1,20)
--		   ,ausco_email = substring(mail,1,162)
--		   ,ausco_pec = substring(pec,1,162)


        from    [tb_ausco_sog_contr_col] inner join #temp_SPXAUC_RL on cf_rl = ausco_codice_fiscale and ausco_data_modifica = data_inizio and
		ausco_aurea_codice_pk = 2
		inner join #temp_anagrafica on cf = ausco_codice_fiscale

		--aggiornamento chiave verso ausco dei record appena inseriti
		update #temp_SPXAUC_RL 
		set ausco_pk = ausco_codice_pk
		from #temp_SPXAUC_RL 
		inner join tb_ausco_sog_contr_col on ausco_codice_fiscale = cf_rl
		where ausco_pk is null

		----Inserimento nello storico delle relazioni dmag
		if (exists (select    [aurss_codice_pk] from tb_aurss_rel_sog_sog
		inner join #temp_SPXAUC_RL on aurss_ausca_codice_pk = ausca_pk and aurss_ausco_codice_pk = ausco_pk
		where ausco_pk is not null and ausca_pk is not null and 
		aurss_auten_codice_pk = 3 and aurss_codice_entita_rif = 9 and aurss_rappresentante_legale = 'S' )

		) begin
			INSERT INTO [dbo].[tb_ausrd_storico_rl_DMAG]
				   ([ausrd_aurss_codice_pk]
				   ,[ausrd_ausca_codice_pk]
				   ,[ausrd_ausco_codice_pk]
				   ,[ausrd_aussu_codice_pk]
				   ,[ausrd_autis_codice_pk]
				   ,[ausrd_data_inizio_validita]
				   ,[ausrd_data_di_fine_validita]
				   ,[ausrd_note]
				   ,[ausrd_rappresentante_legale]
				   ,[ausrd_data_modifica]
				   ,[ausrd_descr_utente]
				   ,[ausrd_relazione_certificata]
				   ,[ausrd_cert_auten_cod_pk]
				   ,[ausrd_cert_cod_entita_rif]
				   ,[ausrd_cert_data_modifica]
				   ,[ausrd_auten_codice_pk]
				   ,[ausrd_codice_entita_rif]
				   ,[ausrd_codice_carica]
				   ,[ausrd_provenienza]
				   ,[ausrd_causa_storicizzazione]
				   ,[ausrd_utente_storicizzazione]
				   ,[ausrd_data_storicizzazione]
				   ,[ausrd_motivo_storicizzazione])
				select    [aurss_codice_pk]
				   ,[aurss_ausca_codice_pk]
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
				   ,[aurss_cert_auten_cod_pk]
				   ,[aurss_cert_cod_entita_rif]
				   ,[aurss_cert_data_modifica]
				   ,[aurss_auten_codice_pk]
				   ,[aurss_codice_entita_rif]
				   ,[aurss_codice_carica]
				   ,[aurss_provenienza]
				   ,'D'
				   ,'Processo allineamento DMAG'
				   ,getdate()
				   ,'Allimenato DMAG'
					from tb_aurss_rel_sog_sog
				inner join #temp_SPXAUC_RL on aurss_ausca_codice_pk = ausca_pk and aurss_ausco_codice_pk = ausco_pk
				where ausco_pk is not null and ausca_pk is not null and 
				aurss_auten_codice_pk = 3 and aurss_codice_entita_rif = 9 and aurss_rappresentante_legale = 'S'
		end
		-- Cancellazione logica su AURSS
		update tb_aurss_rel_sog_sog
		set aurss_rec_del = 'S'
		from tb_aurss_rel_sog_sog
		inner join #temp_SPXAUC_RL on aurss_ausca_codice_pk = ausca_pk and aurss_ausco_codice_pk = ausco_pk
		where ausco_pk is not null and ausca_pk is not null and 
		aurss_auten_codice_pk = 3 and aurss_codice_entita_rif = 9 and aurss_rappresentante_legale = 'S'

		--Inserimento su AURSS
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
		select   ausca_pk, ausco_pk, 1, 35, data_inizio, data_fine, 'Inserito da DMAG', 'S', getdate(), 'Allineamento DMAG', 'N', 3, 9, 'LER' ,'DMAG', CIDA
		from #temp_SPXAUC_RL 
		where ausco_pk is not null and ausca_pk is not null 

		--Cancellazione fisica su AURSS

		delete tb_aurss_rel_sog_sog
		where aurss_rec_del = 'S'

		-- Aggiornamento data esecuzione
		update tb_ausys_sistema
		set ausys_valore = dateadd(day, 1, @data_rif)
		WHERE (ausys_parametro = 'DMAG_DT_AGG_RL')

		drop table #temp_SPXAUC_RL
		drop table #temp_SPXAUC_RL_totale
		drop table #temp_SPXAUC_CIDA_RL
		drop table #temp_SPXAUC_CIDA

END


/****** Object:  StoredProcedure [dbo].[SP_DMAG_INS_RL]    Script Date: 22/05/2019 12:28:42 ******/
SET ANSI_NULLS ON
