--
-- Modificata da Raf il 26/02/2019
-- Introdotto il codice 94: natura giurica non presente
-- Modificata da Raf il 02/07/2019
-- Introdotta la gestione degli attributi R1R e R2R
--

CREATE PROCEDURE [dbo].[SP_DMAG_INS_RL]
AS
BEGIN
	SET NOCOUNT ON;

--drop table #temp_SPXAUC_RL
--drop table #temp_SPXAUC_x_sede
--drop table #temp_Dati


create table #temp(	posizione varchar(50) null, 
					cf varchar(16) null, 
					ng int, 
					ausca int null, 
					data_ausca datetime, 
					data_aupoc datetime, 
					ausco int null, 
					pres_tit char ) on [primary];

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

	create table #temp_SPXAUC_x_sede (
				CFazienda varchar(16) null,
				CIDA varchar(20) null,
				denominazione_dmag varchar(300) null,
				Nome_dmag varchar(300) null,
				DataInserimento datetime null,
				DataVariazione datetime null,
				Sede varchar(6),
				InizioAttivitaAzienda datetime,
				ATECO VARCHAR(6)
				) on [primary]


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

	DECLARE @EsecuzioneST1 as varchar(200)
	DECLARE @EsecuzioneST2 as varchar(200)
	DECLARE @rit_Uniemens int

	DECLARE @pathEsecuzione as varchar(200)
        DECLARE @CF Varchar(16)    
	DECLARE @CIDA numeric(18,0)
	DECLARE @AUTIS int
	DECLARE @AUTIS_CARICA varchar(3)
	DECLARE @DTINIZIO VARCHAR(30)
	DECLARE @DTFINE VARCHAR(30)
	DECLARE @UNIE VARCHAR(4)
	DECLARE @DATA datetime

	SET @UNIE = 'UNIE'
	SET @DTINIZIO = '1900-01-01'
	SET @DTFINE   = '2999-12-31'
	--SET @CF = 'SMLCVN94E01Z129F'
	--SET @CIDA = 411843
	set @AUTIS = 89 
	set @AUTIS_CARICA = 'TI'

	SELECT @pathEsecuzione = ausys_valore
	FROM   dbo.tb_ausys_sistema
	WHERE (ausys_parametro = 'AUC_5A')

	set @esecuzioneST1 = @pathEsecuzione + 'spWSgetDatiUniemens'
	set @esecuzioneST2 = @pathEsecuzione + 'spXauc'

	--determina quali siano i record potenzialmente indiziati
	insert into #temp(posizione, cf, ausca, data_ausca, data_aupoc, ng)
	select aupoc_posizione, ausca_codice_fiscale, ausca_codice_pk, ausca_data_modifica, aupoc_data_modifica, ausca_aungi_codice_pk from tb_aupoc_pos_contr
	inner join tb_ausca_sog_contr_az on aupoc_ausca_codice_pk = ausca_codice_pk
	where aupoc_aurea_codice_pk = 2 and len(ausca_codice_fiscale)=16 


	-- Verifica presenza su AUSCO
	update #temp
	set ausco= ausco_codice_pk
	from #temp inner join tb_ausco_sog_contr_col on ausco_codice_fiscale = cf

	-- Verifica se esiste una relazione come titolare
	update #temp
	set pres_tit = 'S'
	from #temp inner join tb_aurss_rel_sog_sog on ausca= aurss_ausca_codice_pk and ausco = aurss_ausco_codice_pk and
	(aurss_autis_codice_pk = 89 or aurss_autis_codice_pk = 90) and aurss_data_di_fine_validita>= getdate()

	Declare Cursore_RL Cursor
	For
		-- Seleziona il record valido da elaborare
		select posizione, cf from #temp
		where ((ausco is not null and ausca is not null and pres_tit is null) or
			   (ausco is null and ausca is not null and pres_tit is null) ) and (ng IN (10, 58, 94, 106) or ng is null)

		set @data = getdate()

		Open Cursore_RL

		FETCH NEXT FROM Cursore_RL INTO  @CIDA, @CF
		WHILE (@@FETCH_STATUS = 0)		
		BEGIN
			delete #temp_SPXAUC_x_sede
			delete #temp_dati
			delete #temp_SPXAUC_RL

			insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
				values ('1.0 dmag ins RL',
				'cf: '+@CF+' pos: '+convert(varchar(30), @CIDA),
				@data,'RL DMAG')

			insert into #temp_SPXAUC_x_sede
			exec  @esecuzioneST2 1, null, @cida, @cida, null, null

			insert into #temp_dati
			exec  @rit_Uniemens = @esecuzioneST1 @UNIE, @CF, @CIDA, @DTINIZIO, @DTFINE, null

			insert into #temp_SPXAUC_RL(cida, cf_rl, CF_AZ, denominazione_rl, nome_rl, indirizzo_rl, civico_rl, cap_rl, comune_rl)
			select @cida, @cf, @cf, upper(AN_Cognome), upper(AN_Nome), upper(IndirizzoRes), upper(NumCivRes), CAPRes, upper(substring(ComuneChiaroRes,1,30))
			from #temp_dati

			update #temp_SPXAUC_RL
			set data_inizio = InizioAttivitaAzienda
			from #temp_SPXAUC_RL inner join #temp_SPXAUC_x_sede on #temp_SPXAUC_x_sede.cida = #temp_SPXAUC_RL.cida

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


				if not EXISTS (select ausco_codice_pk from [tb_ausco_sog_contr_col] where ausco_codice_fiscale = @CF)
				begin

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
						   ,[ausco_descr_utente] = 'Inserimento da stored DMAG RL'
						from    [tb_ausco_sog_contr_col] inner join #temp_SPXAUC_RL on cf_rl = ausco_codice_fiscale and ausco_data_modifica = data_inizio and
								ausco_aurea_codice_pk = 2

					update #temp_SPXAUC_RL 
						set ausco_pk = ausco_codice_pk
						from #temp_SPXAUC_RL 
						inner join tb_ausco_sog_contr_col on ausco_codice_fiscale = cf_rl
								where ausco_pk is null
				end

				--Inserimento su AURSS
				if not EXISTS (select aurss_codice_pk from tb_aurss_rel_sog_sog inner join #temp_SPXAUC_RL on ausca_pk = aurss_ausca_codice_PK and
									ausco_pk = aurss_ausco_codice_pk and data_inizio = aurss_data_inizio_validita and data_fine = [aurss_data_di_fine_validita] and
									aurss_autis_codice_pk = @autis and [aurss_auten_codice_pk] = 3 and [aurss_codice_entita_rif] = 9
									where ausco_pk is not null and ausca_pk is not null )

				begin
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
						select   ausca_pk, ausco_pk, 1, @AUTIS, data_inizio, data_fine, 'Inserito da stored DMAG RL', 'S', getdate(), 'Allineamento DMAG', 'N', 3, 9, @AUTIS_CARICA ,'DMAG',@CIDA
						from #temp_SPXAUC_RL 
						where ausco_pk is not null and ausca_pk is not null 
				end


			FETCH NEXT FROM Cursore_RL INTO @CIDA, @CF
		END
		CLOSE Cursore_RL
		DEALLOCATE Cursore_RL
END

---------------------------------
/****** Object:  StoredProcedure [dbo].[SP_DMAG_INS_POS]    Script Date: 02/07/2019 15:55:40 ******/

SET ANSI_NULLS ON
