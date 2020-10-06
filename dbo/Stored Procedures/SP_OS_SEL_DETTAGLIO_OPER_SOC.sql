

-- =============================================
-- Author:		Raffaele Palmieri
-- Create date: 2017.07.21
-- Description:	Stored di selezione del dettaglio di un'Operazione Societaria 
--			    Se il parametro @estrai vale TOTALE deve ritornare non solo le posizioni partecipanti ma anche quelle non partecipanti.
-- =============================================
CREATE PROCEDURE [dbo].[SP_OS_SEL_DETTAGLIO_OPER_SOC]
	@auoso_codice_pk int,
	@estrai varchar(10)

AS
BEGIN

declare @chiave_auoso int

	SET NOCOUNT ON;

	set @chiave_auoso = (select top(1) [auosp_auoso_codice_pk] from [TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE] WITH (READUNCOMMITTED)
		where [auosp_auoso_codice_pk] = @auoso_codice_pk)
	IF ( @chiave_auoso is not null and @chiave_auoso <> 0)
	BEGIN
		-- Ritorna le sole posizioni partecipanti
		IF @estrai <> 'TOTALE' or @estrai is null
		begin
			SELECT [auosp_codice_fiscale] as CF
				  ,[auosp_posizione] as posizione
				  ,substring(aupoc_denom_posiz_contr,1,100) as denominazione
				  ,auind_descr_comune as comune
				  ,auspc_descr as stato
				  ,convert(date,aupoc_data_ultimo_stato) as data
				  ,[auosp_CSC_posizione] as csc
				  ,[auosp_CA_posizione] as ca
				  ,'P' as presenza
			FROM [AUC].[dbo].[TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE] WITH (READUNCOMMITTED)
			inner join tb_aupoc_pos_contr WITH (READUNCOMMITTED) on Aupoc_codice_pk = auosp_aupoc_codice_pk
			left outer join tb_auind_indirizzi WITH (READUNCOMMITTED) on [auind_tabella_codice_pk] = aupoc_codice_pk and [auind_tabella] = 'AUPOC'
			left outer join tb_auspc_stato_pos_contr_ct WITH (READUNCOMMITTED) on aupoc_auspc_codice_pk = auspc_codice_pk
			where [auosp_Cancellato_logicamente] = 'N' and auosp_auoso_codice_pk = @auoso_codice_pk
		end
		else
		-- Ritorna le posizioni partecipanti e quelle non partecipanti 
		begin
			create table #temp_Partecipanti (cf varchar(16) null, posizione varchar(50) null, denom varchar(100) null, comune varchar(50) null,
										     stato varchar(50) null, data date null, csc varchar(5) null, ca varchar(60) null, presente char null) on [primary]
			create table #temp_cf (cf_az varchar(16)) on [primary]
			create table #temp_Totali (cf varchar(16) null, posizione varchar(50) null, denom varchar(100) null, comune varchar(50) null,
										     stato varchar(50) null, data date null, csc varchar(5) null, ca varchar(60) null, presente char null) on [primary]

			-- Seleziona le posizioni partecipanti
			insert into #temp_Partecipanti (cf, posizione, denom, comune, stato, data, csc, ca, presente )
			SELECT [auosp_codice_fiscale]
				  ,[auosp_posizione]
				  ,substring(aupoc_denom_posiz_contr,1,100) as denominazione
				  ,auind_descr_comune as comune
				  ,auspc_descr as stato
				  ,convert(date,aupoc_data_ultimo_stato)
				  ,[auosp_CSC_posizione]
				  ,[auosp_CA_posizione]
				  ,'P'
			FROM [AUC].[dbo].[TB_AUOSP_OPERAZIONE_SOCIETARIA_PARTECIPANTE] WITH (READUNCOMMITTED)
			inner join tb_aupoc_pos_contr WITH (READUNCOMMITTED) on Aupoc_codice_pk = auosp_aupoc_codice_pk
			left outer join tb_auind_indirizzi WITH (READUNCOMMITTED) on [auind_tabella_codice_pk] = aupoc_codice_pk and [auind_tabella] = 'AUPOC'
			left outer join tb_auspc_stato_pos_contr_ct WITH (READUNCOMMITTED) on aupoc_auspc_codice_pk = auspc_codice_pk
			where [auosp_Cancellato_logicamente] = 'N' and auosp_auoso_codice_pk = @auoso_codice_pk

			-- Seleziona i cf delle posizioni partecipanti
			insert into #temp_cf (cf_az)
			select cf from #temp_Partecipanti
			group by cf

			-- Seleziona tutte le posizioni (IVA) dei cf partecipanti
			insert into #temp_Totali (cf, posizione, denom, comune, stato, data, csc, ca, presente )
			select	#temp_cf.cf_az,
					aupoc_posizione,
					substring(aupoc_denom_posiz_contr,1,100),
					auind_descr_comune,
					auspc_descr,
					convert(date,aupoc_data_ultimo_stato),
					[aupco_cod_stat_contr],
					[aupco_codici_autor],
					'N'
			from #temp_cf 
			inner join tb_ausca_sog_contr_az WITH (READUNCOMMITTED) on cf_az = ausca_codice_fiscale
			inner join tb_aupoc_pos_contr WITH (READUNCOMMITTED) on aupoc_ausca_codice_pk = ausca_codice_pk and aupoc_aurea_codice_pk = 1 and left([aupoc_posizione],1) <> 'Z'
			left outer join tb_auind_indirizzi WITH (READUNCOMMITTED) on [auind_tabella_codice_pk] = aupoc_codice_pk and [auind_tabella] = 'AUPOC'
			left outer join tb_auspc_stato_pos_contr_ct WITH (READUNCOMMITTED) on aupoc_auspc_codice_pk = auspc_codice_pk
			left outer join tb_aupco_periodo_contr WITH (READUNCOMMITTED) on aupco_aupoc_codice_pk = aupoc_codice_pk
			where convert(date,[aupco_data_inizio_validita]) <= convert(date,getdate())
			and convert(date,[aupco_data_fine_validita]) >= convert(date,getdate())

			-- Riconosce le posizioni partecipanti nel gruppo delle totali
			update #temp_Totali
			set #temp_Totali.presente = 'P'
			from #temp_Totali inner join #temp_Partecipanti on #temp_Partecipanti.posizione = #temp_Totali.posizione

			-- Ritorna l'elenco totale delle posizioni ordinando per presenza, cf, posizione
			SELECT cf as CF
				  ,posizione as posizione
				  ,denom as denominazione
				  ,comune as comune
				  ,stato as stato
				  ,data as data
				  ,csc as csc
				  ,ca as ca
				  ,presente as presenza
			from #temp_Totali
			order by presente desc, cf asc, posizione asc
		end
	END
	ELSE
	-- non esiste codice su AUOSP  la stored ritorna False
		RETURN 1
END

