﻿CREATE PROCEDURE [dbo].[SP_Osiride_TR01_2_Output] @CodFisc VARCHAR(16)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[TB_AUT99_OSIRIDE_OUT]

	SELECT 
	ISNULL(AUT01_R1_TIPO,SPACE(2))
	+ISNULL(AUT01_R1_PROV_CCIAA,SPACE(2)) 
	+ISNULL(AUT01_R1_NUM_IREA,SPACE(9)) 
	+ISNULL(AUT01_R1_NUM_RIMP,SPACE(21)) 
	+ISNULL(AUT01_R1_DATA_ISC,SPACE(8)) 
	+ISNULL(AUT01_R1_FLAG_REA_AGG,SPACE(1))
	+ISNULL(AUT01_R1_DATA_ULT_AGG,SPACE(8))
	+ISNULL(AUT01_R1_PROV_SEDE,SPACE(2))
	+ISNULL(AUT01_R1_NUM_ISC_SEDE,SPACE(9))
	+ISNULL(AUT01_R1_RAGIONE_SOCE_1,SPACE(160)) 
	+ISNULL(AUT01_R1_RAGIONE_SOCE_2,SPACE(145)) 
    +ISNULL(AUT01_R1_COD_FISC_IMP,SPACE(16)) 
  	+ISNULL(AUT01_R1_PART_IVA,SPACE(11)) 
	+ISNULL(AUT01_R1_NAT_GIU,SPACE(2)) 
	+ISNULL(AUT01_R1_COD_PROVEN,SPACE(2)) 
	+ISNULL(AUT01_R1_DATA_ISCR_REA,SPACE(8)) 
	+ISNULL(AUT01_R1_DATA_ISCR_REG_IMP,SPACE(8)) 
	+ISNULL(AUT01_R1_COD_SEZ_SPECIALE_01,SPACE(3)) 
	+ISNULL(AUT01_R1_DATA_INIZ_SEZ_SPE_01,SPACE(8))
	+ISNULL(AUT01_R1_FLAG_COL_DIRETTO_01,SPACE(1))	
	+ISNULL(AUT01_R1_DATA_FIN_APP_SEZ_SPE_01,SPACE(8))
	+ISNULL(AUT01_R1_COD_MOTIVO_FIN_APP_SEZ_SPECIALE_01,SPACE(3))
	+ISNULL(AUT01_R1_COD_SEZ_SPECIALE_02,SPACE(3)) 
	+ISNULL(AUT01_R1_DATA_INIZ_SEZ_SPE_02,SPACE(8)) 
	+ISNULL(AUT01_R1_FLAG_COL_DIRETTO_02,SPACE(1)) 
	+ISNULL(AUT01_R1_DATA_FIN_APP_SEZ_SPE_02,SPACE(8))
	+ISNULL(AUT01_R1_COD_MOTIVO_FIN_APP_SEZ_SPECIALE_02,SPACE(3))
	+ISNULL(AUT01_R1_COD_SEZ_SPECIALE_03,SPACE(3)) 
	+ISNULL(AUT01_R1_DATA_INIZ_SEZ_SPE_03,SPACE(8)) 
	+ISNULL(AUT01_R1_FLAG_COL_DIRETTO_03,SPACE(1))
	+ISNULL(AUT01_R1_DATA_FIN_APP_SEZ_SPE_03,SPACE(8))
	+ISNULL(AUT01_R1_COD_MOTIVO_FIN_APP_SEZ_SPECIALE_03,SPACE(3))
	+ISNULL(AUT01_R1_FLAG_ISCR_ART_DECIS,SPACE(1)) 
	+ISNULL(AUT01_R1_STATO_IMPRESA,SPACE(1)) 
	+ISNULL(AUT01_R1_DATA_INIZIO_STATO_AT,SPACE(8)) 
	+ISNULL(AUT01_R1_DATA_ULT_AGG_ARC_SE,SPACE(8)) 
	+ISNULL(AUT01_R1_FLAG_FASE_AGG,SPACE(1)) 
	+ISNULL(AUT01_R1_COD_CESS_INT,SPACE(2)) 
	+ISNULL(AUT01_R1_DATA_CESS_INT,SPACE(8)) 
	+ISNULL(AUT01_R1_DATA_DENUN_CESS_INT,SPACE(8)) 
	+ISNULL(AUT01_R1_DATA_CAN_INFORM_INT,SPACE(8)) 
	+ISNULL(AUT01_R1_COD_CESS_SEDE,SPACE(2)) 
	+ISNULL(AUT01_R1_DATA_CESS_SEDE,SPACE(8)) 
	+ISNULL(AUT01_R1_DATA_DENUN_CESS_SEDE,SPACE(8)) 
	+ISNULL(AUT01_R1_DATA_CAN_INFORM_SEDE,SPACE(8)) 
	+ISNULL(AUT01_R1_IND_TRASF_SEDE,SPACE(1)) 
	+ISNULL(AUT01_R1_DATA_CESS_FUNZ_SEDE,SPACE(8)) 
	+ISNULL(AUT01_R1_COD_CAUS_CESS,SPACE(2)) 
	+ISNULL(AUT01_R1_DATA_AGG_ARC_IMP_NAZ,SPACE(8)) 
	+ISNULL(AUT01_R1_FILLER,SPACE(1028))
	FROM dbo.TB_AUT01_OSIRIDE_TR01
	WHERE AUT01_R1_COD_FISC_IMP = @CodFisc;
		
END
