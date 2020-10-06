

CREATE PROCEDURE [dbo].[SP_Osiride_Start_RAF] 
AS
BEGIN
	SET NOCOUNT ON;
		
	DECLARE @CodFisc VARCHAR(16)
	DECLARE @AuuloCodicePk BigInt
	
	-- Tracciatura LOG --
	INSERT INTO [dbo].[tb_aulog_log]
	       ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto] ,[aulog_nome_attore] ,[aulog_data_log] ,
		    [aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
     VALUES
           (0, 'B', 'OSIRIDE', Getdate(),
           'OSIRIDE - (INIZIO)', 'OSIRIDE- Produzione Output - [INIZIO] Elaborazione', Getdate(), 'AdminPlus' )

    TRUNCATE TABLE [dbo].[TB_AUT09_OSIRIDE_TR09] ;
	TRUNCATE TABLE [dbo].[TB_AUT99_OSIRIDE_LISTA_CARICHE] ;
	TRUNCATE TABLE [dbo].[TB_AUT99_OSIRIDE_OUT]	;

	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (1, 'B', 'OSIRIDE', Getdate(),'Exec SP_Osiride_TR01_1_Gestione','Exec SP_Osiride_TR01_1_Gestione', Getdate(), 'AdminPlus' )
	
	--Print '** Exec SP_Osiride_TR01_1_Gestione **'
	Exec SP_Osiride_TR01_1_Gestione	

	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (2, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR08_1_Gestione','SP_Osiride_TR08_1_Gestione', Getdate(), 'AdminPlus' )
	
	--Print '** Exec SP_Osiride_TR08_1_Gestione **'
	Exec SP_Osiride_TR08_1_Gestione	
	
	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (3, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR09_1_Gestione','SP_Osiride_TR09_1_Gestione', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR09_1_Gestione **'
	EXEC SP_Osiride_TR09_1_Gestione -- Al suo interno SP_Osiride_TR09_2_TrasponiCariche

	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (4, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR10_1_Gestione','SP_Osiride_TR10_1_Gestione', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR10_1_Gestione **'
	EXEC SP_Osiride_TR10_1_Gestione -- Al suo interno SP_Osiride_TR10_2_TrasponiCariche	

	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (5, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR12_1_Gestione_AUATA','SP_Osiride_TR12_1_Gestione_AUATA', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR12_1_Gestione_AUATA **'
	Exec SP_Osiride_TR12_1_Gestione_AUATA
	
	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (6, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR12_2_Gestione_AUATU','SP_Osiride_TR12_2_Gestione_AUATU', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR12_2_Gestione_AUATU **'
	Exec SP_Osiride_TR12_2_Gestione_AUATU
   
   INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (7, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR12_3_Gestione_UL0000','SP_Osiride_TR12_3_Gestione_UL0000', Getdate(), 'AdminPlus' ) 
	--Print '** Exec SP_Osiride_TR12_3_Gestione_UL0000 **'
	Exec SP_Osiride_TR12_3_Gestione_UL0000

	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (8, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR12_4_UL','SP_Osiride_TR12_4_UL', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR12_4_UL **'
	Exec SP_Osiride_TR12_4_UL
	
	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (9, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR13_1_Gestione_AUARA','SP_Osiride_TR13_1_Gestione_AUARA', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR13_1_Gestione_AUARA  **'
	Exec SP_Osiride_TR13_1_Gestione_AUARA
	
	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (10, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR13_2_Gestione_AUARU','SP_Osiride_TR13_2_Gestione_AUARU', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR13_2_Gestione_AUARU **'
	Exec SP_Osiride_TR13_2_Gestione_AUARU
		
	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (11, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR13_3_Popola_per_0000','SP_Osiride_TR13_3_Popola_per_0000', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR13_3_Popola_per_0000 **'
	Exec SP_Osiride_TR13_3_Popola_per_0000
	
	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (12, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR13_4_Popola_per_auulo','SP_Osiride_TR13_4_Popola_per_auulo', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR13_4_Popola_per_auulo **'
	Exec SP_Osiride_TR13_4_Popola_per_auulo	
	
		
	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (13, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR14_1_Popola_per_0000','SP_Osiride_TR14_1_Popola_per_0000', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR14_1_Popola_per_0000 **'
	Exec SP_Osiride_TR14_1_Popola_per_0000
	
	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (14, 'B', 'OSIRIDE', Getdate(),'SP_Osiride_TR14_2_Popola_per_auulo','SP_Osiride_TR14_2_Popola_per_auulo', Getdate(), 'AdminPlus' )
	--Print '** Exec SP_Osiride_TR14_2_Popola_per_auulo **'
	Exec SP_Osiride_TR14_2_Popola_per_auulo	
	
	INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES (15, 'B', 'OSIRIDE', Getdate(),'DECLARE CF_Cursor','DECLARE CF_Cursor', Getdate(), 'AdminPlus' )
	
	DECLARE CF_Cursor CURSOR READ_ONLY
	FOR
		SELECT AUT01_R1_COD_FISC_IMP FROM Dbo.TB_AUT01_OSIRIDE_TR01 
		OPEN CF_Cursor
		 
		--FETCH THE RECORD INTO THE VARIABLES.
		FETCH NEXT FROM CF_Cursor INTO  @CodFisc
 
		--LOOP UNTIL RECORDS ARE AVAILABLE.
		WHILE @@FETCH_STATUS = 0		
			BEGIN
				--Print '** Exec SP_Osiride_TR01_2_Output **'
				EXEC SP_Osiride_TR01_2_Output @CodFisc 
			
				--Print '** Exec SP_Osiride_TR08_2_Output **'
				EXEC SP_Osiride_TR08_2_Output @CodFisc 							
				
				----Print '** Exec SP_Osiride_TR09_3_Output **'
				EXEC SP_Osiride_TR09_3_Output @CodFisc
			
				----Print '** Exec SP_Osiride_TR10_3_Output **'
				EXEC SP_Osiride_TR10_3_Output @CodFisc	
			
				----Print '** Exec SP_Osiride_TR12_5_TrasponiCodiciAteco - (2002) UL = 0000 **'
				EXEC SP_Osiride_TR12_5_TrasponiCodiciAteco @CodFisc				
		
				----Print '** Exec SP_Osiride_TR12_5_TrasponiCodiciAteco2007 - (2007) UL = 0000 **'
				EXEC SP_Osiride_TR12_5_TrasponiCodiciAteco2007 @CodFisc	

				----Print '** Exec SP_Osiride_TR12_51_TrasponiCodiciAteco (2002) UL **'
				EXEC SP_Osiride_TR12_51_TrasponiCodiciAteco @CodFisc				
		
				----Print '** Exec SP_Osiride_TR12_51_TrasponiCodiciAteco2007  (2007)  UL  **'
				EXEC SP_Osiride_TR12_51_TrasponiCodiciAteco2007 @CodFisc	
			
				----Print '** Exec SP_Osiride_TR12_52_ProgressivoUL  UL  **' -- Progressivo UL da Presentazione
				EXEC SP_Osiride_TR12_52_ProgressivoUL @CodFisc	

				--UPDATE TB_AUT12_OSIRIDE_TR12
				--SET AUT12_R12_PROGRESSIVO_NEW_UL = right(  '0000' + ltrim(rtrim(TB_AUT12_BIS.AUT12_R12_PROGRESSIVO_NEW_UL)) ,4)
				--FROM TB_AUT12_BIS INNER JOIN TB_AUT12_OSIRIDE_TR12 ON 
				--	TB_AUT12_BIS.aut12_r12_codice_fiscale = TB_AUT12_OSIRIDE_TR12.aut12_r12_codice_fiscale AND 
				--	TB_AUT12_BIS.aut12_r12_auulo_codice_pk = TB_AUT12_OSIRIDE_TR12.aut12_r12_auulo_codice_pk					
--RAFFAELE
				UPDATE TB_AUT12_OSIRIDE_TR12
				SET AUT12_R12_PROGRESSIVO_NEW_UL = right(  '0000' + ltrim(rtrim(TB_AUT12_BIS.AUT12_R12_PROGRESSIVO_NEW_UL)) ,4)
				FROM TB_AUT12_BIS INNER JOIN TB_AUT12_OSIRIDE_TR12 ON 
					TB_AUT12_BIS.aut12_r12_codice_fiscale = TB_AUT12_OSIRIDE_TR12.aut12_r12_codice_fiscale AND 
					TB_AUT12_BIS.aut12_r12_auulo_codice_pk = TB_AUT12_OSIRIDE_TR12.aut12_r12_auulo_codice_pk 
			    WHERE TB_AUT12_BIS.aut12_r12_codice_fiscale = @CodFisc 
										
--RAFFAELE



				----Print '** Exec SP_Osiride_TR12_6_Output_000 **'
				EXEC SP_Osiride_TR12_6_Output_000 @CodFisc	
			
				----Print '** Exec SP_Osiride_TR13_5_Output **'
				EXEC SP_Osiride_TR13_5_Output_000 @CodFisc
			
				--Print '** Exec SP_Osiride_TR14_3_Output_000 **'
				EXEC SP_Osiride_TR14_3_Output_000 @CodFisc			
			
				INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
			    VALUES (16, 'B', 'OSIRIDE', Getdate(),'DECLARE UL_Cursor ','DECLARE UL_Cursor '+@CodFisc, Getdate(), 'AdminPlus' )
				
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
--						EXEC SP_Osiride_TR12_7_Output @CodFisc, @AuuloCodicePk						
	UPDATE TB_AUT12_OSIRIDE_TR12
		SET AUT12_R12_DESCR_ATT_UL_01 = auulo_descr_sotto_tipo1, 
			AUT12_R12_DESCR_ATT_UL_02 = auulo_descr_sotto_tipo2, 
			AUT12_R12_DESCR_ATT_UL_03 = auulo_descr_sotto_tipo3, 
			AUT12_R12_DESCR_ATT_UL_04 = auulo_descr_sotto_tipo4, 
			AUT12_R12_DESCR_ATT_UL_05 = auulo_descr_sotto_tipo5
	FROM TB_AUT12_OSIRIDE_TR12 
	INNER JOIN  tb_auulo_unita_locale ON TB_AUT12_OSIRIDE_TR12.aut12_r12_auulo_codice_pk = tb_auulo_unita_locale.auulo_codice_pk
	WHERE AUT12_R12_CODICE_FISCALE = @CodFisc
	AND   AUT12_R12_AUULO_CODICE_PK = @AuuloCodicePk	
	
	
	INSERT INTO [dbo].[TB_AUT99_OSIRIDE_OUT]

SELECT 
		 ISNULL([AUT12_R12_TIPO] ,SPACE(2))
		+ISNULL([AUT12_R12_PROV_CCIAA] ,SPACE(2))
		+ISNULL([AUT12_R12_NUM_IREA] ,SPACE(9))
		--+ISNULL([AUT12_R12_PROGRESSIVO_UL] ,SPACE(4))
		+ISNULL([AUT12_R12_PROGRESSIVO_NEW_UL] ,SPACE(4))
		+ISNULL([AUT12_R12_CODICE_TIPO_UL] ,SPACE(15))
		+ISNULL([AUT12_R12_TIPO_UL] ,SPACE(2))
		+ISNULL([AUT12_R12_DENOMINAZIONE_UL] ,SPACE(305))
		+ISNULL([AUT12_R12_INSEGNA_UL] ,SPACE(50))
		+ISNULL([AUT12_R12_DATA_APERTURA_UL] ,SPACE(8))
		+ISNULL([AUT12_R12_PROVINCIA_UL] ,SPACE(2))
		+ISNULL([AUT12_R12_COD_ISTAT_COMUNE_UL] ,SPACE(5))
		+ISNULL([AUT12_R12_COMUNE_UL] ,SPACE(30))
		+ISNULL([AUT12_R12_COD_TOPONIMO_UL] ,SPACE(3))
		+ISNULL([AUT12_R12_INDIRIZZO_UL] ,SPACE(30))
		+ISNULL([AUT12_R12_CIVICO_UL] ,SPACE(8))
		+ISNULL([AUT12_R12_CAP_UL] ,SPACE(5))
		+ISNULL([AUT12_R12_COD_STATO_ESTERO_UL] ,SPACE(3))
		+ISNULL([AUT12_R12_FRAZIONE_UL] ,SPACE(25))
		+ISNULL([AUT12_R12_ALTRE_INDICAZIONI_UL] ,SPACE(30))
		+ISNULL([AUT12_R12_COD_STRADARIO_UL] ,SPACE(5))
		+ISNULL([AUT12_R12_TELEFONO_UL] ,SPACE(16))
		+ISNULL([AUT12_R12_FAX_UL] ,SPACE(16))
		+ISNULL([AUT12_R12_NREA_FUORI_PROV] ,SPACE(9))
		+ISNULL([AUT12_R12_COD_CAUSA_CESSAZIONE] ,SPACE(2))
		+ISNULL([AUT12_R12_DATA_CESSAZIONE_UL] ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_DENUNCIA_CESS_UL] ,SPACE(8))
		+ISNULL([AUT12_R12_ANNO_DENUNCIA_ADDETTI] ,SPACE(4))
		+ISNULL([AUT12_R12_NUM_ADDETTI_FAM] ,SPACE(4))
		+ISNULL([AUT12_R12_NUM_ADDETTI_SUB] ,SPACE(9))
		+ISNULL([AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_01] ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ENTE_RILASCIANTE_01] ,SPACE(2))
		+ISNULL([AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_02] ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ENTE_RILASCIANTE_02] ,SPACE(2))
		+ISNULL([AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_03] ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ENTE_RILASCIANTE_03] ,SPACE(2))
		+ISNULL([AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_04] ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ENTE_RILASCIANTE_04] ,SPACE(2))
		+ISNULL([AUT12_R12_DATA_DENUNCIA_INI_ATT_UL_05] ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ENTE_RILASCIANTE_05] ,SPACE(2))
		+ISNULL([AUT12_R12_FLAG_OMISSIS_INI_ATT] ,SPACE(1))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_01] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_01] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_01]  ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_01]  ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_02] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_02] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_02]  ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_02]  ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_03] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_03] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_03]  ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_03]  ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_04] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_04] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_04]  ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_04]  ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_05] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_05] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_05]  ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_05]  ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_06] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_06] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_06]  ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_06]  ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_07] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_07] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_07]  ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_07]  ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_08] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_08] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_08]  ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_08]  ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_09] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_09] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_09]  ,SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_09]  ,SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2002_10] ,SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_10] ,SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZ_ATT_10]  , SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESS_ATT_10]  , SPACE(8))
		+ISNULL([AUT12_R12_FLAG_OMISSIS_ATT_ISTAT],SPACE(1))
		+ISNULL([AUT12_R12_DESCR_ATT_UL_01],SPACE(80))
		+ISNULL([AUT12_R12_DESCR_ATT_UL_02],SPACE(80))
		+ISNULL([AUT12_R12_DESCR_ATT_UL_03],SPACE(80))
		+ISNULL([AUT12_R12_DESCR_ATT_UL_04],SPACE(80))
		+ISNULL([AUT12_R12_DESCR_ATT_UL_05],SPACE(80))
		+ISNULL([AUT12_R12_FLAG_OMISSIS_DESCR_ATT],SPACE(1))
		+ISNULL([AUT12_R12_SUPER_VENDITA],SPACE(4))
		+ISNULL([AUT12_R12_SETT_MERC],SPACE(1))
		+ISNULL([AUT12_R12_DATA_DENUNCIA_INIZ_ATT],SPACE(8))					
		+ISNULL([AUT12_R12_COD_ISTAT_2007_01],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_01],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_01],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_01],SPACE(8))
		+ISNULL([AUT12_R12_COD_ISTAT_2007_02],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_02],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_02],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_02],SPACE(8)) 
		+ISNULL([AUT12_R12_COD_ISTAT_2007_03],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_03],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_03],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_03],SPACE(8)) 
		+ISNULL([AUT12_R12_COD_ISTAT_2007_04],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_04],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_04],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_04],SPACE(8)) 
		+ISNULL([AUT12_R12_COD_ISTAT_2007_05],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_05],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_05],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_05],SPACE(8)) 
		+ISNULL([AUT12_R12_COD_ISTAT_2007_06],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_06],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_06],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_06],SPACE(8)) 
		+ISNULL([AUT12_R12_COD_ISTAT_2007_07],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_07],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_07],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_07],SPACE(8)) 
		+ISNULL([AUT12_R12_COD_ISTAT_2007_08],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_08],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_08],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_08],SPACE(8)) 
		+ISNULL([AUT12_R12_COD_ISTAT_2007_09],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_09],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_09],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_09],SPACE(8)) 	
		+ISNULL([AUT12_R12_COD_ISTAT_2007_10],SPACE(6))
		+ISNULL([AUT12_R12_COD_IMPORT_ATT_2007_10],SPACE(1))
		+ISNULL([AUT12_R12_DATA_INIZIO_2007_10],SPACE(8))
		+ISNULL([AUT12_R12_DATA_CESSAZ_2007_10],SPACE(8))
		+ISNULL([AUT12_R12_FLAG_OMISSIS_ATT_2007],SPACE(1))

		+ISNULL([AUT12_R12_FILLER],SPACE(55)) 							
	FROM dbo.TB_AUT12_OSIRIDE_TR12
	WHERE AUT12_R12_CODICE_FISCALE = @CodFisc
	AND   AUT12_R12_AUULO_CODICE_PK = @AuuloCodicePk		

