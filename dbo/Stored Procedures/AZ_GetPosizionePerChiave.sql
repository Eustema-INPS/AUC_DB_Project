


-- =======================================================================================
-- Author:		Letizia Bellantoni
-- Create date: 14.04.2012
-- Description:	Stored Procedure per la ricerca delle posizioni contributive per chiavi
-- =======================================================================================

-- =======================================================================================
-- Modificata da:  Maurizio Picone
-- Data modifica:  23 aprile 2012
-- Description:	Aggiunta la gestione del conteggio delle posizioni madre/figlie
-- =======================================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  06/12/2012
-- Description:	Utilizzo della FK aupoc_ausin_codice_pk
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  10/12/2012
-- Description:	Aggiunto Settore concatenato alla Gestione Applicativa
-- ======================================================================
-- ======================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  11/01/2013
-- Description:	Risolto baco relativo al Settore concatenato alla Gestione Applicativa
-- ======================================================================
-- ==================================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  24/04/2013
-- Description: Eliminata gestione agricoli su campo CIda e aggiunta gestione aurea, commentate le group by
-- ==================================================================================
-- ==================================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  16-05-2013
-- Description: Aggiunta gestione applicativa su codice aurea e tipo posizione
-- ==================================================================================
-- ==================================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  13-06-2013
-- Description: data evento non più da auvas ma da aupo_data_ultimo_stato
-- ==================================================================================
-- ==================================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  20-06-2013
-- Description: eliminata dalla griglia colonna riferimenti madre figlia
-- ==================================================================================
-- ==================================================================================
-- Modificata da:  Letizia Bellantoni
-- Data modifica:  20-06-2014
-- Description: aggiunto campo 	AS DB_DenominazioneAzienda
-- ==================================================================================
CREATE procedure [dbo].[AZ_GetPosizionePerChiave]
    @criterioRicerca tinyint,
	@codicePK int,
	@matricola varchar(50),
	@cida varchar(10)
AS
BEGIN

SET NOCOUNT ON;

--criterio di ricerca 0 per codice AUPOC e Codice di Controllo
IF @criterioRicerca=0
BEGIN
	SELECT     
		tb_aupoc_pos_contr.aupoc_codice_pk			AS DB_CodicePosizione,
		tb_aupoc_pos_contr.aupoc_contro_codice		AS DB_ControCodPosizione,
		tb_aupoc_pos_contr.aupoc_denom_posiz_contr	AS DB_DenominazioneAzienda,
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
        
        
        
        -- Maurizio 23/5/2012
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
	
	LEFT JOIN [dbo].[tb_aurpp_rel_poc_poc]
	on [dbo].[tb_aurpp_rel_poc_poc].aurpp_codice_pk = @codicePK

	
	--Aggiunto da Letizia 10/12/2012
	LEFT OUTER JOIN tb_aupco_periodo_contr ON 
	tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk AND
	convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
		
	LEFT OUTER JOIN tb_aucsc_cod_stat_contr_ct
	on aupco_cod_stat_contr=tb_aucsc_cod_stat_contr_ct.aucsc_codice
	--fine Letizia 10/12/2012


	WHERE tb_aupoc_pos_contr.aupoc_codice_pk = @codicePK 

	
END

