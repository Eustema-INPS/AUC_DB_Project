


-- =============================================
-- Author:		maurizio picone
-- Create date: 20 agosto
-- Description:	records di forza lavoro per la posizione contr
-- Modificato da: Raffaele
-- Data:          26 settembre 2013
-- Descrizione:   Eliminazione controllo sullo stato di attivazione della posizione 
-- =============================================
CREATE PROCEDURE [dbo].[AZ_UltimaForzaLavoro] 
	@aupoc_codice_pk int
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

	--Almaviva 2017.11.27 AI 3117:	
	,AUPOC_INQ_ESITO_CONTROL AS DB_EsitoContr
	,AUPOC_INQ_COD_ERRORE_CONTROL AS DB_CodErrContr
	,AUPOC_INQ_DESCR_ERRORE AS DB_DescrErr
	,convert(varchar(10),AUPOC_INQ_DATA_PRIMO_CONTROL,103) AS DB_DataPrimoContr
	,convert(varchar(10),AUPOC_INQ_DATA_ULTIMO_CONTROL,103) AS DB_DataUltimoContr
	,AUPOC_INQ_ESITO_VERIFICA_OPER AS DB_EsitoVerificaOp
	,convert(varchar(10),AUPOC_INQ_DATA_ESITO_VERIFICA_OPER,103) AS DB_DataEsitoVerOp
	,AUPOC_INQ_COD_OPER AS DB_CodOp
	,AUPOC_INQ_NOTE AS DB_Not		
	--Almaviva 2017.11.27 AI 3117.
	 
	FROM [tb_aufor_forze_lavoro] 

 	inner join  [dbo].[tb_aupoc_pos_contr] 
	on tb_aufor_forze_lavoro.aufor_aupoc_codice_pk = aupoc_codice_pk

    --inner join  [dbo].[tb_ausca_sog_contr_az] 
	--on tb_ausca_sog_contr_az.ausca_codice_pk = tb_aupoc_pos_contr.aupoc_ausca_codice_pk

	WHERE 
	([aufor_aupoc_codice_pk] = @aupoc_codice_pk) 
--	and 
--	(aupoc_auspc_codice_pk = 1 or  aupoc_auspc_codice_pk = 5) -- "ATTIVA" o "RIATTIVATA"

	ORDER BY aufor_annomese DESC
END