--						EXEC SP_Osiride_TR12_7_Output @CodFisc, @AuuloCodicePk						

						
						--Print '** Exec SP_Osiride_TR13_6_Output **'
--						EXEC SP_Osiride_TR13_6_Output @CodFisc, @AuuloCodicePk
	INSERT INTO [dbo].[TB_AUT99_OSIRIDE_OUT]
	
	SELECT
	 ISNULL([AUT13_R13_TIPO],SPACE(2))
	+ISNULL([AUT13_R13_PROV_CCIAA],SPACE(2))
	+ISNULL([AUT13_R13_NUM_IREA],SPACE(9))
	+ISNULL([AUT13_R13_PROGRESSIVO_UL],SPACE(4))
	+ISNULL([AUT13_R13_TIPO_RUOLO],SPACE(2))
	+ISNULL([AUT13_R13_FORMA_RUOLO],SPACE(1))
	+ISNULL([AUT13_R13_N_RUOLO],SPACE(7))
	+ISNULL([AUT13_R13_PROVINCIA_RUOLO],SPACE(2))
	+ISNULL([AUT13_R13_COD_ENTE_ALBO],SPACE(2))
	+ISNULL([AUT13_R13_DATA_DOM_ISCR],SPACE(8))
	+ISNULL([AUT13_R13_DATA_DOM_CESS],SPACE(8))
	+ISNULL([AUT13_R13_DATA_DEL_CESS],SPACE(8))
	+ISNULL([AUT13_R13_DATA_EFF_CESS],SPACE(8))
	+ISNULL([AUT13_R13_COD_CAU_CESS],SPACE(2))
	+ISNULL([AUT13_R13_FILLER],SPACE(1356))
	+ISNULL([AUT13_R13_filler02],SPACE(180))
	FROM [dbo].[TB_AUT13_OSIRIDE_TR13]	
	WHERE AUT13_R13_CODICE_FISCALE = @CodFisc
	AND   AUT13_R13_AUULO_CODICE_PK = @AuuloCodicePk		


