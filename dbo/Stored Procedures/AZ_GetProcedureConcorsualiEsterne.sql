



-- ===============================================================================================
-- Author:		Palmieri
-- Create date: 25/02/2016
-- Description:	Esegue la chiamata alla stored esterna SP_PC_GetProcedureConcorsuali_AUC, per avere i
--				dati base relativi alle procedure concorsuali in carico al Recupero Crediti.
--				La stored è richiamata dalla stored [EX_elenco_posizioni] che fornisce i dati a Uniemens. 
-- ===============================================================================================
CREATE PROCEDURE [dbo].[AZ_GetProcedureConcorsualiEsterne] 
	@cf varchar(16),	      -- cf azienda
	@posizione varchar(50),	  -- posizione
	@dataInizio date,  -- data inizio periodo
	@dataFine date,    -- data fine periodo
	@parametro char(1) OUTPUT -- parametro di ritorno
AS
BEGIN

	SET NOCOUNT ON;
	
		DECLARE @esecuzione as varchar(100)
		declare @tipoProcedura as varchar(100)
	    declare @dataInizioPC as date
		declare @dataFinePC as date
		declare @RitornoInBonis as int
		declare @esercizioProvvisorio as Int
		declare @matricolaEP as varchar(10)
		declare @dataInizioEP as date
		declare @dataFineEP as date
		declare @ritorno as int = 0
		
-- Acquisizione del parametro di puntamento al db dove risiede la stored		
		SELECT @esecuzione = ausys_valore
		FROM   dbo.tb_ausys_sistema
		WHERE (ausys_parametro = 'AUC_NRC')

		--set @cf = '00420400582'
		--set @dataFine = '2016-02-29'
		set @esecuzione += 'SP_PC_GetProcedureConcorsuali_AUC'
		create table #temp_nrc (
			tipoProcedura varchar(100),
			dataInizioPC date,
			dataFinePC date,
			RitornoInBonis int,
			esercizioProvvisorio Int,
			matricolaEsProv varchar(10),
			dataInizioEP date,
			dataFineEP date
		)
 --drop table #temp_nrc
		insert into #temp_nrc 
		EXEC @esecuzione @cf, @dataFine
--		execute [SQLINPSSVIL15\SQL15].AnagrProCon.dbo.SP_PC_GetProcedureConcorsuali_AUC '00112780820', '2016-02-29'
--select * from #temp_nrc
(select @tipoprocedura = tipoProcedura, 
		@RitornoInBonis = RitornoInBonis,
		@dataInizioPC = dataInizioPC, 
		@esercizioProvvisorio = esercizioProvvisorio,
		@matricolaEP = matricolaEsProv,
		@dataInizioEP = dataInizioEP,
		@dataFineEP = dataFineEP
		from #temp_nrc)
--print @tipoprocedura
--PRINT 'bonis '+convert(varchar(10),@RitornoInBonis)
--PRINT 'datafine '+ convert(varchar(50),@dataInizioPC)
--PRINT 'EP '+convert(varchar(10),@esercizioProvvisorio)
--PRINT 'Data inizio EP '+convert(varchar(50),@dataInizioEP)

		if @esercizioProvvisorio = 1 and @posizione <> @matricolaEP
		 set @esercizioProvvisorio = 0

--PRINT 'EP mod '+convert(varchar(10),@esercizioProvvisorio)

		if @tipoProcedura is null
		begin
			set @ritorno = 0 -- Via Libera
			set @parametro = 'N' -- Via Libera
			goto fine
		end

		if @tipoProcedura = 'Amministrazione Straordinaria'
		begin
			set @ritorno = 0 -- Via Libera
			set @parametro = 'N' -- Via Libera
			goto fine
		end

		if @RitornoInBonis = 1
		begin
			set @ritorno = 0 -- Via Libera
			set @parametro = 'N' -- Via Libera
			goto fine
		end

		if @esercizioProvvisorio <> 1 AND @dataInizio >= @dataInizioPC   
		begin
			set @ritorno = 1 -- Blocco
			set @parametro = 'B' -- Via Libera
			goto fine
		end
		if @esercizioProvvisorio <> 1 AND @dataInizio < @dataInizioPC   
		begin
			set @ritorno = 2 -- Alert
			set @parametro = 'A' -- Via Libera
			goto fine
		end

		if @esercizioProvvisorio = 1 AND (
		(@dataInizio < @dataFineEP and @dataFine < @dataFineEP and @dataInizio < @dataInizioEP and @dataFine < @dataInizioEP) or
		(@dataInizio > @dataFineEP and @dataFine > @dataFineEP and @dataInizio > @dataInizioEP and @dataFine > @dataInizioEP) )
		begin
			set @ritorno = 1 -- Blocco
			set @parametro = 'B' -- Via Libera
			goto fine
		end
		else
--		if @esercizioProvvisorio = 1 AND @dataInizio < @dataInizioEP 
		begin
			set @ritorno = 0 -- Via Libera
			set @parametro = 'N' -- Via Libera
			goto fine
		end

fine:
	IF @@ERROR = 0
		RETURN 0
	ELSE
		RETURN 100


END




