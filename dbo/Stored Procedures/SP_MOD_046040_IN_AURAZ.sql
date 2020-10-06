

-- ===============================================================================================
-- Author:		Stefano Chiovelli
-- Create date: 10/04/2019
-- La Stored inserisce nella Tabella tb_auraz_report_azst il risultato della query su tb_autaz_tazstat (copia di DB2.TAZSTAT)
-- Per il Modello 046040
-- ===============================================================================================
CREATE PROCEDURE [dbo].[SP_MOD_046040_IN_AURAZ] 
	@DtInizio date, 
	@DtFine date
	AS
BEGIN

	SET NOCOUNT ON;
	
	BEGIN
	
		declare @codiceModello as varchar(10);
		set @codiceModello='046040';
		
		declare @dataModifica as datetime;
		set @dataModifica=getdate();
		
		declare @descrUtente as varchar(25);
		set @descrUtente='SP_MOD_046040_IN_AURAZ';
	
		INSERT INTO [dbo].[tb_auraz_report_azst] 
			(auraz_codice_modello,
			 auraz_azregion,
			 auraz_azstapro,
			 auraz_azstazon,
			 auraz_gi,
			 auraz_perv1,
			 auraz_perv2,
			 auraz_defa,
			 auraz_defr1,
			 auraz_defr2,
			 auraz_data_modifica,
			 auraz_descr_utente,
			 Auraz_stato,
			 Auraz_data_inizio,
			 Auraz_data_fine)
			SELECT @codiceModello, 0, autaz_azstapro, autaz_azstazon --'046040'
			  , 0, 0, 0  				
			  , SUM (CASE WHEN autaz_azcodopr = '05' AND autaz_azproven IN (2, 4) AND autaz_azflagop = 1 
					THEN 1 ELSE 0 END) DEFA         
			  , SUM (CASE WHEN autaz_azcodopr = '05' AND autaz_azproven IN (0, 1)                            
					THEN 1 ELSE 0 END) DEFR1                   
			  , SUM (CASE WHEN autaz_azcodopr = '05' AND autaz_azproven IN (2, 4) AND autaz_azflagop = 2  
					THEN 1 ELSE 0 END) DEFR2        
			  , @dataModifica
			  , @descrUtente
			  , 0
			  , @DtInizio
			  , @DtFine	
			FROM tb_autaz_tazstat                                                           
			WHERE Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine
			GROUP BY autaz_azstapro, autaz_azstazon
			
		UPDATE 	[dbo].[tb_auraz_report_azst] 
		SET auraz_perv1 = (auraz_defa + auraz_defr1 + auraz_defr2)
		WHERE auraz_codice_modello = '046040' and auraz_stato = 0

	-- Inserisce le sedi mancanti
		create table #temp(ausin varchar(4), reg int, pro int, zon int, presente char(1)) on [primary]

		insert into #temp (ausin, presente, reg, pro, zon)
		SELECT ausin_codice_sede, 'N', ausin_codice_regione, convert(int,(substring(ausin_codice_sede,1,2))), convert(int,(substring(ausin_codice_sede,3,2)))  FROM TB_AUSIN_sedi_inps_ct
		where ausin_codice_pk_db2 = 1

		create table #temp2(pro2 int, zon2 int, presente char(1)) on [primary]

		insert into #temp2 (pro2, zon2, presente)
		SELECT [auraz_azstapro]
			  ,[auraz_azstazon]
			  ,'N'
		  FROM [AUC].[dbo].[tb_auraz_report_azst]
		  where [auraz_codice_modello] = '046040' and auraz_stato = 0
		  group by       [auraz_azstapro], [auraz_azstazon]

		update #temp
		set #temp.presente = 'S'
		from #temp inner join #temp2 on pro = pro2 and zon = zon2

		INSERT INTO [dbo].[tb_auraz_report_azst]
					(auraz_codice_modello,
					 auraz_azregion,
					 auraz_azstapro,
					 auraz_azstazon,
					 auraz_gi, auraz_perv1, auraz_perv2, auraz_defa, auraz_defr1, auraz_defr2,
					 auraz_data_modifica, auraz_descr_utente,
					 Auraz_stato,
					 Auraz_data_inizio,
					 Auraz_data_fine)
		select	'046040', 
				0,
				pro,
				zon,
				0,0,0,0,0,0,
				getdate(), 'Ins fittizio',
				0,
				@DtInizio,
				@DtFine
				from #temp where presente = 'N'					
	END
	
	IF @@ERROR = 0 	RETURN 0 ELSE RETURN 100

END