--criterioRicerca=2 , ricerca per matricola
ELSE IF @criterioRicerca=2
BEGIN
	SELECT     
			tb_aupoc_pos_contr.aupoc_codice_pk			AS DB_CodicePosizione,
			tb_aupoc_pos_contr.aupoc_contro_codice		AS DB_ControCodPosizione,
			tb_aupoc_pos_contr.aupoc_denom_posiz_contr	AS DB_DenominazioneAzienda,
			--CONVERT(varchar(20),aupoc_codice_pk) + isnull(tb_aupoc_pos_contr.aupoc_contro_codice,'') as DB_IdPosContr,
			RIGHT( '0000000000'+ CONVERT(varchar(20),aupoc_codice_pk),10)+ isnull(tb_aupoc_pos_contr.aupoc_contro_codice,'') as DB_IdPosContr,
			tb_aupoc_pos_contr.aupoc_posizione			AS DB_PosizioneContributiva,
			tb_ausin_sedi_inps_ct.ausin_codice_sede + ' - '+  tb_ausin_sedi_inps_ct.ausin_descr As DB_Sede,
			tb_aupoc_pos_contr.aupoc_aurea_codice_pk    AS DB_CodiceAurea,
			
		--Letizia 16/05/2013 la gestione applicata è su tb_aurea,aggiunto campo tipo posizione
			
	    --Letizia 16/05/2013 la gestione applicata è su tb_aurea,aggiunto campo tipo posizione
			
		--case 
		--when (tb_aurea_area_gestione.aurea_codice_pk <> 1  and aupoc_tipo_posizione=1)  
		--then tb_aurea_area_gestione.aurea_descrizione  + ' Autonomo'
		
		--when (tb_aurea_area_gestione.aurea_codice_pk <> 1  and aupoc_tipo_posizione=0)  
		--then tb_aurea_area_gestione.aurea_descrizione  + ' Datore Lavoro'
				
		----solo nel caso codice aurea 1
		--when ( tb_aurea_area_gestione.aurea_codice_pk = 1 )
		--then tb_auapp_appl.auapp_descr  +  isNull( ' - '+ substring([aucsc_settore],4,LEN([aucsc_settore])),'')
	
		--end AS DB_GestioneContributiva,
		--fine modifica Letizia 16/05/2013
		tb_aurea_area_gestione.aurea_descrizione AS DB_GestioneContributiva,
		
		tb_auspc_stato_pos_contr_ct.auspc_descr		AS DB_Stato,
		
		 --Letizia 17/05/2005
		convert(varchar(10),tb_aupoc_pos_contr.aupoc_data_inizio_attivita,103)  as DB_DataInizio,
		
		--(
		--select convert(varchar(10),max(auvas_data_variazione_stato),103) from 
		--dbo.tb_auvas_var_stato_pos
		--where tb_auvas_var_stato_pos.auvas_aupoc_codice_pk=tb_aupoc_pos_contr.aupoc_codice_pk
		--and  tb_auvas_var_stato_pos.auvas_auspc_codice_pk=tb_aupoc_pos_contr.aupoc_auspc_codice_pk
		--) as DB_DataEvento,
		
        --Letizia Fine 17/05/2005
        
        --Letizia 13/0/2013
        convert(varchar(10),aupoc_data_ultimo_stato,103)  as DB_DataEvento
        --Letizia 13/0/2013
        
	    -- Maurizio 23/5/2012
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
		--	right(tb_aupoc_pos_contr.aupoc_cod_sede_INPS,4)=tb_ausin_sedi_inps_ct.ausin_codice_sede
		--Modificato da Letizia 06/12/2012
	    aupoc_ausin_codice_pk=tb_ausin_sedi_inps_ct.ausin_codice_pk
		
		LEFT JOIN [dbo].[tb_aurpp_rel_poc_poc]
		on [dbo].[tb_aurpp_rel_poc_poc].aurpp_codice_pk = @codicePK

	   --Aggiunto da Letizia 10/12/2012
		LEFT OUTER JOIN tb_aupco_periodo_contr ON 
		tb_aupoc_pos_contr.aupoc_codice_pk = tb_aupco_periodo_contr.aupco_aupoc_codice_pk AND
		convert(date,GETDATE(),103) BETWEEN aupco_data_inizio_validita AND aupco_data_fine_validita
			
		LEFT OUTER JOIN tb_aucsc_cod_stat_contr_ct
		on aupco_cod_stat_contr=tb_aucsc_cod_stat_contr_ct.aucsc_codice
		--fine Letizia 10/12/2012

		WHERE tb_aupoc_pos_contr.aupoc_posizione	= @matricola 
		
	

end
end


