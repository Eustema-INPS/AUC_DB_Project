
CREATE PROCEDURE [dbo].[SP_DMAG_AGG_DENOM]
AS
BEGIN
	SET NOCOUNT ON;

	declare @data datetime

	DECLARE @pathEsecuzione as varchar(200)
	DECLARE @EsecuzioneST4 as varchar(200)

	DECLARE @data_rif as date

	--DECLARE @id_cod_ateco02 integer = NULL
	--DECLARE @id_cod_ateco07 integer = NULL

	create table #temp_SPXAUC_totale (
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

	create table #temp_SPXAUC (
				CFazienda varchar(16) null,
				CIDA varchar(20) null,
				denominazione_dmag varchar(300) null,
				Nome_dmag varchar(300) null,
				DataInserimento datetime null,
				DataVariazione datetime null,
				aupoc_codice_pk int null,
				data_mod_aupoc datetime null, 
				denom_originale_aupoc varchar(500) null, 
				denom_attuale_totale_dmag varchar(500) null, 
				denom_x_update varchar(500) null, 
				data_agg datetime null,
				ATECO VARCHAR(6)
				) on [primary]

		SELECT @pathEsecuzione = ausys_valore
		FROM   dbo.tb_ausys_sistema
		WHERE (ausys_parametro = 'AUC_5A')
		set @esecuzioneST4 = @pathEsecuzione + 'spXauc'

		SELECT @data_rif = convert(date,ausys_valore)
		FROM   dbo.tb_ausys_sistema
		WHERE (ausys_parametro = 'DMAG_DT_AGG')

--COLLATE SQL_Latin1_General_CP1_CI_AS 

		set @data = getdate()

		set @data = getdate()

		-- carica tutti i cida dell'insieme
		insert into #temp_SPXAUC_totale
			exec  @esecuzioneST4 1, null, null, null, @data_rif, '2999-12-31'
