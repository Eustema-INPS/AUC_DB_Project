-- ==================================================================================
-- Creata da:  Letizia Bellantoni
-- Data modifica:  2015.08.27
-- Description: 
-- Modificata da: Raffaele
-- Data modifica: 2015.09.27
-- Codificato lo stato della posizione (AI 1085)
-- Modificata da: Raffaele
-- Data modifica: 2015.11.12
-- Inserito un nuovo attributo: Presenza_procedure (al momento valorizzato costante a N) (AI 1087)
-- Eliminato la codifica dello stato della posizione della precedente modifica (AI 1085)
-- Modificata da: Raffaele
-- Data modifica: 2016.03.03
-- Inserita la chiamata alla procedura alla procedura AZ_GetProcedureConcorsualiEsterne 
-- Modificata da: Raffaele
-- Data modifica: 2016.11.02
-- Inseriti i due nuovi attributi relativi alle unità produttive e modificate le valorizzazioni
-- degli attributi relativi alle unità operative 
-- ==================================================================================
CREATE PROCEDURE [dbo].[EX_elenco_posizioni] @ListaPosizione as [dbo].[ElencoPosizioni] READONLY
AS
BEGIN
	SET NOCOUNT ON;
   

	create table #TempListaPosizione
	(
		Matricola	Varchar(50),
        Periodo_da	Datetime,
		Periodo_a	Datetime,
		CodiceFiscaleAzienda	Varchar(16),
		CSC	Varchar(5),
		Stringa_CA	Varchar(60),
		Data_inizio_attivita	Datetime,
		Data_Variazione_Stato	Datetime,
		Data_richiesta	Datetime,
		Sede_Competente	Varchar(4),
		Codice_stato	integer,
		Unita_operative	Varchar(max),
		Presenza_Sospensioni	Varchar(1),
		Presenza_UO	Varchar(1),
		Presenza_Procedure	Varchar(1),
		Unita_produttive Varchar(max),
		Presenza_UP	Varchar(1),
		Errore smallint,
		MotivoErrore Varchar(100)
	
)
    
	Insert into #TempListaPosizione
	(Matricola,
		Periodo_da,
		Periodo_a)
	SELECT Matricola,
		Periodo_da,
		Periodo_a
	FROM @ListaPosizione
    
	
	

	UPDATE 	#TempListaPosizione 
	SET 
	#TempListaPosizione.Errore= 2 , 
	#TempListaPosizione.MotivoErrore = 'Non trovato'


	UPDATE 	#TempListaPosizione 
	SET 
	     
		Matricola=A.aupoc_posizione,
		Periodo_da=#TempListaPosizione.Periodo_da,
		Periodo_a=#TempListaPosizione.Periodo_a,
	    CodiceFiscaleAzienda=ausca_codice_fiscale,	 
		CSC=aupco_cod_stat_contr ,
		Stringa_CA=aupco_codici_autor,
		Data_inizio_attivita=A.aupoc_data_inizio_attivita ,
        Data_Variazione_Stato=A.aupoc_data_ultimo_stato ,
		Data_richiesta=A.aupoc_data_domanda_iscr  ,
        Sede_Competente=ausin_codice_sede ,
		Codice_stato=auspc_codice ,

		Unita_operative  = dbo.fn_torna_stringaUnitaOp(A.Aupoc_codice_pk,#TempListaPosizione.Periodo_da,#TempListaPosizione.Periodo_a,'O'),
		Unita_produttive = dbo.fn_torna_stringaUnitaOp(A.Aupoc_codice_pk,#TempListaPosizione.Periodo_da,#TempListaPosizione.Periodo_a,'P'),

		Presenza_Sospensioni=dbo.fn_torna_PresenzaSosp(#TempListaPosizione.Periodo_da,#TempListaPosizione.Periodo_a,A.Aupoc_codice_pk),
		Presenza_UO=
		CASE WHEN EXISTS
			(select 1 from  tb_auuop_unita_operativa where  auuop_aupoc_codice_pk=A.aupoc_codice_pk
			and auuop_unita_operativa = 'S' and
			#TempListaPosizione.Periodo_da<=auuop_data_fine_accentr
			and #TempListaPosizione.Periodo_a>=auuop_data_inizio_accentr )
			then 'S'
			else 'N'
			END,
		Presenza_UP=
		CASE WHEN EXISTS
			(select 1 from  tb_auuop_unita_operativa where  auuop_aupoc_codice_pk=A.aupoc_codice_pk
			and auuop_unita_produttiva = 'S' and
			#TempListaPosizione.Periodo_da<=auuop_data_fine_accentr
			and #TempListaPosizione.Periodo_a>=auuop_data_inizio_accentr )
			then 'S'
			else 'N'
			END,

		Presenza_Procedure = 'N',
		Errore=0,
		MotivoErrore=''
		

	FROM tb_aupoc_pos_contr A

	INNER JOIN #TempListaPosizione  ON
	#TempListaPosizione.Matricola=A.aupoc_posizione

	INNER JOIN tb_ausca_sog_contr_az ON 
	tb_ausca_sog_contr_az.ausca_codice_pk=A.aupoc_ausca_codice_pk
	
		
	
-- CROSS APPLY (select top 1 aupco_cod_stat_contr,aupco_codici_autor  from tb_aupco_periodo_contr
	OUTER APPLY (select top 1 aupco_cod_stat_contr,aupco_codici_autor  from tb_aupco_periodo_contr
	where A.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk 
	AND
	#TempListaPosizione.Periodo_da<=aupco_data_fine_validita AND
	#TempListaPosizione.Periodo_a>=aupco_data_inizio_validita order by aupco_data_inizio_validita desc) AUPCO

	LEFT JOIN tb_ausin_sedi_inps_ct ON
	A.aupoc_ausin_codice_pk=tb_ausin_sedi_inps_ct.ausin_codice_pk
	
	INNER JOIN tb_auspc_stato_pos_contr_ct ON 
	A.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
		
	WHERE A.aupoc_aurea_codice_pk=1

-- Inizio (AI 1085)
-- update #TempListaPosizione
-- set Codice_stato = 0
-- where
-- 	codice_stato = 2 and
-- 	Periodo_da <= Data_Variazione_Stato and
-- 	Periodo_a >= Data_Variazione_Stato
-- Fine (AI 1085)

-- --Inizio gestione chiamata esterna
 	--DECLARE CURSORE_CALL Cursor
 	--FOR
  --  SELECT 		CodiceFiscaleAzienda, Matricola, Periodo_da, Periodo_a  FROM #TempListaPosizione 

  --  OPEN CURSORE_CALL 
 
  --  DECLARE @CodiceFiscaleAzienda Varchar(16)    
 	--DECLARE @Matricola VARCHAR(50)
 	--DECLARE @Periodo_da date
 	--DECLARE @Periodo_a date
 	--DECLARE @Ritorno char(1)

  --  FETCH NEXT FROM CURSORE_CALL INTO @CodiceFiscaleAzienda, @Matricola,@Periodo_da, @Periodo_a
 	--WHILE (@@FETCH_STATUS = 0)
 	--BEGIN
 	--	execute AZ_GetProcedureConcorsualiEsterne @CodiceFiscaleAzienda, @Matricola, @Periodo_da, @Periodo_a, @ritorno OUTPUT
 	--	if @ritorno <> 'N'
 	--	begin
 	--		update #TempListaPosizione
 	--		set Presenza_Procedure = @ritorno
 	--		where @CodiceFiscaleAzienda = CodiceFiscaleAzienda and
 	--			  @Matricola = substring(Matricola,1,10) and
 	--			  @Periodo_da = convert(date,Periodo_da,103) and
 	--			  @Periodo_a = convert(date,Periodo_a,103)
 	--	end
 	--	FETCH NEXT FROM CURSORE_CALL INTO @CodiceFiscaleAzienda, @Matricola,@Periodo_da, @Periodo_a
 	--END
 
 	--CLOSE CURSORE_CALL
 	--DEALLOCATE CURSORE_CALL

-- --Fine gestione chiamata esterna
	select * from #TempListaPosizione

END
