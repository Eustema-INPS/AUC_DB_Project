﻿CREATE PROCEDURE [dbo].[SP_Osiride_TR09_3_Output] @CodFisc VARCHAR(16)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[TB_AUT99_OSIRIDE_OUT]
	
	SELECT
	 ISNULL(AUT09_R9_TIPO,SPACE(2)) 
	+ISNULL(AUT09_R9_PROV_CCIAA,SPACE(2)) 
	+ISNULL(AUT09_R9_NUM_IREA,SPACE(9)) 
	+ISNULL(AUT09_R9_PROG_PERS,SPACE(4)) 
	+ISNULL(AUT09_R9_COGN_PERS,SPACE(25)) 
	+ISNULL(AUT09_R9_NOME_PERS,SPACE(25)) 
	+ISNULL(AUT09_R9_COD_STATO_NASC,SPACE(3)) 
	+ISNULL(AUT09_R9_PROV_NASC,SPACE(2)) 
	+ISNULL(AUT09_R9_ISTAT_COM_NASC,SPACE(5)) 
	+ISNULL(AUT09_R9_COMUNE_NASC,SPACE(30)) 
	+ISNULL(AUT09_R9_DATA_NASC,SPACE(8)) 
	+ISNULL(AUT09_R9_SESSO,SPACE(1)) 
	+ISNULL(AUT09_R9_COD_FISC,SPACE(16)) 
	+ISNULL(AUT09_R9_PROV_RES,SPACE(2)) 
	+ISNULL(AUT09_R9_ISTAT_COM_RES,SPACE(5)) 
	+ISNULL(AUT09_R9_COMUNE_RES,SPACE(30)) 
	+ISNULL(AUT09_R9_CAP_RES,SPACE(5)) 
	+ISNULL(AUT09_R9_COD_STATO_RES,SPACE(3)) 
	+ISNULL(AUT09_R9_FRAZ_RES,SPACE(25)) 
	+ISNULL(AUT09_R9_TOPONIMO_RES,SPACE(3)) 
	+ISNULL(AUT09_R9_IND_RES,SPACE(30)) 
	+ISNULL(AUT09_R9_NUM_CIV_RES,SPACE(8)) 
	+ISNULL(AUT09_R9_ALTRE_IND_RES,SPACE(30)) 
	+ISNULL(AUT09_R9_COD_STATO_CITTAD,SPACE(3)) 
	+ISNULL(AUT09_R9_COD_LIMIT_AGIRE,SPACE(2)) 
	+ISNULL(AUT09_R9_FLAG_SE_ELETTORE,SPACE(1)) 
	+ISNULL(AUT09_R9_POTERE_FIRMA,SPACE(1)) 
	+ISNULL(AUT09_R9_QUOTE_PARTEC,SPACE(15)) 
	+ISNULL(AUT09_R9_PERCE_PARTEC,SPACE(4)) 
	+ISNULL(AUT09_R9_QUOTE_PARTEC_E,SPACE(17)) 
	--+ISNULL(AUT09_R9_QUOTA_C_VALUTA,SPACE(3))
	+SPACE(3) --RIMESSO DA RAF IL 24-01-2019
	+ISNULL(AUT09_R9_PROG_CARICA_01,SPACE(4)) 
	+ISNULL(AUT09_R9_COD_CARICA_01,SPACE(3)) 
	+ISNULL(AUT09_R9_DATA_INIZ_CAR_01,SPACE(8)) 
	+ISNULL(AUT09_R9_DATA_FINE_CAR_01,SPACE(8)) 
	+ISNULL(AUT09_R9_COD_DURA_CAR_01,SPACE(2)) 
	+ISNULL(AUT09_R9_ANNI_ESE_CAR_01,SPACE(2)) 
	+ISNULL(AUT09_R9_DATA_PRES_CAR_01,SPACE(8)) 
	+ISNULL(AUT09_R9_PROG_CARICA_02,SPACE(4)) 
	+ISNULL(AUT09_R9_COD_CARICA_02,SPACE(3)) 
	+ISNULL(AUT09_R9_DATA_INIZ_CAR_02,SPACE(8)) 
	+ISNULL(AUT09_R9_DATA_FINE_CAR_02,SPACE(8)) 
	+ISNULL(AUT09_R9_COD_DURA_CAR_02,SPACE(2)) 
	+ISNULL(AUT09_R9_ANNI_ESE_CAR_02,SPACE(2)) 
	+ISNULL(AUT09_R9_DATA_PRES_CAR_02,SPACE(8)) 
	+ISNULL(AUT09_R9_PROG_CARICA_03,SPACE(4)) 
	+ISNULL(AUT09_R9_COD_CARICA_03,SPACE(3)) 
	+ISNULL(AUT09_R9_DATA_INIZ_CAR_03,SPACE(8)) 
	+ISNULL(AUT09_R9_DATA_FINE_CAR_03,SPACE(8)) 
	+ISNULL(AUT09_R9_COD_DURA_CAR_03,SPACE(2)) 
	+ISNULL(AUT09_R9_ANNI_ESE_CAR_03,SPACE(2)) 
	+ISNULL(AUT09_R9_DATA_PRES_CAR_03,SPACE(8)) 
	+ISNULL(AUT09_R9_PROG_CARICA_04,SPACE(4)) 
	+ISNULL(AUT09_R9_COD_CARICA_04,SPACE(3)) 
	+ISNULL(AUT09_R9_DATA_INIZ_CAR_04,SPACE(8)) 
	+ISNULL(AUT09_R9_DATA_FINE_CAR_04,SPACE(8)) 
	+ISNULL(AUT09_R9_COD_DURA_CAR_04,SPACE(2)) 
	+ISNULL(AUT09_R9_ANNI_ESE_CAR_04,SPACE(2)) 
	+ISNULL(AUT09_R9_DATA_PRES_CAR_04,SPACE(8)) 
	+ISNULL(AUT09_R9_PROG_CARICA_05,SPACE(4)) 
	+ISNULL(AUT09_R9_COD_CARICA_05,SPACE(3)) 
	+ISNULL(AUT09_R9_DATA_INIZ_CAR_05,SPACE(8)) 
	+ISNULL(AUT09_R9_DATA_FINE_CAR_05,SPACE(8)) 
	+ISNULL(AUT09_R9_COD_DURA_CAR_05,SPACE(2)) 
	+ISNULL(AUT09_R9_ANNI_ESE_CAR_05,SPACE(2)) 
	+ISNULL(AUT09_R9_DATA_PRES_CAR_05,SPACE(8)) 
