﻿CREATE PROCEDURE [dbo].[SP_Osiride_TR12_7_Output] @CodiceFiscale VARCHAR(16),@AuuloCodicePk Bigint 	
AS
BEGIN
	SET NOCOUNT ON;
	
	-- 2018 02 15 --
	UPDATE TB_AUT12_OSIRIDE_TR12
		SET AUT12_R12_DESCR_ATT_UL_01 = auulo_descr_sotto_tipo1, 
			AUT12_R12_DESCR_ATT_UL_02 = auulo_descr_sotto_tipo2, 
			AUT12_R12_DESCR_ATT_UL_03 = auulo_descr_sotto_tipo3, 
			AUT12_R12_DESCR_ATT_UL_04 = auulo_descr_sotto_tipo4, 
			AUT12_R12_DESCR_ATT_UL_05 = auulo_descr_sotto_tipo5
	FROM TB_AUT12_OSIRIDE_TR12 
	INNER JOIN  tb_auulo_unita_locale ON TB_AUT12_OSIRIDE_TR12.aut12_r12_auulo_codice_pk = tb_auulo_unita_locale.auulo_codice_pk
	WHERE AUT12_R12_CODICE_FISCALE = @CodiceFiscale
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
--		+ISNULL([AUT12_R12_FLAG_OMISSIS_INI_ATT] ,SPACE(1))
		+ISNULL([AUT12_R12_FLAG_OMISSIS_INI_ATT] ,'0') --MODIFICATO DEFAULT DA RAF IL 24-01-2019
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
--		+ISNULL([AUT12_R12_FLAG_OMISSIS_ATT_ISTAT],SPACE(1))
		+ISNULL([AUT12_R12_FLAG_OMISSIS_ATT_ISTAT],'0') --MODIFICATO DEFAULT DA RAF IL 24-01-2019
		+ISNULL([AUT12_R12_DESCR_ATT_UL_01],SPACE(80))
		+ISNULL([AUT12_R12_DESCR_ATT_UL_02],SPACE(80))
		+ISNULL([AUT12_R12_DESCR_ATT_UL_03],SPACE(80))
		+ISNULL([AUT12_R12_DESCR_ATT_UL_04],SPACE(80))
		+ISNULL([AUT12_R12_DESCR_ATT_UL_05],SPACE(80))
--		+ISNULL([AUT12_R12_FLAG_OMISSIS_DESCR_ATT],SPACE(1))
		+ISNULL([AUT12_R12_FLAG_OMISSIS_DESCR_ATT],'0') --MODIFICATO DEFAULT DA RAF IL 24-01-2019
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
--		+ISNULL([AUT12_R12_FLAG_OMISSIS_ATT_2007],SPACE(1))
		+ISNULL([AUT12_R12_FLAG_OMISSIS_ATT_2007],'0') --MODIFICATO DEFAULT DA RAF IL 24-01-2019

		+ISNULL([AUT12_R12_FILLER],SPACE(55)) 							
	FROM dbo.TB_AUT12_OSIRIDE_TR12
	WHERE AUT12_R12_CODICE_FISCALE = @CodiceFiscale
	AND   AUT12_R12_AUULO_CODICE_PK = @AuuloCodicePk		
	
END

