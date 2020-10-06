

-- Modificata da Raf il 02/07/2019
-- Introdotta la gestione degli attributi R1R e R2R


CREATE PROCEDURE [dbo].[SP_DMAG_CIDA] @List AS dbo.DmagCidaList_v6 READONLY
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @pathEsecuzione as varchar(200)
	DECLARE @EsecuzioneST1 as varchar(200)
	DECLARE @EsecuzioneST2 as varchar(200)
	DECLARE @EsecuzioneST3 as varchar(200)
	DECLARE @rit_Uniemens int
	DECLARE @rit_Codatori int
	DECLARE @rit_CA int

	DECLARE @IDMaxDA int
	DECLARE @TipoDitta1 int
	DECLARE @NumCAValidi int

	SELECT @pathEsecuzione = ausys_valore
	FROM   dbo.tb_ausys_sistema
	WHERE (ausys_parametro = 'AUC_5A')

	set @esecuzioneST1 = @pathEsecuzione + 'spWSgetDatiUniemens'
	set @esecuzioneST2 = @pathEsecuzione + 'spWSgetDatiCodatoriUniemens'
	set @esecuzioneST3 = @pathEsecuzione + 'spWSgetDatiCodAgevUniemens'

--print @esecuzioneST1
--	EXEC @esecuzione @aupoc_cida

	create table #temp_PosAgri (
				CodiceFiscaleAziendaDich varchar(16) null,
				Cida numeric(18,0) null,
				tipoRichiesta char null,
				AnnoMeseDenuncia varchar(6) null, --"AAAAMM” (es. “201211”) 
				DataInizio varchar(30) null,
				DataFine varchar(30) null,
				CIDAPadre varchar(8) null,
				CodiceIstatAzienda varchar(6) null,
				CodiceProgressivoAzienda varchar(2) null,
				provinciaAzienda varchar(2) null,
    			TipoDitta1 varchar(2) null,
				TipoDitta2 varchar(2) null,
				IdMaxDA int null,
				Cognome varchar(80) null,
				Nome varchar(30) null,
				AziendaSomministratrice varchar(1) null,
				DenominazioneUrbanistica varchar(10) null,
				CodiceIstatResidenza varchar(6) null,
				provinciaResidenza varchar(2) null,
				CAPResidenza char(5) null,
				Civico varchar(8),
				Indirizzo varchar(80) null,
				ComuneResidenza varchar(32) null,
				NumCAValidi int null,
				ListaCIDACod varchar(max) null,
				ListaCodAg varchar(max) null,
				CodiceFiscaleAziendaSomm [varchar](16) NULL,
				CodiceIstatAziendaSomm [varchar](6) NULL,
				CodiceProgressivoAziendaSomm [varchar](2) NULL,
				TipoDitta1Somm [varchar](2) NULL,
				TipoDitta2Somm [varchar](2) NULL,
				Esito int default 0,
				MotivoErrore varchar(40) default null,
				EsitoCallStoredCall int null,
				EsitoCallStoredCodatori int null,
				EsitoCallStoredAgevolazioni int null
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

	create table #temp_codatori (
				CfCodatore varchar(16),
				CidaCodatore varchar(10)
				) on [primary]

	create table #temp_CA (
				CA_Codice varchar(2),
				Descr_Cod varchar(200),
				CA_DataDal date,
				CA_DataAl date
				) on [primary]

	-- Inserisce i dati di input nella tabella temporanea
	insert into #temp_PosAgri (Cida, CodiceFiscaleAziendaDich, tipoRichiesta, AnnoMeseDenuncia,CIDAPadre)
	SELECT CIDA, CodiceFiscaleAziendaDich, [TipoRichiesta], AnnoMeseDenuncia, CIDAPadre
	FROM @List
	GROUP BY 
		CIDA, CodiceFiscaleAziendaDich, [TipoRichiesta], AnnoMeseDenuncia, CIDAPadre


