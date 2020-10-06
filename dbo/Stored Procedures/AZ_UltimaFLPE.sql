


-- =============================================
-- Author:	emanuela paletta
-- Create date: 23/11/2018
-- Description:	records di forza lavoro per la posizione errata da SC
-- =============================================
CREATE PROCEDURE [dbo].[AZ_UltimaFLPE] 
	@posizione varchar(50)
AS
BEGIN
declare @dipcertmod int

	SELECT top 1
	
	[aufor_posizione] 
	,[aufor_annomese]
	,[aufor_num_dip_dic]
	,[aufor_num_dip_dic_mod]
	,[aufor_num_dip_cert]
	,[aufor_num_dip_cert_mod]
	,[aufor_tipo_dic]
	,[aufor_stato_certificazione]
	,AUPOC_INQ_ESITO_CONTROL AS DB_EsitoContr
	,AUPOC_INQ_COD_ERRORE_CONTROL AS DB_CodErrContr
	,AUPOC_INQ_DESCR_ERRORE AS DB_DescrErr
	,convert(varchar(10),AUPOC_INQ_DATA_PRIMO_CONTROL,103) AS DB_DataPrimoContr
	,convert(varchar(10),AUPOC_INQ_DATA_ULTIMO_CONTROL,103) AS DB_DataUltimoContr
	,AUPOC_INQ_ESITO_VERIFICA_OPER AS DB_EsitoVerificaOp
	,convert(varchar(10),AUPOC_INQ_DATA_ESITO_VERIFICA_OPER,103) AS DB_DataEsitoVerOp
	,AUPOC_INQ_COD_OPER AS DB_CodOp
	,AUPOC_INQ_NOTE AS DB_Not		

	 
	FROM [tb_aupoe_PosizioniErrate_Aufor] 

 	inner join  [dbo].[tb_aupoe_PosizioniErrate_Aupoc] 
	on tb_aupoe_PosizioniErrate_Aufor.aufor_aupoc_codice_pk = aupoc_codice_pk

	WHERE 
	([aufor_posizione] = @posizione) 

	ORDER BY aufor_annomese DESC
	
	
END



