
CREATE PROCEDURE [dbo].[SP_Osiride_Start] 
AS
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @CodFisc VARCHAR(16)
	DECLARE @AuuloCodicePk BigInt
	
	-- Tracciatura LOG --
	--INSERT INTO [dbo].[tb_aulog_log]
	--       ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto] ,[aulog_nome_attore] ,[aulog_data_log] ,
	--	    [aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --    VALUES
 --          (0, 'B', 'OSIRIDE', Getdate(),
 --          '0', 'OSIRIDE- Produzione Output - [INIZIO] Elaborazione', Getdate(), 'AdminPlus' )

    TRUNCATE TABLE [dbo].[TB_AUT09_OSIRIDE_TR09] ;
	TRUNCATE TABLE [dbo].[TB_AUT99_OSIRIDE_LISTA_CARICHE] ;
	TRUNCATE TABLE [dbo].[TB_AUT99_OSIRIDE_OUT]	;

	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (1, 'B', 'OSIRIDE', Getdate(),'1','TR01_1', Getdate(), 'AdminPlus' )
	
	--Print '** Exec SP_Osiride_TR01_1_Gestione **'
	Exec SP_Osiride_TR01_1_Gestione	

	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (2, 'B', 'OSIRIDE', Getdate(),'2','TR08_1', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR08_1_Gestione **'
	Exec SP_Osiride_TR08_1_Gestione	
	
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (3, 'B', 'OSIRIDE', Getdate(),'3','TR09_1 (-> TR09_2_TrasponiCariche)', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR09_1_Gestione **'
	EXEC SP_Osiride_TR09_1_Gestione -- Al suo interno SP_Osiride_TR09_2_TrasponiCariche

	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (4, 'B', 'OSIRIDE', Getdate(),'4','TR10_1 (-> TR10_2_TrasponiCariche)', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR10_1_Gestione **'
	EXEC SP_Osiride_TR10_1_Gestione -- Al suo interno SP_Osiride_TR10_2_TrasponiCariche	

	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (5, 'B', 'OSIRIDE', Getdate(),'5','TR12_1 AUATA', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR12_1_Gestione_AUATA **'
	Exec SP_Osiride_TR12_1_Gestione_AUATA
	
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (6, 'B', 'OSIRIDE', Getdate(),'6','TR12_2 AUATU', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR12_2_Gestione_AUATU **'
	Exec SP_Osiride_TR12_2_Gestione_AUATU
   
   --INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
   -- VALUES (7, 'B', 'OSIRIDE', Getdate(),'7','TR12_3 UL0000', Getdate(), 'AdminPlus' ) 
	--Print '** Exec SP_Osiride_TR12_3_Gestione_UL0000 **'
	Exec SP_Osiride_TR12_3_Gestione_UL0000

	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (8, 'B', 'OSIRIDE', Getdate(),'8','TR12_4_UL', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR12_4_UL **'
	Exec SP_Osiride_TR12_4_UL
	
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (9, 'B', 'OSIRIDE', Getdate(),'9','TR13_1 AUARA', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR13_1_Gestione_AUARA  **'
	Exec SP_Osiride_TR13_1_Gestione_AUARA
	
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (10, 'B', 'OSIRIDE', Getdate(),'10','TR13_2 AUARU', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR13_2_Gestione_AUARU **'
	Exec SP_Osiride_TR13_2_Gestione_AUARU
		
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (11, 'B', 'OSIRIDE', Getdate(),'11','TR13_3 Popola_per_0000', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR13_3_Popola_per_0000 **'
	Exec SP_Osiride_TR13_3_Popola_per_0000
	
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (12, 'B', 'OSIRIDE', Getdate(),'12','TR13_4 Popola_per_auulo', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR13_4_Popola_per_auulo **'
	Exec SP_Osiride_TR13_4_Popola_per_auulo	
			
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (13, 'B', 'OSIRIDE', Getdate(),'13','TR14_1 Popola_per_0000', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR14_1_Popola_per_0000 **'
	Exec SP_Osiride_TR14_1_Popola_per_0000
	
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (14, 'B', 'OSIRIDE', Getdate(),'14','TR14_2 Popola_per_auulo', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR14_2_Popola_per_auulo **'
	Exec SP_Osiride_TR14_2_Popola_per_auulo	
	
	--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES (15, 'B', 'OSIRIDE', Getdate(),'15','Decl CF_Cursor', Getdate(), 'AdminPlus' )
	
	DECLARE CF_Cursor CURSOR READ_ONLY
	FOR
		SELECT AUT01_R1_COD_FISC_IMP FROM Dbo.TB_AUT01_OSIRIDE_TR01 
		OPEN CF_Cursor
		 
		--FETCH THE RECORD INTO THE VARIABLES.
		FETCH NEXT FROM CF_Cursor INTO  @CodFisc
 
		--LOOP UNTIL RECORDS ARE AVAILABLE.
		WHILE @@FETCH_STATUS = 0		
			BEGIN
				--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
				--VALUES (15, 'B', 'OSIRIDE', Getdate(),'15.1','FETCH CF_Cursor', Getdate(), 'AdminPlus' )

				--Print '** Exec SP_Osiride_TR01_2_Output **'
				EXEC SP_Osiride_TR01_2_Output @CodFisc 
			
				--Print '** Exec SP_Osiride_TR08_2_Output **'
				EXEC SP_Osiride_TR08_2_Output @CodFisc 							
				
				----Print '** Exec SP_Osiride_TR09_3_Output **'
				EXEC SP_Osiride_TR09_3_Output @CodFisc
			
				----Print '** Exec SP_Osiride_TR10_3_Output **'
				EXEC SP_Osiride_TR10_3_Output @CodFisc	
				
				--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
			 --   VALUES (1511, 'B', 'OSIRIDE', Getdate(),'15.1.1','Fine out ', Getdate(), 'AdminPlus' )
			
				----Print '** Exec SP_Osiride_TR12_5_TrasponiCodiciAteco - (2002) UL = 0000 **'
				EXEC SP_Osiride_TR12_5_TrasponiCodiciAteco @CodFisc				
		
				----Print '** Exec SP_Osiride_TR12_5_TrasponiCodiciAteco2007 - (2007) UL = 0000 **'
				EXEC SP_Osiride_TR12_5_TrasponiCodiciAteco2007 @CodFisc	

				----Print '** Exec SP_Osiride_TR12_51_TrasponiCodiciAteco (2002) UL **'
				EXEC SP_Osiride_TR12_51_TrasponiCodiciAteco @CodFisc				
		
				----Print '** Exec SP_Osiride_TR12_51_TrasponiCodiciAteco2007  (2007)  UL  **'
				EXEC SP_Osiride_TR12_51_TrasponiCodiciAteco2007 @CodFisc	
				
				--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
			 --   VALUES (1512, 'B', 'OSIRIDE', Getdate(),'15.1.2','Fine TrasponiCodiciAteco', Getdate(), 'AdminPlus' )

				----Print '** Exec SP_Osiride_TR12_52_ProgressivoUL  UL  **' -- Progressivo UL da Presentazione
				EXEC SP_Osiride_TR12_52_ProgressivoUL @CodFisc	

				--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
			 --   VALUES (1513, 'B', 'OSIRIDE', Getdate(),'15.1.3','Fine ProgressivoUL', Getdate(), 'AdminPlus' )


				UPDATE TB_AUT12_OSIRIDE_TR12
				SET AUT12_R12_PROGRESSIVO_NEW_UL = right(  '0000' + ltrim(rtrim(TB_AUT12_BIS.AUT12_R12_PROGRESSIVO_NEW_UL)) ,4)
				FROM TB_AUT12_BIS INNER JOIN TB_AUT12_OSIRIDE_TR12 ON 
					TB_AUT12_BIS.aut12_r12_codice_fiscale = TB_AUT12_OSIRIDE_TR12.aut12_r12_codice_fiscale 
				AND TB_AUT12_BIS.aut12_r12_auulo_codice_pk = TB_AUT12_OSIRIDE_TR12.aut12_r12_auulo_codice_pk					
				WHERE TB_AUT12_OSIRIDE_TR12.aut12_r12_codice_fiscale = @CodFisc 

				----Print '** Exec SP_Osiride_TR12_6_Output_000 **'
				EXEC SP_Osiride_TR12_6_Output_000 @CodFisc	
			
				----Print '** Exec SP_Osiride_TR13_5_Output **'
				EXEC SP_Osiride_TR13_5_Output_000 @CodFisc
			
				--Print '** Exec SP_Osiride_TR14_3_Output_000 **'
				EXEC SP_Osiride_TR14_3_Output_000 @CodFisc			
			
				--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
			 --   VALUES (16, 'B', 'OSIRIDE', Getdate(),'15.2','Decl UL_Cursor ', Getdate(), 'AdminPlus' )
				
				DECLARE UL_Cursor CURSOR READ_ONLY FOR	
						
				SELECT AUT12_R12_AUULO_CODICE_PK
				FROM [AUC].[dbo].[TB_AUT12_OSIRIDE_TR12]
				WHERE [AUT12_R12_CODICE_FISCALE] = @CodFisc
				AND AUT12_R12_AUULO_CODICE_PK is not null
				ORDER BY [AUT12_R12_PROGRESSIVO_UL] ASC

				OPEN UL_Cursor
				FETCH NEXT FROM UL_Cursor INTO  @AuuloCodicePk
					
				WHILE @@FETCH_STATUS = 0
					BEGIN
						--Print '** Exec SP_Osiride_TR12_7_Output **'
						EXEC SP_Osiride_TR12_7_Output @CodFisc, @AuuloCodicePk						
						
						--Print '** Exec SP_Osiride_TR13_6_Output **'
						EXEC SP_Osiride_TR13_6_Output @CodFisc, @AuuloCodicePk
						
						--Print '** Exec SP_Osiride_TR14_4_Output **'
						EXEC SP_Osiride_TR14_4_Output @CodFisc, @AuuloCodicePk
						
						--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
						--VALUES (156, 'B', 'OSIRIDE', Getdate(),'15.2.1','FETCH UL_Cursor', Getdate(), 'AdminPlus' )
																				
						FETCH NEXT FROM UL_Cursor INTO  @AuuloCodicePk
					END
					
				CLOSE UL_Cursor
				DEALLOCATE UL_Cursor			
				
				--INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
				--VALUES (15, 'B', 'OSIRIDE', Getdate(),'15.3','FETCH NEXT FROM CF_Cursor', Getdate(), 'AdminPlus' )

				FETCH NEXT FROM CF_Cursor INTO  @CodFisc
			END
		
		CLOSE CF_Cursor
		DEALLOCATE CF_Cursor

		-- 2018 07 04
		-- Accodamento dello Storico Giornaliero Osiride tabella 	[dbo].[TB_AUSGO_STORICO_GIORNALIERO_OSIRIDE]
		EXEC SP_Osiride_AUSGO_StoricoGiornalieroOsiride ;
			
	
	--INSERT INTO [dbo].[tb_aulog_log]
	--       ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto] ,[aulog_nome_attore] ,[aulog_data_log] ,
	--	    [aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
 --   VALUES
 --          (0, 'B', 'OSIRIDE', Getdate(),
	--	    '99', 'OSIRIDE- Produzione Output - [FINE] Elaborazione', Getdate(), 'AdminPlus')
END

