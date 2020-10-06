﻿CREATE PROCEDURE [dbo].[SP_Osiride_TR10_3_Output] @CodFisc VARCHAR(16)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[TB_AUT99_OSIRIDE_OUT]

	SELECT
		ISNULL(AUT10_R10_TIPO,SPACE(2))                                
		+ISNULL(AUT10_R10_PROV_CCIAA,SPACE(2)) 
		+ISNULL(AUT10_R10_NUM_IREA,SPACE(9)) 		
		+ISNULL(AUT10_R10_PROG_PERS,SPACE(4))
		+ISNULL(AUT10_R10_PROV_CCIAA_PG,SPACE(2))
		+ISNULL(AUT10_R10_NUM_IREA_PG,SPACE(9))
		+ISNULL(AUT10_R10_NUM_RIMP_PERS,SPACE(21))
		+ISNULL(AUT10_R10_DENOM_PERS,SPACE(305))
		+ISNULL(AUT10_R10_DATA_COSTITUZIONE,SPACE(8))
		+ISNULL(AUT10_R10_COD_FISC,SPACE(16))
		+ISNULL(AUT10_R10_ISTAT_COM_SEDE,SPACE(5))
--		+ISNULL(AUT10_R10_ISTAT_COM_SEDE2,SPACE(5))-- TOLTO DA RAF IL  24-01-2019
		+ISNULL(AUT10_R10_COMUNE_SEDE,SPACE(30))
		+ISNULL(AUT10_R10_PROV_SEDE,SPACE(2))
		+ISNULL(AUT10_R10_TOPONIMO_SEDE,SPACE(3))
		+ISNULL(AUT10_R10_IND_SEDE,SPACE(30))
		+ISNULL(AUT10_R10_NUM_CIV_SEDE,SPACE(8))
		+ISNULL(AUT10_R10_CAP_SEDE,SPACE(5))
		+ISNULL(AUT10_R10_COD_STATO_SEDE,SPACE(3))
		+ISNULL(AUT10_R10_FRAZ_SEDE,SPACE(25))
		+ISNULL(AUT10_R10_ALTRE_IND_SEDE,SPACE(30))
		+ISNULL(AUT10_R10_QUOTE_PARTEC,SPACE(15))
		+ISNULL(AUT10_R10_PERCE_PARTEC,SPACE(4))
		+ISNULL(AUT10_R10_QUOTE_PARTEC_E,SPACE(17))
		+ISNULL(AUT10_R10_QUOTA_C_VALUTA,SPACE(3))
		--1--(Cariche)
		+ISNULL(AUT10_R10_PROG_CARICA_01,SPACE(4))
		+ISNULL(AUT10_R10_COD_CARICA_01,SPACE(3))
		+ISNULL(AUT10_R10_DATA_INIZ_CAR_01,SPACE(8))
		+ISNULL(AUT10_R10_DATA_FINE_CAR_01,SPACE(8))
		+ISNULL(AUT10_R10_COD_DURA_CAR_01,SPACE(2))
		+ISNULL(AUT10_R10_ANNI_ESE_CAR_01,SPACE(2))
		+ISNULL(AUT10_R10_DATA_PRES_CAR_01,SPACE(8))		
		--2--(Cariche)
		+ISNULL(AUT10_R10_PROG_CARICA_02,SPACE(4))
		+ISNULL(AUT10_R10_COD_CARICA_02,SPACE(3))
		+ISNULL(AUT10_R10_DATA_INIZ_CAR_02,SPACE(8))
		+ISNULL(AUT10_R10_DATA_FINE_CAR_02,SPACE(8))
		+ISNULL(AUT10_R10_COD_DURA_CAR_02,SPACE(2))
		+ISNULL(AUT10_R10_ANNI_ESE_CAR_02,SPACE(2))
		+ISNULL(AUT10_R10_DATA_PRES_CAR_02,SPACE(8))		
		--3--(Cariche)
		+ISNULL(AUT10_R10_PROG_CARICA_03,SPACE(4))
		+ISNULL(AUT10_R10_COD_CARICA_03,SPACE(3))
		+ISNULL(AUT10_R10_DATA_INIZ_CAR_03,SPACE(8))
		+ISNULL(AUT10_R10_DATA_FINE_CAR_03,SPACE(8))
		+ISNULL(AUT10_R10_COD_DURA_CAR_03,SPACE(2))
		+ISNULL(AUT10_R10_ANNI_ESE_CAR_03,SPACE(2))
		+ISNULL(AUT10_R10_DATA_PRES_CAR_03,SPACE(8))		
		--4--(Cariche)
		+ISNULL(AUT10_R10_PROG_CARICA_04,SPACE(4))
		+ISNULL(AUT10_R10_COD_CARICA_04,SPACE(3))
		+ISNULL(AUT10_R10_DATA_INIZ_CAR_04,SPACE(8))
		+ISNULL(AUT10_R10_DATA_FINE_CAR_04,SPACE(8))
		+ISNULL(AUT10_R10_COD_DURA_CAR_04,SPACE(2))
		+ISNULL(AUT10_R10_ANNI_ESE_CAR_04,SPACE(2))
		+ISNULL(AUT10_R10_DATA_PRES_CAR_04,SPACE(8))		
		--5--(Cariche)
		+ISNULL(AUT10_R10_PROG_CARICA_05,SPACE(4))
		+ISNULL(AUT10_R10_COD_CARICA_05,SPACE(3))
		+ISNULL(AUT10_R10_DATA_INIZ_CAR_05,SPACE(8))
		+ISNULL(AUT10_R10_DATA_FINE_CAR_05,SPACE(8))
		+ISNULL(AUT10_R10_COD_DURA_CAR_05,SPACE(2))
		+ISNULL(AUT10_R10_ANNI_ESE_CAR_05,SPACE(2))
		+ISNULL(AUT10_R10_DATA_PRES_CAR_05,SPACE(8))