-- Valorizza le date inizio e fine in base alla data di riferimento
	UPDATE 	#temp_PosAgri
	Set DataInizio = substring(AnnoMeseDenuncia,1,4)+'-'+substring(AnnoMeseDenuncia,5,2)+'-01'

	UPDATE 	#temp_PosAgri
	set DataFine = EOMONTH(DataInizio) 

	-- Valorizza il codice fiscale
	--UPDATE 	#temp_PosAgri
	--Set CodiceFiscale = ausca_codice_fiscale
	--from #temp_PosAgri
	--inner join tb_aupoc_pos_contr on aupoc_posizione = CIDA and aupoc_aurea_codice_pk = 2
	--inner join tb_ausca_sog_contr_az on aupoc_ausca_codice_pk = ausca_codice_pk

	Declare Cursore_CIDA Cursor
	For
			Select  CodiceFiscaleAziendaDich, Cida, tipoRichiesta, DataInizio, DataFine from #temp_PosAgri
			Open Cursore_CIDA
			    DECLARE @CF Varchar(16)    
--				DECLARE @CIDA int
				DECLARE @CIDA numeric(18,0)
				DECLARE @TIPORICHIESTA char
				DECLARE @DTINIZIO VARCHAR(30)
				DECLARE @DTFINE VARCHAR(30)
				DECLARE @UNIE VARCHAR(4)

				SET @UNIE = 'UNIE'

			    FETCH NEXT FROM Cursore_CIDA INTO @CF, @CIDA, @TIPORICHIESTA, @DTINIZIO, @DTFINE
				WHILE (@@FETCH_STATUS = 0)		
				BEGIN
					delete #temp_Dati
