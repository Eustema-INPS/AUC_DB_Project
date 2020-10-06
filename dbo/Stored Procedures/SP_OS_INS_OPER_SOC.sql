

-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2017.07.21
-- Description:	Stored di Inserimento, modifica, cancellazione (logica) delle Operazioni Societarie
--			    Il parametro Azione può valere 
--				INSERT (effettua il solo inserimento dei dati forniti)
--				MODIFY (effettua l'inserimento dei dati forniti e storicizza i dati relativi al codice @chiave_operazione_societaria)
--				CANCEL (storicizza i dati relativi al codice @chiave_operazione_societaria e li cancella logicamente)
-- =============================================
CREATE PROCEDURE [dbo].[SP_OS_INS_OPER_SOC]
	@azione varchar(8),
	@tipo_operazione char,
	@posizione_riferimento varchar(50),
	@descr_operazione varchar(200),
	@data_operazione date,
	@codice_fiscale_delegato varchar(16),
	@codice_operatore varchar(8),
	@note varchar(200),
	@chiave_operazione_societaria int,
	@stato_operazione varchar(20),
	@posizioni_partecipanti as dbo.OS_Posizioni_partecipanti READONLY,
	@auoso_codice_pk bigint output

AS
BEGIN
	
	SET NOCOUNT ON;
declare @chiave_ausca int
declare @chiave_aupoc int
declare @id_auoso int
declare @id_auoss int

-- Se il cf esiste su AUSCA va avanti altrimenti termina
--set @chiave_ausca = (select ausca_codice_pk from tb_ausca_sog_contr_az where ausca_codice_fiscale = @codice_fiscale) 

set @chiave_aupoc = (select aupoc_codice_pk from tb_aupoc_pos_contr WITH (READUNCOMMITTED)
		where aupoc_posizione = @posizione_riferimento and aupoc_aurea_codice_pk = 1 and left([aupoc_posizione],1) <> 'Z') 
IF ( @chiave_aupoc is not null and @chiave_aupoc <> 0)
BEGIN
	if (@azione = 'INSERT') 
	BEGIN
		INSERT INTO [dbo].[TB_AUOSO_OPERAZIONE_SOCIETARIA]
           ([auoso_tipo_operazione]
           ,[auoso_codice_fiscale_riferimento]
           ,[auoso_posizione_riferimento]
           ,[auoso_descr_operazione]
           ,[auoso_data_operazione]
           ,[auoso_stato_operazione]
           ,[auoso_CSC_posizione_riferimento]
           ,[auoso_CA_posizione_riferimento]
           ,[auoso_codice_fiscale_delegato]
           ,[auoso_codice_operatore]
           ,[auoso_azione_effettuata]
           ,[auoso_data_azione]
		   ,auoso_note
           ,[auoso_aupoc_codice_pk]
           ,[auoso_data_modifica]
           ,[auoso_descr_utente])
		select	@tipo_operazione,
			ausca_codice_fiscale,
			@posizione_riferimento,
			@descr_operazione,
			@data_operazione,
			@stato_operazione,
			[aupco_cod_stat_contr],
			[aupco_codici_autor],
			@codice_fiscale_delegato,
			@codice_operatore,
			'I',
			getdate(),
			@note,
			@chiave_aupoc,
			getdate(),
			'Inserito da applicazione'
			from tb_aupoc_pos_contr WITH (READUNCOMMITTED)
			inner join tb_ausca_sog_contr_az WITH (READUNCOMMITTED) on aupoc_ausca_codice_pk = ausca_codice_pk
			left outer join tb_aupco_periodo_contr WITH (READUNCOMMITTED) on aupco_aupoc_codice_pk = @chiave_aupoc
			where aupoc_codice_pk = @chiave_aupoc and convert(date,[aupco_data_inizio_validita]) <= convert(date,getdate())
			and convert(date,[aupco_data_fine_validita]) >= convert(date,getdate())

	-- Memorizza id ultimo record

		set @id_auoso = (SELECT isnull(SCOPE_IDENTITY(),0))
		set @auoso_codice_pk = @id_auoso

		INSERT INTO [dbo].[TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE]
           ([auosp_auoso_codice_pk]
           ,[auosp_codice_fiscale]
           ,[auosp_posizione]
           ,[auosp_CSC_posizione]
           ,[auosp_CA_posizione]
           ,[auosp_aupoc_codice_pk]
           ,[auosp_Cancellato_logicamente]
           ,[auosp_data_modifica]
           ,[auosp_descr_utente])

		select	@id_auoso,
			ausca_codice_fiscale,
			elenco_pos_part.posizione_partecipante,
			[aupco_cod_stat_contr],
			[aupco_codici_autor],
			aupoc_codice_pk,
			'N',
			getdate(),
			'Inserito da applicazione'
		from @posizioni_partecipanti as elenco_pos_part 
			inner join tb_aupoc_pos_contr WITH (READUNCOMMITTED) on aupoc_posizione = elenco_pos_part.posizione_partecipante and aupoc_aurea_codice_pk = 1 and left([aupoc_posizione],1) <> 'Z'
			inner join tb_ausca_sog_contr_az WITH (READUNCOMMITTED) on aupoc_ausca_codice_pk = ausca_codice_pk
			left outer join tb_aupco_periodo_contr WITH (READUNCOMMITTED) on aupco_aupoc_codice_pk = aupoc_codice_pk
			where convert(date,[aupco_data_inizio_validita]) <= convert(date,getdate())
			and convert(date,[aupco_data_fine_validita]) >= convert(date,getdate())

	END
	if (@azione = 'MODIFY') OR (@azione = 'CANCEL')
	BEGIN
		-- Storicizza dati di AUOSO su AUOSS
		INSERT INTO [dbo].[TB_AUOSS_OPERAZIONE_SOCIETARIA_STORICO]
           ([auoss_auoso_codice_pk]
           ,[auoss_tipo_operazione]
           ,[auoss_codice_fiscale_riferimento]
           ,[auoss_posizione_riferimento]
           ,[auoss_descr_operazione]
           ,[auoss_data_operazione]
           ,[auoss_stato_operazione]
           ,[auoss_CSC_posizione_riferimento]
           ,[auoss_CA_posizione_riferimento]
           ,[auoss_codice_fiscale_delegato]
           ,[auoss_codice_operatore]
           ,[auoss_azione_effettuata]
           ,[auoss_data_azione]
           ,[auoss_aupoc_codice_pk]
		   ,auoss_note
           ,[auoss_data_storicizzazione]
           ,[auoss_descr_utente_storicizzazione]
           ,[auoss_data_modifica]
           ,[auoss_descr_utente])
		SELECT [auoso_codice_pk]
		  ,[auoso_tipo_operazione]
		  ,[auoso_codice_fiscale_riferimento]
		  ,[auoso_posizione_riferimento]
		  ,[auoso_descr_operazione]
		  ,[auoso_data_operazione]
		  ,[auoso_stato_operazione]
		  ,[auoso_CSC_posizione_riferimento]
		  ,[auoso_CA_posizione_riferimento]
		  ,[auoso_codice_fiscale_delegato]
		  ,[auoso_codice_operatore]
		  ,'M'
		  ,[auoso_data_azione]
		  ,[auoso_aupoc_codice_pk]
		  ,auoso_note
		  ,getdate()
		  ,'Inserito da modifica'
		  ,auoso_data_modifica
		  ,auoso_descr_utente
		FROM [AUC].[dbo].[TB_AUOSO_OPERAZIONE_SOCIETARIA] where [auoso_codice_pk] = @chiave_operazione_societaria

		set @id_auoss = (SELECT isnull(SCOPE_IDENTITY(),0))

		-- Storicizza dati si AUOSP su AUOPS
		INSERT INTO [dbo].[TB_AUOPS_OPERAZIONE_SOCIETARIA_PARTECIPANTE_STORICO]
           ([auops_auoso_codice_pk]
           ,[auops_auoss_codice_pk]
           ,[auops_codice_fiscale]
           ,[auops_posizione]
           ,[auops_CSC_posizione]
           ,[auops_CA_posizione]
           ,[auops_aupoc_codice_pk]
           ,[auops_Cancellato_logicamente]
           ,[auops_data_modifica]
           ,[auops_descr_utente])
		SELECT [auosp_auoso_codice_pk]
		   ,@id_auoss
		   ,[auosp_codice_fiscale]
           ,[auosp_posizione]
           ,[auosp_CSC_posizione]
           ,[auosp_CA_posizione]
           ,[auosp_aupoc_codice_pk]
           ,[auosp_Cancellato_logicamente]
		   ,getdate()
		   ,'Inserito da modifica'
        FROM [dbo].[TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE] where [auosp_auoso_codice_pk] = @chiave_operazione_societaria

		if (@azione = 'MODIFY')
		BEGIN
			-- Modifica i dati su AUOSO
			update 		[dbo].[TB_AUOSO_OPERAZIONE_SOCIETARIA]
				set [auoso_tipo_operazione] = @tipo_operazione,
					[auoso_codice_fiscale_riferimento] = ausca_codice_fiscale,
					[auoso_descr_operazione] = @descr_operazione,
					[auoso_data_operazione] = @data_operazione,
					[auoso_stato_operazione] = @stato_operazione,
					[auoso_codice_fiscale_delegato] = @codice_fiscale_delegato,
					[auoso_codice_operatore] = @codice_operatore,
					[auoso_azione_effettuata] = 'M',
					[auoso_data_azione] = getdate(),
					auoso_note = @note, 
					auoso_data_modifica = getdate(),
					auoso_descr_utente = 'Modificato da modifica'
			from [dbo].[TB_AUOSO_OPERAZIONE_SOCIETARIA] 
			inner join tb_aupoc_pos_contr WITH (READUNCOMMITTED) on aupoc_posizione = @posizione_riferimento and aupoc_aurea_codice_pk = 1 and left([aupoc_posizione],1) <> 'Z'
			inner join tb_ausca_sog_contr_az WITH (READUNCOMMITTED) on aupoc_ausca_codice_pk = ausca_codice_pk
			where [auoso_codice_pk] = @chiave_operazione_societaria

			-- Determina i partecipanti che devono essere cancellati o inseriti su AUOSP

			-- Crea tabelle temporanee
			create table #temp_entr (pos_entr varchar(50) null, pres_entr char null) on [primary]
			create table #temp_pres (pos_pres varchar(50) null, pres_pres char null) on [primary]

			--Inserisci record in tabelle temporanee
			insert into #temp_entr(pos_entr, pres_entr)
			select elenco_pos_part.posizione_partecipante, 'N'
			from @posizioni_partecipanti as elenco_pos_part

			insert into #temp_pres(pos_pres, pres_pres)
			select auosp_posizione, 'N'
			from [TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE] 
			where [auosp_auoso_codice_pk] = @chiave_operazione_societaria

			--Riconosce i record entranti gia' presenti in archivio
			update #temp_entr
			set pres_entr = 'S'
			from #temp_entr inner join [TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE] WITH (READUNCOMMITTED) on pos_entr=auosp_posizione 
				and [auosp_auoso_codice_pk] = @chiave_operazione_societaria 

			--Riconosce i record presenti che sono entranti
			update #temp_pres
			set pres_pres = 'S'
			from #temp_pres inner join @posizioni_partecipanti as elenco_pos_part on elenco_pos_part.posizione_partecipante = pos_pres
			

			-- Cancella i dati su AUOSP
			delete [TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE]
			from [TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE]
			inner join #temp_pres on pos_pres = auosp_posizione
			where [auosp_auoso_codice_pk] = @chiave_operazione_societaria and pres_pres = 'N'

			-- Inserisce i dati su AUOSP
			INSERT INTO [dbo].[TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE]
			   ([auosp_auoso_codice_pk]
			   ,[auosp_codice_fiscale]
			   ,[auosp_posizione]
			   ,[auosp_CSC_posizione]
			   ,[auosp_CA_posizione]
			   ,[auosp_aupoc_codice_pk]
			   ,[auosp_Cancellato_logicamente]
			   ,[auosp_data_modifica]
			   ,[auosp_descr_utente])

			select	@chiave_operazione_societaria,
				ausca_codice_fiscale,
				elenco_pos_part.posizione_partecipante,
				[aupco_cod_stat_contr],
				[aupco_codici_autor],
				aupoc_codice_pk,
				'N',
				getdate(),
				'Inserito da applicazione'
			from @posizioni_partecipanti as elenco_pos_part 
				inner join tb_aupoc_pos_contr WITH (READUNCOMMITTED) on aupoc_posizione = elenco_pos_part.posizione_partecipante and aupoc_aurea_codice_pk = 1 and left([aupoc_posizione],1) <> 'Z'
				inner join tb_ausca_sog_contr_az WITH (READUNCOMMITTED) on aupoc_ausca_codice_pk = ausca_codice_pk
				left outer join tb_aupco_periodo_contr WITH (READUNCOMMITTED) on aupco_aupoc_codice_pk = aupoc_codice_pk
				inner join #temp_entr on pos_entr = elenco_pos_part.posizione_partecipante and pres_entr = 'N'
				where convert(date,[aupco_data_inizio_validita]) <= convert(date,getdate())
				and convert(date,[aupco_data_fine_validita]) >= convert(date,getdate())
		END

		if (@azione = 'CANCEL')
		BEGIN
			--Cancella logicamente AUOSO
			update 		[dbo].[TB_AUOSO_OPERAZIONE_SOCIETARIA] 
			set auoso_azione_effettuata = 'C',
				auoso_data_azione = getdate(),
				auoso_data_modifica = getdate(),
				auoso_descr_utente = 'Cancellato da modifica'
			from [dbo].[TB_AUOSO_OPERAZIONE_SOCIETARIA] 
			where [auoso_codice_pk] = @chiave_operazione_societaria

			--Cancella logicamente AUOSP
			update 		[dbo].[TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE] 
			set auosp_Cancellato_logicamente = 'S',
				auosp_data_modifica = getdate(),
				auosp_descr_utente = 'Cancellato da modifica'
			from [dbo].[TB_AUOSO_OPERAZIONE_SOCIETARIA] 
			where [auosp_auoso_codice_pk] = @chiave_operazione_societaria
		END

		set @auoso_codice_pk = @chiave_operazione_societaria
	END






----- Storicizza i dati di AUOSO preesistenti su AUOSS
--	 insert into tb_ausra_storico_registro_aiuti 
--           ([ausra_ausca_codice_pk]
--           ,[ausra_RA_impresa_autonoma]
--           ,[ausra_RA_impresa_associata]
--           ,[ausra_RA_impresa_collegata]
--           ,[ausra_RA_data_fine_esercizio]
--           ,[ausra_RA_dimensione_aziendale]
--           ,[ausra_codice_operatore]
--           ,[ausra_codice_fiscale_delegato]
--           ,[ausra_data_modifica])
--     select ausca_codice_pk,
--			ausca_RA_impresa_autonoma,
--			ausca_RA_impresa_associata,
--			ausca_RA_impresa_collegata,
--			ausca_RA_data_fine_esercizio,
--			ausca_RA_dimensione_aziendale,
--			ausca_RA_codice_operatore,
--			ausca_RA_codice_fiscale_delegato,
--			getdate() from tb_ausca_sog_contr_az
--		where ausca_codice_fiscale = @codice_fiscale

---- Memorizza id ultimo record

--set @id_ausra= (SELECT isnull(SCOPE_IDENTITY(),0))

----Storicizza i cf collegati di AURAC su AUSRC
--	insert into tb_ausrc_storico_registro_aiuti_cf
--		([ausrc_ausra_codice_pk],
--		 [ausrc_codice_fiscale_impresa_collegata],
--		 [ausrc_data_modifica])
--	select @id_ausra, aurac_codice_fiscale_impresa_collegata, getdate() from tb_aurac_registro_aiuti_cf
--		where aurac_ausca_codice_pk=@chiave_ausca

----Aggiorna i dati di AUSCA
--	if (@azione <> 'CANCELLA') 
--	BEGIN
--		update tb_ausca_sog_contr_az
--		set ausca_RA_impresa_autonoma = @impresa_autonoma,
--			ausca_RA_impresa_associata = @impresa_associata,
--			ausca_RA_impresa_collegata = @impresa_collegata,
--			ausca_RA_data_fine_esercizio = @data_fine_esercizio,
--			ausca_RA_dimensione_aziendale = @dimensione_aziendale,
--			ausca_RA_codice_operatore = @codice_operatore,
--			ausca_RA_codice_fiscale_delegato = @codice_fiscale_delegato,
--			ausca_RA_data_modifica = getdate(),
--			ausca_data_modifica = getdate()
--			where ausca_codice_fiscale = @codice_fiscale
--	END
--	ELSE
---- Cancellazione AUSCA
--	BEGIN
--		update tb_ausca_sog_contr_az
--		set ausca_RA_impresa_autonoma = 'N',
--			ausca_RA_impresa_associata = 'N',
--			ausca_RA_impresa_collegata = 'N',
--			ausca_RA_data_fine_esercizio = NULL,
--			ausca_RA_dimensione_aziendale = NULL,
--			ausca_RA_codice_operatore = @codice_operatore,
--			ausca_RA_codice_fiscale_delegato = NULL,
--			ausca_RA_data_modifica = getdate(),
--			ausca_data_modifica = getdate()
--			where ausca_codice_fiscale = @codice_fiscale
--	END

----Cancella i dati su AURAC
--	delete from tb_aurac_registro_aiuti_cf
--		where aurac_ausca_codice_pk=@chiave_ausca

----Inserisce i record su AURAC
--	if (@azione <> 'CANCELLA') 
--	BEGIN
--		INSERT INTO [dbo].[tb_aurac_registro_aiuti_cf]
--           ([aurac_ausca_codice_pk]
--           ,[aurac_codice_fiscale_impresa_collegata]
--           ,[aurac_data_modifica])
--		select @chiave_ausca, aurac.[codice_fiscale_collegato], getdate() from @codici_fiscali_collegati as aurac
--	END
-- END
		
 ELSE
-- non esiste cf su ausca  la stored ritorna False
RETURN 1
END
END