--		+ISNULL(AUT10_R10_CAR_OMISSIS,SPACE(1))
		+ISNULL(AUT10_R10_CAR_OMISSIS,'0') --SOSTITUITO DEFAULT DA RAF IL 24-01-2019
		
		-- 1--(Fallimento)		
		+ISNULL(AUT10_R10_PROG_FALLI_01,SPACE(4))
		+ISNULL(AUT10_R10_PR_TRIB_FALL_01,SPACE(2))
		+ISNULL(AUT10_R10_DESC_TRIB_FALL_01,SPACE(30))
		+ISNULL(AUT10_R10_NUM_FALL_01,SPACE(10))
		+ISNULL(AUT10_R10_DATA_FALL_01,SPACE(8))
		+ISNULL(AUT10_R10_NUM_SEN_FALL_01,SPACE(10))
		+ISNULL(AUT10_R10_DATA_SEN_FALL_01,SPACE(8))
		+ISNULL(AUT10_R10_ORG_GIUDI_01,SPACE(1))
		+ISNULL(AUT10_R10_CUR_FALL_01,SPACE(30))
		+ISNULL(AUT10_R10_DATA_CHIU_FALL_01,SPACE(8))
		+ISNULL(AUT10_R10_COGN_DEN_CAUSA_FALL_01,SPACE(25))
		+ISNULL(AUT10_R10_NOME_DEN_CAUSA_FALL_01,SPACE(25))
		+ISNULL(AUT10_R10_DATA_NAS_FALL_01,SPACE(8))
		-- 2--(Fallimento)
		+ISNULL(AUT10_R10_PROG_FALLI_02,SPACE(4))
		+ISNULL(AUT10_R10_PR_TRIB_FALL_02,SPACE(2))
		+ISNULL(AUT10_R10_DESC_TRIB_FALL_02,SPACE(30))
		+ISNULL(AUT10_R10_NUM_FALL_02,SPACE(10))
		+ISNULL(AUT10_R10_DATA_FALL_02,SPACE(8))
		+ISNULL(AUT10_R10_NUM_SEN_FALL_02,SPACE(10))
		+ISNULL(AUT10_R10_DATA_SEN_FALL_02,SPACE(8))
		+ISNULL(AUT10_R10_ORG_GIUDI_02,SPACE(1))
		+ISNULL(AUT10_R10_CUR_FALL_02,SPACE(30))
		+ISNULL(AUT10_R10_DATA_CHIU_FALL_02,SPACE(8))
		+ISNULL(AUT10_R10_COGN_DEN_CAUSA_FALL_02,SPACE(25))
		+ISNULL(AUT10_R10_NOME_DEN_CAUSA_FALL_02,SPACE(25))
		+ISNULL(AUT10_R10_DATA_NAS_FALL_02,SPACE(8))
		-- 3--(Fallimento)
		+ISNULL(AUT10_R10_PROG_FALLI_03,SPACE(4))
		+ISNULL(AUT10_R10_PR_TRIB_FALL_03,SPACE(2))
		+ISNULL(AUT10_R10_DESC_TRIB_FALL_03,SPACE(30))
		+ISNULL(AUT10_R10_NUM_FALL_03,SPACE(10))
		+ISNULL(AUT10_R10_DATA_FALL_03,SPACE(8))
		+ISNULL(AUT10_R10_NUM_SEN_FALL_03,SPACE(10))
		+ISNULL(AUT10_R10_DATA_SEN_FALL_03,SPACE(8))
		+ISNULL(AUT10_R10_ORG_GIUDI_03,SPACE(1))
		+ISNULL(AUT10_R10_CUR_FALL_03,SPACE(30))
		+ISNULL(AUT10_R10_DATA_CHIU_FALL_03,SPACE(8))
		+ISNULL(AUT10_R10_COGN_DEN_CAUSA_FALL_03,SPACE(25))
		+ISNULL(AUT10_R10_NOME_DEN_CAUSA_FALL_03,SPACE(25))
		+ISNULL(AUT10_R10_DATA_NAS_FALL_03,SPACE(8))
		-- 4--(Fallimento)
		+ISNULL(AUT10_R10_PROG_FALLI_04,SPACE(4))
		+ISNULL(AUT10_R10_PR_TRIB_FALL_04,SPACE(2))
		+ISNULL(AUT10_R10_DESC_TRIB_FALL_04,SPACE(30))
		+ISNULL(AUT10_R10_NUM_FALL_04,SPACE(10))
		+ISNULL(AUT10_R10_DATA_FALL_04,SPACE(8))
		+ISNULL(AUT10_R10_NUM_SEN_FALL_04,SPACE(10))
		+ISNULL(AUT10_R10_DATA_SEN_FALL_04,SPACE(8))
		+ISNULL(AUT10_R10_ORG_GIUDI_04,SPACE(1))
		+ISNULL(AUT10_R10_CUR_FALL_04,SPACE(30))
		+ISNULL(AUT10_R10_DATA_CHIU_FALL_04,SPACE(8))
		+ISNULL(AUT10_R10_COGN_DEN_CAUSA_FALL_04,SPACE(25))
		+ISNULL(AUT10_R10_NOME_DEN_CAUSA_FALL_04,SPACE(25))
		+ISNULL(AUT10_R10_DATA_NAS_FALL_04,SPACE(8))
		-- 5--(Fallimento)
		+ISNULL(AUT10_R10_PROG_FALLI_05,SPACE(4))
		+ISNULL(AUT10_R10_PR_TRIB_FALL_05,SPACE(2))
		+ISNULL(AUT10_R10_DESC_TRIB_FALL_05,SPACE(30))
		+ISNULL(AUT10_R10_NUM_FALL_05,SPACE(10))
		+ISNULL(AUT10_R10_DATA_FALL_05,SPACE(8))
		+ISNULL(AUT10_R10_NUM_SEN_FALL_05,SPACE(10))
		+ISNULL(AUT10_R10_DATA_SEN_FALL_05,SPACE(8))
		+ISNULL(AUT10_R10_ORG_GIUDI_05,SPACE(1))
		+ISNULL(AUT10_R10_CUR_FALL_05,SPACE(30))
		+ISNULL(AUT10_R10_DATA_CHIU_FALL_05,SPACE(8))
		+ISNULL(AUT10_R10_COGN_DEN_CAUSA_FALL_05,SPACE(25))
		+ISNULL(AUT10_R10_NOME_DEN_CAUSA_FALL_05,SPACE(25))
		+ISNULL(AUT10_R10_DATA_NAS_FALL_05,SPACE(8))

--		+ISNULL(AUT10_R10_FALL_OMISSIS,SPACE(1))
		+ISNULL(AUT10_R10_CAR_OMISSIS,'0') --SOSTITUITO DEFAULT DA RAF IL 24-01-2019

--		+ISNULL(AUT10_R10_FILLER,SPACE(21))	--ERA 16 MODIFICATO DA RAF IL 24-01-2019
     	+SPACE(21) --Eliminato il riferimento al campo perche' forniva sempre 16 DA RAF IL 29-01-2019

	FROM dbo.TB_AUT10_OSIRIDE_TR10
	WHERE AUT10_R10_CODICE_FISCALE = @CodFisc;
		
END