--					exec [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiUniemens 'UNIE','00190120261p', 5178, '2015-01-01', '2017-01-31', null
--					exec [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiUniemens 'UNIE','DLLGDE40C11I210R', 160363, '2015-01-01', '2017-01-31', null
--					exec [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiUniemens 'UNIE','DLLGDE40C11I210R', 160363, '2015-01-01', '2015-01-31', null
--					exec [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiUniemens 'UNIE','01933380352', 5306, '2015-01-01', '2017-01-31', null
--					exec [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiUniemens 'UNIE','00190120261', '5178', '2015-01-01', '2015-12-31', null
				  if @tiporichiesta = 'P'
				  BEGIN
					-- Esecuzione stored Uniemens
					insert into #temp_dati
--					exec  @rit_Uniemens = [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiUniemens @UNIE, @CF, @CIDA, @DTINIZIO, @DTFINE, null
					exec  @rit_Uniemens = @esecuzioneST1 @UNIE, @CF, @CIDA, @DTINIZIO, @DTFINE, null
--					exec   @esecuzioneST1 @UNIE, @CF, @CIDA, @DTINIZIO, @DTFINE, @rit_Uniemens
					-- Aggiornamento dati tabella temporanea 
					IF @rit_Uniemens = 0 
					BEGIN
						update #temp_PosAgri 
							set CodiceIstatAzienda = substring(#temp_dati.ZA_IstatComune,1,6),
								CodiceProgressivoAzienda = substring(#temp_dati.ZA_ProgAzienda,1,2),
								provinciaAzienda = substring(#temp_dati.ProvinciaAzienda,1,2),
								TipoDitta1 = #temp_dati.TipiDitta1,
								TipoDitta2 = #temp_dati.TipiDitta2,
								AziendaSomministratrice = case #temp_dati.ZA_SomLav when  'SI' then 'S'
													    when 'NO' then 'N'
														else NULL end,
								IdMaxDA = #temp_dati.AZ_IDMaxDA,
								Cognome = substring(#temp_dati.AN_Cognome,1,80),
								Nome = case isnull(#temp_dati.AN_Nome,'--') when '--' then NULL
									   else substring(#temp_dati.AN_Nome,1,30) end,
								DenominazioneUrbanistica = '',
								CodiceIstatResidenza = substring(#temp_dati.IstatComuneRes,1,6),
								CAPResidenza = substring(#temp_dati.CAPRes,1,5),
								Civico = substring(#temp_dati.NumCivRes,1,8),
								Indirizzo = substring(#temp_dati.IndirizzoRes,1,80),
								ComuneResidenza = substring(#temp_dati.ComuneChiaroRes,1,30),
								provinciaResidenza = substring(#temp_dati.ProvinciaResidenza,1,2),
								NumCAValidi = #temp_dati.NumCAValidi,
     							EsitoCallStoredCall = @rit_Uniemens 
						from #temp_PosAgri 
						inner join #temp_dati on #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE
					END
					ELSE
					BEGIN
						update #temp_PosAgri 
    							set EsitoCallStoredCall = @rit_Uniemens 
						from #temp_PosAgri 
						where #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE
					END

					select @IDMaxDA = #temp_PosAgri.IdMaxDA, @TipoDitta1 = #temp_PosAgri.TipoDitta1, @NumCAValidi = #temp_PosAgri.NumCAValidi
					from #temp_PosAgri 
					where #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE 
					-- Verifica la condizione di chiamata alla stored Codatori 
					If (@rit_Uniemens = 0 or @rit_Uniemens is null) and @IDMaxDA > 0 and @TipoDitta1 = 55
					BEGIN
						-- Chiama Stored spWSgetDatiCodatoriUniemens
						delete #temp_codatori
						insert into #temp_codatori
--							exec @rit_Codatori = [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiCodatoriUniemens @UNIE, @IDMaxDA, null
							exec @rit_Codatori = @esecuzioneST2 @UNIE, @IDMaxDA, null
						-- Aggiornamento dati tabella temporanea 
						IF @rit_Codatori = 0
						BEGIN
							update #temp_PosAgri
								SET ListaCIDACod = (select CfCodatore+','+CidaCodatore+',' from #temp_codatori WHERE #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE FOR XML PATH('')),
								    EsitoCallStoredCodatori =  @rit_Codatori
							from #temp_PosAgri 
							inner join #temp_codatori on #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE
						END
						ELSE
						BEGIN
							update #temp_PosAgri
								SET EsitoCallStoredCodatori =  @rit_Codatori
							from #temp_PosAgri 
							where #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE
						END
					END
			
					-- Verifica la condizione di chiamata alla stored CA
					If (@rit_Uniemens = 0 or @rit_Uniemens is null) and @NumCAValidi > 0
					BEGIN
						-- Chiama Stored spWSgetDatiCodAgevUniemens
						delete #temp_CA
						insert into #temp_CA
--						exec [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiCOdAgevUniemens 160363,'2015-01-01', '2017-01-31', null
--						exec @rit_CA = [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiCodAgevUniemens @UNIE, @CIDA, @DTINIZIO, @DTFINE, null
						exec @rit_CA = @esecuzioneST3 @UNIE, @CIDA, @DTINIZIO, @DTFINE, null
						-- Aggiornamento dati tabella temporanea 
						IF @rit_CA = 0
						BEGIN
							update #temp_PosAgri
--								SET CodiciAgevolazione = STUFF((select CA_Codice+'|' from #temp_PosAgri FOR XML PATH('')), 1, 1, ''),
								SET ListaCodAg = (select CA_Codice+',' from #temp_PosAgri WHERE #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE FOR XML PATH('')) ,
								    EsitoCallStoredAgevolazioni =  @rit_CA
							from #temp_PosAgri 
							inner join #temp_CA on #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE
						END
						ELSE
						BEGIN
							update #temp_PosAgri
								SET EsitoCallStoredAgevolazioni =  @rit_CA
							from #temp_PosAgri 
							where #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE
						END
					END
				  END --Fine tiporichiesta = P
				  ELSE if @tiporichiesta = 'S'
				  BEGIN
					-- Esecuzione stored Uniemens
					insert into #temp_dati
--					exec  @rit_Uniemens = [SQLINPSSVIL06\SQL06].DBANAUAG.dbo.spWSgetDatiUniemens @UNIE, @CF, @CIDA, @DTINIZIO, @DTFINE, null
					exec  @rit_Uniemens = @esecuzioneST1 @UNIE, @CF, @CIDA, @DTINIZIO, @DTFINE, null
					-- Aggiornamento dati tabella temporanea 
					IF @rit_Uniemens = 0 
					BEGIN
						update #temp_PosAgri 
							set CodiceFiscaleAziendaSomm = @CF,
							    CodiceIstatAziendaSomm = #temp_dati.ZA_IstatComune,
								CodiceProgressivoAziendaSomm = #temp_dati.ZA_ProgAzienda,
								TipoDitta1Somm = #temp_dati.TipiDitta1,
								TipoDitta2Somm = #temp_dati.TipiDitta2,
     							EsitoCallStoredCall = @rit_Uniemens 
						from #temp_PosAgri 
						inner join #temp_dati on #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE
					END
					ELSE
					BEGIN
						update #temp_PosAgri 
    							set EsitoCallStoredCall = @rit_Uniemens 
						from #temp_PosAgri 
						where #temp_PosAgri.cida = @CIDA and #temp_PosAgri.DataInizio = @DTINIZIO and #temp_PosAgri.DataFine = @DTFINE
					END

				  END --Fine tiporichiesta = S
    
					FETCH NEXT FROM Cursore_CIDA INTO @CF, @CIDA, @TIPORICHIESTA, @DTINIZIO, @DTFINE
				END
		
	CLOSE Cursore_CIDA
	DEALLOCATE Cursore_CIDA

	update #temp_PosAgri
	set esito = (case when isnull(EsitoCallStoredCall, 0) = 0 then 0 else EsitoCallStoredCall end)+ 
				(case when EsitoCallStoredCodatori is null then 0 else EsitoCallStoredCodatori end)*100 + 
				(case when EsitoCallStoredAgevolazioni is null then 0 else EsitoCallStoredAgevolazioni end)*1000

	update #temp_PosAgri
	set motivoerrore= case when esito = -1 then 'Errore nella lettura dei dati 1'
						   when esito = -100 then 'Errore nella lettura dei dati 2'
						   when esito = -1000 then 'Errore nella lettura dei dati 3'
						   when esito = -2 then 'Azienda non presente'
						   when esito = -3 then 'Az. presente ma non attiva nel periodo 3'
						   when esito = -4 then 'Az. presente ma non attiva nel periodo 4'
						   when esito = -5 then 'Azienda senza tipo Ditta1'
						   when esito = -6 then 'Azienda senza tipo Ditta1 nel periodo'
						   when esito = -7 then 'Codice Istat Azienda non reperito'
					  end
	where esito <> 0

--update #temp_PosAgri
--set AziendaSomministratrice = 'S'
--where cida = 65474 and CodiceFiscaleAziendaDich = '05391311007'


	select 
				convert(varchar(8),Cida) as CIDA,
				AnnoMeseDenuncia,
				CodiceFiscaleAziendaDich,
				TipoRichiesta,
				CIDAPadre,
				CodiceIstatAzienda,
				CodiceProgressivoAzienda,
				case when len(TipoDitta1) = 1 then '0'+tipoditta1 else tipoditta1 end as TipoDitta1,
				case when len(TipoDitta2) = 1 then '0'+tipoditta2 else tipoditta2 end as TipoDitta2,
				Cognome,
				Nome,
				AziendaSomministratrice,
				ListaCIDACod,
				ListaCodAg,
				DenominazioneUrbanistica,
				Indirizzo,
				Civico,
				'' as Edificio,
				'' as Frazione,
				CodiceIstatResidenza,
				ProvinciaResidenza,
				CAPResidenza,
				ComuneResidenza,
				CodiceFiscaleAziendaSomm,
				CodiceIstatAziendaSomm,
				CodiceProgressivoAziendaSomm,
				case when len(TipoDitta1Somm) = 1 then '0'+TipoDitta1Somm else TipoDitta1Somm end as TipoDitta1Somm,
				case when len(TipoDitta2Somm) = 1 then '0'+TipoDitta2Somm else TipoDitta2Somm end as TipoDitta2Somm,
				Esito,
				MotivoErrore
		from #Temp_PosAgri

	-- Eliminazione della tabella temporanea
	DROP TABLE #Temp_PosAgri
END

---------------------------------
/****** Object:  StoredProcedure [dbo].[SP_DMAG_INS_RL]    Script Date: 02/07/2019 16:00:05 ******/
SET ANSI_NULLS ON