--						EXEC SP_Osiride_TR13_6_Output @CodFisc, @AuuloCodicePk
						
						--Print '** Exec SP_Osiride_TR14_4_Output **'
--						EXEC SP_Osiride_TR14_4_Output @CodFisc, @AuuloCodicePk
	INSERT INTO [dbo].[TB_AUT99_OSIRIDE_OUT]	
	SELECT
	 ISNULL([AUT14_R14_TIPO],SPACE(2))                                  
	+ISNULL([AUT14_R14_PROV_CCIAA],SPACE(2))                            
	+ISNULL([AUT14_R14_NUM_IREA],SPACE(9))                     
	+ISNULL([AUT14_R14_PROGRESSIVO_UL],SPACE(4))                        
	+ISNULL([AUT14_R14_TIPO_RUOLO],SPACE(2))                            
	+ISNULL([AUT14_R14_FORMA_RUOLO],SPACE(1))                           
	+ISNULL([AUT14_R14_NUM_RUOLO],SPACE(7))                             
	+ISNULL([AUT14_R14_DATA_DOM_ISCRIZ],SPACE(8))                       
	+ISNULL([AUT14_R14_DATA_DELIBERA_ISCRIZ],SPACE(8))                  
	+ISNULL([AUT14_R14_DATA_INIZ_ATT],SPACE(8))                         
	+ISNULL([AUT14_R14_DATA_DOM_CESS],SPACE(8))                         
	+ISNULL([AUT14_R14_DATA_DELIBERA_CESS],SPACE(8))                    
	+ISNULL([AUT14_R14_DATA_EFF_CESS],SPACE(8))                         
	+ISNULL([AUT14_R14_COD_CAUSALE_CESS],SPACE(2))    
	+ISNULL([AUT14_R14_FILLER],SPACE(1524))                                                                               
	FROM [dbo].[TB_AUT14_OSIRIDE_TR14]	
	WHERE 1 = 1
	AND AUT14_R14_CODICE_FISCALE = @CodFisc
	AND   AUT14_R14_AUULO_CODICE_PK = @AuuloCodicePk
	AND (Isnull(AUT14_R14_NUM_RUOLO,'XXXXXXX') <> 'XXXXXXX' AND ltrim(rtrim(AUT14_R14_NUM_RUOLO)) <> '')