--	+ISNULL(AUT09_R9_CAR_OMISSIS,SPACE(1)) 
	+ISNULL(AUT09_R9_CAR_OMISSIS,'0')  --CAMBIATO IL DEFAULT DA RAF IL 29-01-2019
	+ISNULL(AUT09_R9_PROG_FALL_01,SPACE(4)) 
	+ISNULL(AUT09_R9_PR_TRIB_FALL_01,SPACE(2)) 
	+ISNULL(AUT09_R9_DESC_TRIB_FALL_01,SPACE(30)) 
	+ISNULL(AUT09_R9_NUM_FALL_01,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_FALL_01,SPACE(8)) 
	+ISNULL(AUT09_R9_NUM_SEN_FALL_01,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_SEN_FALL_01,SPACE(8)) 
	+ISNULL(AUT09_R9_ORG_GIUDI_01,SPACE(1)) 
	+ISNULL(AUT09_R9_CUR_FALL_01,SPACE(30)) 
	+ISNULL(AUT09_R9_DATA_CHIU_FALL_01,SPACE(8)) 
	+ISNULL(AUT09_R9_COGN_DEN_CAUSA_FALL_01,SPACE(25)) 
	+ISNULL(AUT09_R9_NOME_DEN_CAUSA_FALL_01,SPACE(25)) 
	+ISNULL(AUT09_R9_DATA_NAS_FALL_01,SPACE(8)) 
	+ISNULL(AUT09_R9_PROG_FALL_02,SPACE(4)) 
	+ISNULL(AUT09_R9_PR_TRIB_FALL_02,SPACE(2)) 
	+ISNULL(AUT09_R9_DESC_TRIB_FALL_02,SPACE(30)) 
	+ISNULL(AUT09_R9_NUM_FALL_02,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_FALL_02,SPACE(8)) 
	+ISNULL(AUT09_R9_NUM_SEN_FALL_02,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_SEN_FALL_02,SPACE(8)) 
	+ISNULL(AUT09_R9_ORG_GIUDI_02,SPACE(1)) 
	+ISNULL(AUT09_R9_CUR_FALL_02,SPACE(30)) 
	+ISNULL(AUT09_R9_DATA_CHIU_FALL_02,SPACE(8)) 
	+ISNULL(AUT09_R9_COGN_DEN_CAUSA_FALL_02,SPACE(25)) 
	+ISNULL(AUT09_R9_NOME_DEN_CAUSA_FALL_02,SPACE(25)) 
	+ISNULL(AUT09_R9_DATA_NAS_FALL_02,SPACE(8)) 
	+ISNULL(AUT09_R9_PROG_FALL_03,SPACE(4)) 
	+ISNULL(AUT09_R9_PR_TRIB_FALL_03,SPACE(2)) 
	+ISNULL(AUT09_R9_DESC_TRIB_FALL_03,SPACE(30)) 
	+ISNULL(AUT09_R9_NUM_FALL_03,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_FALL_03,SPACE(8)) 
	+ISNULL(AUT09_R9_NUM_SEN_FALL_03,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_SEN_FALL_03,SPACE(8)) 
	+ISNULL(AUT09_R9_ORG_GIUDI_03,SPACE(1)) 
	+ISNULL(AUT09_R9_CUR_FALL_03,SPACE(30)) 
	+ISNULL(AUT09_R9_DATA_CHIU_FALL_03,SPACE(8)) 
	+ISNULL(AUT09_R9_COGN_DEN_CAUSA_FALL_03,SPACE(25)) 
	+ISNULL(AUT09_R9_NOME_DEN_CAUSA_FALL_03,SPACE(25)) 
	+ISNULL(AUT09_R9_DATA_NAS_FALL_03,SPACE(8)) 
	+ISNULL(AUT09_R9_PROG_FALL_04,SPACE(4)) 
	+ISNULL(AUT09_R9_PR_TRIB_FALL_04,SPACE(2)) 
	+ISNULL(AUT09_R9_DESC_TRIB_FALL_04,SPACE(30)) 
	+ISNULL(AUT09_R9_NUM_FALL_04,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_FALL_04,SPACE(8)) 
	+ISNULL(AUT09_R9_NUM_SEN_FALL_04,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_SEN_FALL_04,SPACE(8)) 
	+ISNULL(AUT09_R9_ORG_GIUDI_04,SPACE(1)) 
	+ISNULL(AUT09_R9_CUR_FALL_04,SPACE(30)) 
	+ISNULL(AUT09_R9_DATA_CHIU_FALL_04,SPACE(8)) 
	+ISNULL(AUT09_R9_COGN_DEN_CAUSA_FALL_04,SPACE(25)) 
	+ISNULL(AUT09_R9_NOME_DEN_CAUSA_FALL_04,SPACE(25)) 
	+ISNULL(AUT09_R9_DATA_NAS_FALL_04,SPACE(8)) 
	+ISNULL(AUT09_R9_PROG_FALL_05,SPACE(4)) 
	+ISNULL(AUT09_R9_PR_TRIB_FALL_05,SPACE(2)) 
	+ISNULL(AUT09_R9_DESC_TRIB_FALL_05,SPACE(30)) 
	+ISNULL(AUT09_R9_NUM_FALL_05,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_FALL_05,SPACE(8)) 
	+ISNULL(AUT09_R9_NUM_SEN_FALL_05,SPACE(10)) 
	+ISNULL(AUT09_R9_DATA_SEN_FALL_05,SPACE(8)) 
	+ISNULL(AUT09_R9_ORG_GIUDI_05,SPACE(1)) 
	+ISNULL(AUT09_R9_CUR_FALL_05,SPACE(30)) 
	+ISNULL(AUT09_R9_DATA_CHIU_FALL_05,SPACE(8)) 
	+ISNULL(AUT09_R9_COGN_DEN_CAUSA_FALL_05,SPACE(25)) 
	+ISNULL(AUT09_R9_NOME_DEN_CAUSA_FALL_05,SPACE(25)) 
	+ISNULL(AUT09_R9_DATA_NAS_FALL_05,SPACE(8)) 
--	+ISNULL(AUT09_R9_FALL_OMISSIS_FALL,SPACE(1)) 
	+ISNULL(AUT09_R9_FALL_OMISSIS_FALL,'0') --CAMBIATO IL DEFAULT DA RAF IL 24-01-2019
--	+ISNULL(AUT09_R9_FILLER,SPACE(260)) --ERA 263 RIDOTTO DA RAF IL 24-01-2019
	+SPACE(260) --Eliminato il riferimento al campo perche' forniva sempre 263 DA RAF IL 29-01-2019
	FROM dbo.TB_AUT09_OSIRIDE_TR09
	WHERE (isnull(AUT09_R9_COD_CARICA_01,'123') <> '123' AND ltrim(rtrim(AUT09_R9_COD_CARICA_01)) <> '')
	AND AUT09_R9_CODICE_FISCALE = @CodFisc	
END

/****** Object:  StoredProcedure [dbo].[SP_Osiride_TR10_3_Output]    Script Date: 29/01/2019 11.35.21 ******/
SET ANSI_NULLS ON
