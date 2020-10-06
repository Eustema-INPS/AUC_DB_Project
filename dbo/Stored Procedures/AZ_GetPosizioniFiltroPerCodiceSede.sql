CREATE PROCEDURE [dbo].[AZ_GetPosizioniFiltroPerCodiceSede]
	@codiceAzienda int,
	@codicesede varchar(10)
AS
BEGIN

	SET NOCOUNT ON;
	if @codicesede is null   or @codicesede='0' or @codicesede=''
		begin
		SET @codicesede=null
		end
		else
		begin
		SET @codicesede=CAST(@codicesede as Int)
		end
    
	SELECT     
		tb_aupoc_pos_contr.aupoc_codice_pk			AS DB_CodicePosizione,
		tb_aupoc_pos_contr.aupoc_contro_codice		AS DB_ControCodPosizione,
		aupoc_denom_posiz_contr	AS DB_DenominazioneAzienda,
		--CONVERT(varchar(20),aupoc_codice_pk) + isnull(tb_aupoc_pos_contr.aupoc_contro_codice,'') as DB_IdPosContr,
		RIGHT( '0000000000'+ CONVERT(varchar(20),aupoc_codice_pk),10)+ isnull(tb_aupoc_pos_contr.aupoc_contro_codice,'') as DB_IdPosContr,
		tb_aupoc_pos_contr.aupoc_posizione			AS DB_PosizioneContributiva,
		tb_ausin_sedi_inps_ct.ausin_codice_sede + ' - '+  tb_ausin_sedi_inps_ct.ausin_descr As DB_Sede,
		tb_aupoc_pos_contr.aupoc_aurea_codice_pk    AS DB_CodiceAurea,
	
		tb_aurea_area_gestione.aurea_descrizione AS DB_GestioneContributiva,
		
		tb_auspc_stato_pos_contr_ct.auspc_descr		AS DB_Stato,
		
		--Letizia 17/05/2013
		convert(varchar(10),tb_aupoc_pos_contr.aupoc_data_inizio_attivita,103)  as DB_DataInizio,
		
		--(
		--select convert(varchar(10),max(auvas_data_variazione_stato),103) from 
		--dbo.tb_auvas_var_stato_pos
		--where tb_auvas_var_stato_pos.auvas_aupoc_codice_pk=tb_aupoc_pos_contr.aupoc_codice_pk
		--and  tb_auvas_var_stato_pos.auvas_auspc_codice_pk=tb_aupoc_pos_contr.aupoc_auspc_codice_pk
		--) as DB_DataEvento,
		
        --Letizia Fine 17/05/2013
        
        --Letizia 13/0/2013
        convert(varchar(10),aupoc_data_ultimo_stato,103)  as DB_DataEvento
        --Letizia 13/0/2013
        
		
		-- -- Maurizio 23/5/2012
		--(SELECT COUNT(tb_aurpp_rel_poc_poc.aurpp_codice_pk)
		-- FROM tb_aurpp_rel_poc_poc
		-- WHERE tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_figlia=tb_aupoc_pos_contr.aupoc_codice_pk) 
		-- AS  DB_Figlia,
		
		--(SELECT COUNT(tb_aurpp_rel_poc_poc.aurpp_codice_pk) 
		-- FROM tb_aurpp_rel_poc_poc
		-- WHERE tb_aurpp_rel_poc_poc.aurpp_aupoc_cod_pk_madre=tb_aupoc_pos_contr.aupoc_codice_pk) 
		-- AS  DB_Madre


	FROM tb_aupoc_pos_contr 
	
	INNER JOIN tb_auapp_appl ON 
	tb_aupoc_pos_contr.aupoc_auapp_codice_pk = tb_auapp_appl.auapp_codice_pk
	
	INNER JOIN tb_auspc_stato_pos_contr_ct ON 
	tb_aupoc_pos_contr.aupoc_auspc_codice_pk = tb_auspc_stato_pos_contr_ct.auspc_codice_pk
	
		
	INNER JOIN tb_aurea_area_gestione ON
	tb_aupoc_pos_contr.aupoc_aurea_codice_pk=tb_aurea_area_gestione.aurea_codice_pk
	
	
	LEFT JOIN tb_ausin_sedi_inps_ct ON
	aupoc_ausin_codice_pk=tb_ausin_sedi_inps_ct.ausin_codice_pk
	
	---- Maurizio 23/05/2012 -- Per Posizioni Madre/Figlie
	--LEFT OUTER JOIN [dbo].[tb_aurpp_rel_poc_poc]
	--on [dbo].[tb_aurpp_rel_poc_poc].aurpp_codice_pk = @codiceAzienda
	
	--Aggiunto da Letizia 10/12/2012
	LEFT OUTER JOIN tb_aupco_periodo_contr ON 
	tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk AND
	convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
		
	LEFT OUTER JOIN tb_aucsc_cod_stat_contr_ct
	on aupco_cod_stat_contr=tb_aucsc_cod_stat_contr_ct.aucsc_codice
	--fine Letizia 10/12/2012
	
	
	WHERE aupoc_ausca_codice_pk = @codiceAzienda 
	AND 
	(tb_auspc_stato_pos_contr_ct.auspc_codice = 0 OR tb_auspc_stato_pos_contr_ct.auspc_codice = 4)
	--(tb_aupoc_pos_contr.aupoc_auspc_codice_pk = 0 OR tb_aupoc_pos_contr.aupoc_auspc_codice_pk = 4)
	--and tb_ausin_sedi_inps_ct.ausin_codice_pk=ISNULL(@codicesede,tb_ausin_sedi_inps_ct.ausin_codice_pk)
		AND ( tb_ausin_sedi_inps_ct.ausin_codice_pk=ISNULL(@codicesede,tb_ausin_sedi_inps_ct.ausin_codice_pk)	or  aupoc_ausin_codice_pk is null)
	
		
		
	ORDER BY DB_GestioneContributiva,tb_ausin_sedi_inps_ct.ausin_codice_sede,DB_PosizioneContributiva
END