--						EXEC SP_Osiride_TR14_4_Output @CodFisc, @AuuloCodicePk
						
						INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
						VALUES (156, 'B', 'OSIRIDE', Getdate(),'FETCH NEXT FROM UL_Cursor','FETCH NEXT FROM UL_Cursor '+@CodFisc+convert(varchar(20),@AuuloCodicePk), Getdate(), 'AdminPlus' )
						
						FETCH NEXT FROM UL_Cursor INTO  @AuuloCodicePk
					END
					
				CLOSE UL_Cursor
				DEALLOCATE UL_Cursor			
				
				INSERT INTO [dbo].[tb_aulog_log] ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto],[aulog_nome_attore] ,[aulog_data_log] ,[aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
				VALUES (15, 'B', 'OSIRIDE', Getdate(),'FETCH NEXT FROM CF_Cursor','FETCH NEXT FROM CF_Cursor', Getdate(), 'AdminPlus' )

				FETCH NEXT FROM CF_Cursor INTO  @CodFisc
			END
		
		CLOSE CF_Cursor
		DEALLOCATE CF_Cursor
	
	INSERT INTO [dbo].[tb_aulog_log]
	       ([aulog_aucme_codice_pk] ,[aulog_tipo_contesto] ,[aulog_nome_attore] ,[aulog_data_log] ,
		    [aulog_descr_breve] ,[aulog_descr_lunga] ,[aulog_data_modifica] ,[aulog_descr_utente])
    VALUES
           (0, 'B', 'OSIRIDE', Getdate(),
		    'OSIRIDE - (FINE)', 'OSIRIDE- Produzione Output - [FINE] Elaborazione', Getdate(), 'AdminPlus')
END


