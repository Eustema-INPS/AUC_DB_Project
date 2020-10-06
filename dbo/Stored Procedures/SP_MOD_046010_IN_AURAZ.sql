

-- ===============================================================================================
-- Author:		Stefano Chiovelli
-- Create date: 10/04/2019
-- La Stored inserisce nella Tabella tb_auraz_report_azst il risultato della query su tb_autaz_tazstat (copia di DB2.TAZSTAT)
-- Per il Modello 046010
-- Modificata il 2019-09-27 da Raffaele
-- Inserito il calcolo della giacenza effettuato tramite la funzione [fn_torna_Giacenza]
-- Modificata il 2019-10-16 da Raffaele
-- Inserita la valorizzazione delle giacenze per i dati di gennaio 2019
-- Inserita la normalizzazione delle giacenze per i mesi successivi
-- ===============================================================================================
CREATE PROCEDURE [dbo].[SP_MOD_046010_IN_AURAZ] 
	@DtInizio date, 
	@DtFine date
	AS
BEGIN

	SET NOCOUNT ON;
	
	BEGIN
	
		declare @codiceModello as varchar(10);
		set @codiceModello='046010';
		
		declare @dataModifica as datetime;
		set @dataModifica=getdate();
		
		declare @descrUtente as varchar(25);
		set @descrUtente='SP_MOD_046010_IN_AURAZ';
	
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
			SELECT @codiceModello, 0, autaz_azstapro, autaz_azstazon                               
				, SUM(GI) GI, SUM(PERV1) PERV1                      
				, SUM(PERV2) PERV2, SUM(DEFA) DEFA                  
				, SUM(DEFR1) DEFR1, SUM(DEFR2) DEFR2
				, @dataModifica
				, @descrUtente
				, 0
				, @DtInizio
				, @DtFine
			FROM   

			(
				SELECT  autaz_azstapro, autaz_azstazon,
									0 GI                                               
								   , COUNT (*) PERV1                                      	
								   , 0 PERV2                                            
								   , 0 DEFA                                             
								   , 0 DEFR1                                            
								   , 0 DEFR2  
				FROM tb_autaz_tazstat
				WHERE autaz_azcodopr ='01' AND autaz_azproven IN (2, 4)                
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine
				GROUP BY autaz_azstapro, autaz_azstazon

				UNION ALL

				SELECT  autaz_azstapro, autaz_azstazon,
								   0 GI                                               
								   , COUNT (*) PERV1                                     
								   , 0 PERV2                                            
								   , 0 DEFA                                             
								   , 0 DEFR1                                            
								   , 0 DEFR2  
				FROM tb_autaz_tazstat A
				WHERE autaz_azcodopr IN ('0', '03')                              
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine          
					AND EXISTS 
					(SELECT 1 FROM tb_autaz_tazstat B                      
					WHERE A.autaz_azstapro=B.autaz_azstapro                              
						AND A.autaz_azstazon <> B.autaz_azstazon                            
						AND A.autaz_azstaazi=B.autaz_azstaazi                               
						AND A.autaz_azstacod=B.autaz_azstacod AND A.autaz_azcodopr ='01'
						AND Convert(Date,B.autaz_azdatopr) BETWEEN @DtInizio AND @DtFine)           
				GROUP BY autaz_azstapro, autaz_azstazon

				UNION ALL

				SELECT  autaz_azstapro, autaz_azstazon,
								   0 GI                                               
								   , COUNT (*) PERV1                                     
								   , 0 PERV2                                            
								   , 0 DEFA                                             
								   , 0 DEFR1                                            
								   , 0 DEFR2  
				FROM tb_autaz_tazstat A
				WHERE autaz_azcodopr= '03'                                     
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine       
					AND EXISTS 
					(SELECT 1 FROM tb_autaz_tazstat B                      
					WHERE A.autaz_azstapro=B.autaz_azstapro                               
						AND A.autaz_azstazon = B.autaz_azstazon                            
						AND A.autaz_azstaazi=B.autaz_azstaazi                               
						AND A.autaz_azstacod=B.autaz_azstacod AND A.autaz_azcodopr ='0'
						AND Convert(Date,B.autaz_azdatopr) BETWEEN @DtInizio AND @DtFine)   
				GROUP BY autaz_azstapro, autaz_azstazon

				UNION ALL

				SELECT  autaz_azstapro, autaz_azstazon,
								   0 GI                                               
								   , COUNT (*) PERV1                                     
								   , 0 PERV2                                            
								   , 0 DEFA                                             
								   , 0 DEFR1                                            
								   , 0 DEFR2  
				FROM tb_autaz_tazstat A
				WHERE autaz_azcodopr= '0'                                       
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine     
					AND EXISTS 
					(SELECT 1 FROM tb_autaz_tazstat B                      
					WHERE A.autaz_azstapro=B.autaz_azstapro                               
						AND A.autaz_azstazon = B.autaz_azstazon                             
						AND A.autaz_azstaazi=B.autaz_azstaazi                               
						AND A.autaz_azstacod=B.autaz_azstacod                               
						AND A.autaz_azoraopr <> B.autaz_azoraopr AND A.autaz_azcodopr ='0'
						AND Convert(Date,B.autaz_azdatopr) BETWEEN @DtInizio AND @DtFine)  
				GROUP BY autaz_azstapro, autaz_azstazon

				UNION ALL

				SELECT  autaz_azstapro, autaz_azstazon, 
								   0 GI                                               
								   , 0 PERV1                                           
								   , COUNT (*) PERV2                                   
								   , 0 DEFA                                          
								   , 0 DEFR1                                            
								   , 0 DEFR2 
				FROM tb_autaz_tazstat A
				WHERE autaz_azcodopr ='01' AND autaz_azproven IN (0, 1)               
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine   
				GROUP BY autaz_azstapro, autaz_azstazon

				UNION ALL

				SELECT  autaz_azstapro, autaz_azstazon,
								   0 GI                                             
								   , 0 PERV1                                            
								   , 0 PERV2                                            
								   , COUNT (*) DEFA                                     
								   , 0 DEFR1                                            
								   , 0 DEFR2
				FROM tb_autaz_tazstat A
				WHERE autaz_azcodopr ='03'                                     
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine  
					AND EXISTS 
					(SELECT 1 FROM tb_autaz_tazstat B                      
					WHERE A.autaz_azstapro=B.autaz_azstapro                               
						AND A.autaz_azstazon=B.autaz_azstazon                               
						AND A.autaz_azstaazi=B.autaz_azstaazi                               
						AND A.autaz_azstacod=B.autaz_azstacod                               
						AND A.autaz_azcodopr ='01' AND A.autaz_azproven IN (2, 4)
						AND Convert(Date,B.autaz_azdatopr) BETWEEN @DtInizio AND @DtFine)
				GROUP BY autaz_azstapro, autaz_azstazon

				UNION ALL

				SELECT  autaz_azstapro, autaz_azstazon,
								   0 GI                                             
								   , 0 PERV1                                            
								   , 0 PERV2                                            
								   , COUNT (*) DEFA                                     
								   , 0 DEFR1                                            
								   , 0 DEFR2
				FROM tb_autaz_tazstat A
				WHERE autaz_azcodopr ='03'                                      
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine  
					AND NOT EXISTS 
					(SELECT 1 FROM tb_autaz_tazstat B                  
					WHERE A.autaz_azstapro=B.autaz_azstapro                               
						AND A.autaz_azstazon=B.autaz_azstazon                               
						AND A.autaz_azstaazi=B.autaz_azstaazi                               
						AND A.autaz_azstacod=B.autaz_azstacod AND A.autaz_azcodopr ='01'
						AND Convert(Date,B.autaz_azdatopr) BETWEEN @DtInizio AND @DtFine)
				GROUP BY autaz_azstapro, autaz_azstazon

				UNION ALL

				SELECT  autaz_azstapro, autaz_azstazon,
								   0 GI                                              
								   , 0 PERV1                                            
								   , 0 PERV2                                            
								   , 0 DEFA                                             
								   , COUNT (*) DEFR1                                     
								   , 0 DEFR2
				FROM tb_autaz_tazstat A
				WHERE autaz_azcodopr ='03'                                      
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine
					AND EXISTS 
					(SELECT 1 FROM tb_autaz_tazstat B                     
					WHERE A.autaz_azstapro=B.autaz_azstapro                             
						AND A.autaz_azstazon=B.autaz_azstazon                              
						AND A.autaz_azstaazi=B.autaz_azstaazi                              
						AND A.autaz_azstacod=B.autaz_azstacod                               
						AND A.autaz_azcodopr ='01' AND A.autaz_azproven IN (0, 1)
						AND Convert(Date,B.autaz_azdatopr) BETWEEN @DtInizio AND @DtFine)
				GROUP BY autaz_azstapro, autaz_azstazon

				UNION ALL

				SELECT  autaz_azstapro, autaz_azstazon,
								   0 GI                                              
								   , 0 PERV1                                           
								   , 0 PERV2                                           
								   , 0 DEFA                                            
								   , 0 DEFR1                                            
								   , COUNT (*) DEFR2
				FROM tb_autaz_tazstat A
				WHERE autaz_azcodopr ='0'                                      
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine  
				GROUP BY autaz_azstapro, autaz_azstazon

				UNION ALL

				SELECT  autaz_azstapro, autaz_azstazon,
								   0 GI                                              
								   , 0 PERV1                                           
								   , 0 PERV2                                           
								   , 0 DEFA                                            
								   , 0 DEFR1                                            
								   , COUNT (*) DEFR2
				FROM tb_autaz_tazstat A
				WHERE autaz_azcodopr ='01'                                      
					AND Convert(Date,autaz_azdatopr) BETWEEN @DtInizio AND @DtFine
					AND EXISTS 
					(SELECT 1 FROM tb_autaz_tazstat B                     
					WHERE A.autaz_azstapro=B.autaz_azstapro                               
						AND A.autaz_azstazon <> B.autaz_azstazon                            
						AND A.autaz_azstaazi=B.autaz_azstaazi                               
						AND A.autaz_azstacod=B.autaz_azstacod                               
						AND A.autaz_azcodopr IN ('0', '03')
						AND Convert(Date,B.autaz_azdatopr) BETWEEN @DtInizio AND @DtFine)
				GROUP BY autaz_azstapro, autaz_azstazon
			)
			AS AZISCR
			GROUP BY autaz_azstapro, autaz_azstazon
			ORDER BY 1, 2, 3 
		
	END

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
		  where [auraz_codice_modello] = '046010' and auraz_stato = 0
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
		select	'046010', 
				0,
				pro,
				zon,
				0,0,0,0,0,0,
				getdate(), 'Ins fittizio',
				0,
				@DtInizio,
				@DtFine
				from #temp where presente = 'N'


	--Aggiornamento giacenza
	declare @DataMesePrec date
	set @DataMesePrec = dateadd(month, -1, @DtInizio)
	Declare Cursore_046010 Cursor
	For
			-- Seleziona il record valido da elaborare
			select [auraz_azregion], [auraz_azstapro],[auraz_azstazon] FROM [AUC].[dbo].[tb_auraz_report_azst]
			where auraz_codice_modello = '046010'
			and [Auraz_data_inizio] = @DtInizio
			and auraz_stato = 0
			Open Cursore_046010
			    DECLARE @azregion int    
				DECLARE @azstapro int
				DECLARE @azstazon int

			    FETCH NEXT FROM Cursore_046010 INTO @azregion, @azstapro, @azstazon
				WHILE (@@FETCH_STATUS = 0)		
				BEGIN
					update [dbo].[tb_auraz_report_azst]
					set auraz_gi =  dbo.fn_torna_Giacenza(@azregion, @azstapro, @azstazon, @DataMesePrec)
					where auraz_codice_modello = '046010'
					and [Auraz_data_inizio] = @DtInizio
					and [auraz_azregion] = @azregion
					and [auraz_azstapro] = @azstapro
					and [auraz_azstazon] = @azstazon
					and auraz_stato = 0
					FETCH NEXT FROM Cursore_046010 INTO @azregion, @azstapro, @azstazon
				END
			CLOSE Cursore_046010
	DEALLOCATE Cursore_046010

	--Inserimento giacenza prelevata da fonte esterna valida solo per i dati di gennaio 2019 per i quali il calcolo della giacenza precedente non può aver effetto
	--in quanto non esistono dati precedenti a gennaio 2019
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '1' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '1' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '4' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '5' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '6' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '7' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '8' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =10 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '9' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '10' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =6 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '12' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =8 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '13' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '13' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '14' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =4 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '15' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =6 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '16' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '17' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '17' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '18' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '19' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =4 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '20' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =5 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '20' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =7 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '21' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '22' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '22' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =16 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '22' and auraz_azstazon = '2'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '22' and auraz_azstazon = '3'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =37 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '23' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '24' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '25' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '25' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '26' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '27' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '29' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =31 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '30' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '30' and auraz_azstazon = '90'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '31' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '32' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '32' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =5 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '34' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '34' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '38' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '38' and auraz_azstazon = '2'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =4 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '40' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '41' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '41' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '42' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '42' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '43' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '46' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '47' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =5 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '48' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =43 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '49' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =7 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '49' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =5 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '49' and auraz_azstazon = '2'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =15 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '49' and auraz_azstazon = '3'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =4 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '49' and auraz_azstazon = '5'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '49' and auraz_azstazon = '27'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =5 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '50' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '51' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =24 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '51' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =9 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '51' and auraz_azstazon = '2'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =44 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '51' and auraz_azstazon = '4'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =68 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '51' and auraz_azstazon = '5'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =178 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '51' and auraz_azstazon = '6'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =4 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '54' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =4 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '55' and auraz_azstazon = '2'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =13 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '58' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =5 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '59' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =16 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '60' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '61' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =8 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '62' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =17 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '64' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '65' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =7 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '66' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '67' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =5 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '68' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '69' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =11 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '72' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '72' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =10 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '72' and auraz_azstazon = '2'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '74' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =153 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =4 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =112 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '2'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =6 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '3'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '4'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =13 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '6'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =64 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '9'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =34 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '10'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =10 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '12'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '75' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '77' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =11 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '78' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '79' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =9 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '81' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '81' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '81' and auraz_azstazon = '2'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '81' and auraz_azstazon = '3'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '81' and auraz_azstazon = '5'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '81' and auraz_azstazon = '6'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '83' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '84' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '86' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '87' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '88' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '88' and auraz_azstazon = '94'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '88' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '89' and auraz_azstazon = '1'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =14 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '90' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =3 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '93' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '94' and auraz_azstazon = '0'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =8 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '13'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =1 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '91'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =34 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '14'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =2 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '70' and auraz_azstazon = '15'
Update [AUC].[dbo].[tb_auraz_report_azst] set auraz_gi =10 where auraz_stato = 0 and auraz_codice_modello = '046010' and auraz_data_inizio = '2019-01-01' and auraz_azstapro = '49' and auraz_azstazon = '55'

	-- Ricalcola la giacenza nel caso in cui risulti negativa solo per i dati ancora da inviare
	  --update [AUC].[dbo].[tb_auraz_report_azst]
	  ----set auraz_gi = -([auraz_perv1] + [auraz_perv2] - [auraz_defa] - [auraz_defr1] - [auraz_defr2] + auraz_gi)
	  --set auraz_gi = 0
	  --where [auraz_codice_modello] = '046010' and
	  --([auraz_perv1] + [auraz_perv2] - [auraz_defa] - [auraz_defr1] - [auraz_defr2] + auraz_gi) < 0
	  --and auraz_stato = 0


	IF @@ERROR = 0 	RETURN 0 ELSE RETURN 100

END