--			exec [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spXauc 1, null, 232628, 232629, null, null

		set @data = getdate()
		insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
		select '1.0 dmag',
		'cf: '+CFazienda+
		' pos: '+CIDA+
		' denom dmag: '+isnull(denominazione_dmag,'-')+
		' nome dmag:  '+isnull(Nome_dmag,'-')+
		' data ins: '+convert(varchar(30),DataInserimento)+
		' data var: '+convert(varchar(30),DataVariazione), 
		@data,'AGG DENOM DMAG' from #temp_SPXAUC_totale

		---- carica tutti i cida univoci per data variazione massima
		insert into #temp_SPXAUC (CFazienda, CIDA, DataVariazione)
		select CFazienda, CIDA, max(DataVariazione) from #temp_SPXAUC_totale
		group by CFazienda, CIDA

		set @data = getdate()
		insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
		select '2.0 dmag',
		'cf: '+CFazienda+
		' pos: '+CIDA+
		' data var: '+convert(varchar(30),DataVariazione), 
		@data,'AGG DENOM DMAG' from #temp_SPXAUC

		-- valorizza i dati mancanti
		update #temp_SPXAUC
		set #temp_SPXAUC.denominazione_dmag = #temp_SPXAUC_totale.denominazione_dmag,
		#temp_SPXAUC.nome_dmag = #temp_SPXAUC_totale.nome_dmag,
		denom_attuale_totale_dmag = isnull(#temp_SPXAUC_totale.denominazione_dmag,'') + ' ' + isnull(#temp_SPXAUC_totale.Nome_dmag,''),
		#temp_SPXAUC.DataInserimento = #temp_SPXAUC_totale.DataInserimento,
		#temp_SPXAUC.ateco = #temp_SPXAUC_totale.ateco
		from #temp_SPXAUC inner join #temp_SPXAUC_totale on #temp_SPXAUC.CFazienda = #temp_SPXAUC_totale.CFazienda and
		#temp_SPXAUC.DataVariazione = #temp_SPXAUC_totale.DataVariazione

		--Inizio aggiornamenti 
		update #temp_SPXAUC
		set #temp_SPXAUC.aupoc_codice_pk = tb_aupoc_pos_contr.aupoc_codice_pk,
			#temp_SPXAUC.denom_originale_aupoc = tb_aupoc_pos_contr.aupoc_denom_posiz_contr,
			data_mod_aupoc = aupoc_data_modifica
		from #temp_SPXAUC 
		left outer join tb_aupoc_pos_contr on aupoc_posizione = cida and aupoc_aurea_codice_pk = 2

		update #temp_SPXAUC
		set denom_x_update = case when denom_attuale_totale_dmag is null  then upper(denom_originale_aupoc)
		 else upper(denom_attuale_totale_dmag) end
		where (denom_originale_aupoc <> denominazione_dmag and nome_dmag is null) or
			  (denom_originale_aupoc <> denom_attuale_totale_dmag and nome_dmag is not null) 

		set @data = getdate()
		insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
		select '3.0 dmag',
		'cf: '+isnull(CFazienda,'')
		+' pos: '+CIDA
		+' pk: '+convert(varchar(20),(isnull(aupoc_codice_pk,0)))
		+' den aupoc: '+isnull(denom_originale_aupoc,'')
		+' dt aupoc: '+isnull(convert(varchar(30),data_mod_aupoc),'')
		+' den upd: '+isnull(denom_x_update,'')
		+' den_tot_dmag: '+isnull(denom_attuale_totale_dmag,'')
		+' den dmag: '+isnull(denominazione_dmag,'')
		+' nom dmag: '+isnull(nome_dmag,'')
		+' data var: '+isnull(convert(varchar(30),DataVariazione),''),
		@data,'AGG DENOM DMAG' from #temp_SPXAUC 
		where denom_x_update is not null or ateco is not null

		set @data = getdate()
		insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
		select '3.1 dmag',
		'cf: '+isnull(CFazienda,'')
		+' pos: '+CIDA
		+' pk: '+convert(varchar(20),(isnull(aupoc_codice_pk,0)))
		+' dt aupoc: '+isnull(convert(varchar(30),data_mod_aupoc),'')
		+' data var: '+isnull(convert(varchar(30),DataVariazione),'')
		+' ateco: '+isnull(ateco,''), 
		@data,'AGG ateco DMAG' from #temp_SPXAUC 
		where ateco is not null


		-- Inserimento in storico denominazione posizione
		set @data = getdate()
		insert into TB_AUSDP_STORICO_DENOM_POSIZIONE(
			[ausdp_posizione],
			[ausdp_aupoc_codice_pk] ,
			[ausdp_denom_precedente] ,
			[ausdp_denom_attuale] ,
			[ausdp_data_modifica_aupoc] ,
			[ausdp_data_modifica_dmag] ,
			[ausdp_data_modifica] ,
			[ausdp_descr_utente],
			ausdp_motivo) 
		select 
			cida, 
			aupoc_codice_pk,
			substring(denom_originale_aupoc,1,300), 
			substring(denom_x_update,1,300), 
			data_mod_aupoc, 
			DataVariazione,
			getdate(),
			'Agg Dmag',
			'Modifica DMAG'
		from #temp_SPXAUC 
			where denom_x_update is not null

		--Aggiornamento Denominazione AUPOC
		update tb_aupoc_pos_contr
		set aupoc_denom_posiz_contr = substring(denom_x_update,1,300),
		 aupoc_data_modifica = getdate(),
		 aupoc_descr_utente = 'Aggiornamento da DMAG'
		 from tb_aupoc_pos_contr
		 inner join #temp_SPXAUC on cida = aupoc_posizione
		where denom_x_update is not null

		--Aggiornamento Ateco AUPOC
		update tb_aupoc_pos_contr
		set 
	     aupoc_auate_2002_codice_pk = 		
			(
			SELECT TOP 1 auate_codice_pk
			FROM dbo.tb_auate_cod_ateco_ct
			inner join #temp_SPXAUC on auate_cod_ateco_complessivo = ateco AND auate_anno_riferimento = 2002 and cida= aupoc_posizione
			where len(ateco) = 5
			),
	     aupoc_auate_2007_codice_pk = 
			(
			SELECT TOP 1 auate_codice_pk
			FROM dbo.tb_auate_cod_ateco_ct
			inner join #temp_SPXAUC on auate_cod_ateco_complessivo = ateco AND auate_anno_riferimento = 2007 and cida= aupoc_posizione
			where len(ateco) = 6
			),
		 aupoc_ateco = ateco,
		 aupoc_data_modifica = getdate(),
		 aupoc_descr_utente = 'Aggiornamento da DMAG'
		 from tb_aupoc_pos_contr
		 inner join #temp_SPXAUC on cida = aupoc_posizione
		where ateco is not null


		--Riconoscimento posizioni DMAG non presenti da inserire
		set @data = getdate()
		insert into TB_AUPDI_POSIZIONI_DA_INSERIRE(
			[aupdi_posizione],
			[aupdi_provenienza],
			aupdi_cf,
			[aupdi_denominazione],
			[aupdi_stato],
			[aupdi_data_modifica],
			[aupdi_descr_utente] 
		)
		select CIDA, 'DMAG', CFazienda, substring(denom_attuale_totale_dmag,1,300),0, @data,'4.0 dmag'
		from #temp_SPXAUC 
		where aupoc_codice_pk is null

		set @data = getdate()
		insert into TB_AUOUT_OUTPUT_GENERICO([auout_tipo_operazione], [auout_output], [auout_data_modifica], [auout_descr_utente])
		select '4.0 dmag',
		'cf: '+isnull(CFazienda,'')
		+' pos: '+isnull(CIDA,'')
		+' pk: '+isnull(convert(varchar(20),(isnull(aupoc_codice_pk,0))),'')
		+' den aupoc: '+isnull(denom_originale_aupoc,'')
		+' dt aupoc: '+isnull(convert(varchar(30),convert(datetime,data_mod_aupoc,103)),'')
		+' den upd: '+isnull(denom_x_update,'')
		+' den_tot_dmag: '+isnull(denom_attuale_totale_dmag,'')
		+' den dmag: '+isnull(denominazione_dmag,'')
		+' nom dmag: '+isnull(nome_dmag,'')
		+' data var: '+isnull(convert(varchar(30),convert(datetime,DataVariazione,103)),''), 
		@data,'AGG DENOM DMAG:'+isnull(CIDA,'') from #temp_SPXAUC 
		where aupoc_codice_pk is null

		-- Aggiornamento data esecuzione
		update tb_ausys_sistema
		set ausys_valore = dateadd(day, 1, @data_rif)
		WHERE (ausys_parametro = 'DMAG_DT_AGG')

		drop table #temp_SPXAUC_totale
		drop table #temp_SPXAUC
END


